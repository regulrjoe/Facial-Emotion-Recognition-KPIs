module KPIAgeGender

include("data_access.jl")

using DataFrames, PlotlyJS

#plotly() # Plotting Front-end

#Global variables
DA = DataAccess
emotions = ["Anger", "Contempt", "Disgust", "Fear", "Happiness", "Neutral", "Sadness", "Surprise"]

function run_kpi()
    data = DA.query_all()

    data_tuple = structure_data(data)
    plot_data(data_tuple)
end


function structure_data(data::DataFrames.DataFrame)
    young_males = get_by_gender(get_youngsters(data), "male")
    young_females = get_by_gender(get_youngsters(data), "female")
    old_males = get_by_gender(get_adults(data), "male")
    old_females = get_by_gender(get_adults(data), "female")

    #Count repetitions for each emotion, on each group
    young_male_counts = count_emotions(young_males)
    young_female_counts = count_emotions(young_females)
    old_male_counts = count_emotions(old_males)
    old_female_counts = count_emotions(old_females)

    return (young_male_counts, young_female_counts, old_male_counts, old_female_counts)

end

function get_youngsters(all_people::DataFrames.DataFrame)
    return all_people[all_people[:Age] .< 30, :]
end

function get_adults(all_people::DataFrames.DataFrame)
    return all_people[all_people[:Age] .> 29, :]
end

function get_by_gender(all_humans::DataFrames.DataFrame, gender::String)
    return all_humans[all_humans[:Gender] .== gender, :]
end

function get_emotion_count(data_frame::DataFrames.DataFrame, emotion::String)
    counter = 0
    for item in data_frame[:Emotion]
        if item .== emotion
            counter += 1
        end
    end
    return counter
end

function count_emotions(data::DataFrames.DataFrame)
    array = zeros(length(emotions))
    for i = 1:length(emotions)
        array[i] = get_emotion_count(data, emotions[i])
    end
    return array
end


function plot_data(tuple::NTuple{4,Array{Float64,1}})
    plots = [
    pie(values=tuple[1], labels=emotions, domain_x=[0, 0.48], domain_y=[0, 0.49], name="Males 0-29"),
    pie(values=tuple[2], labels=emotions, domain_x=[0.52, 1], domain_y=[0, 0.49], name="Females 0-29"),
    pie(values=tuple[3], labels=emotions, domain_x=[0, 0.48], domain_y=[0.51, 1], name="Males 30 and older"),
    pie(values=tuple[4], labels=emotions, domain_x=[0.52, 1], domain_y=[0.52, 1], name="Females 30 and older")
    ]

    layout = Layout(
    title = "Pie charts",
    #annotations = [(font_size = 14, showarrow = false, text = "Males 0-29", x = 0.17, y = 0.5), (font_size = 14, showarrow = false, text = "Females 0-29", x = 0.82, y = 0.5)]
    )
    plt = plot(plots, layout)
    display(plt)
end

end
