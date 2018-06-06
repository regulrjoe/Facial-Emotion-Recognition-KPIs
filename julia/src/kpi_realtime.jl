module KPIRealTime

using DataFrames, StatPlots

plotly() # Plotting Front-end

emotions = ["Anger", "Contempt", "Disgust", "Fear", "Happiness", "Neutral", "Sadness", "Surprise"]

function run_kpi(last_x_minutes::Number = 30)
    data_dict = structure_data(data, last_x_minutes)
    plot_data(data_dict)
end

function structure_data(data::DataFrames.DataFrame, m::Number)
    # Map datetime from string to Datetime object
    data[:Date] = map(d -> Dates.DateTime(d, "yyyy-mm-dd HH:MM:SS"), data[:Date])
    # Create new column with time difference in milliseconds between row's datetime and current datetime
    data[:TimeDiffMS] = map(d -> Dates.value(Dates.now() - d), data[:Date])
    # Filter only the relevant columns from the data within the last m minutes
    rt_data = data[data[:TimeDiffMS] .<= m * 60 * 10^3], [:Emotion, :Date]]
    # Create dict with a different dataframe for each emotion
    data_dict = Dict{String, DataFrames.DataFrame}()
    for e in emotions
        data_dict[e] = rt_data[rt_data[:Emotion] .== e, :] # Filter rows per emotion

    return data_dict
end

function plot_data(data::Dict{String, DataFrames.DataFrame})

end

end
