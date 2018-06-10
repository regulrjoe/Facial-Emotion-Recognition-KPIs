module KPIAgeGender

include("data_access.jl")

using DataFrames, StatPlots

plotly() # Plotting Front-end

#Global variables
DA = DataAccess
young_male_anger_count = 0

function run_kpi()
    data = DA.query_all()

    cleanData = structure_data(data)
    plot_data()
end


function structure_data(data::DataFrames.DataFrame)
    #sum_happiness = 0
    #for item in data[:Age]
    #    sum_happiness += item
    #return data
    print("structuring tony's data")
    println(data)
    showcols(data)
    nrows, ncols = size(data)
    println(nrows)
    println(ncols)
    println(length(data))

    young_males = get_by_gender(get_youngsters(data), "male")
    young_females = get_by_gender(get_youngsters(data), "female")
    old_males = get_by_gender(get_adults(data), "male")
    old_females = get_by_gender(get_adults(data), "female")

    println(old_females)

    return data

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


function plot_data()

end

end
