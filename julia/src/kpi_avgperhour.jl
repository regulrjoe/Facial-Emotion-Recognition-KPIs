module KPIAvgPerHour

include("data_access.jl")

using DataFrames, PlotlyJS

# Global variables
DA = DataAccess
emotions = ["Anger", "Contempt", "Disgust", "Fear", "Happiness", "Neutral", "Sadness", "Surprise"]

function run_kpi(range_of_hours::UnitRange{Int64})
    println("\nRunning KPI AvgPerHour...")
    # Query from Mongo
    data = get_data()
    # Structure data for plotting
    data_tuple = structure_data(data, range_of_hours)
    # Plot the data
    plot_data(data_tuple[1], data_tuple[2])
end

function get_data()
    println("\nGetting data from Mongo...")
    return DA.query_all()
end

function structure_data(data::DataFrames.DataFrame, range::UnitRange{Int64})
    println("\nStructuring data...")

    # Lapse of time in hours
    range_length = length(range)

    # Amount of unique days with data registered
    n_days = length(unique(Dates.Date.(data[:DateTime])))

    # Map datetime to hour only
    data[:DateTime] = map(d -> Dates.Hour(d), data[:DateTime])

    # Count entries by emotion and hour, add count to new column, and sort by time and emotion
    data = by(data, [:Emotion, :DateTime], nrow)
    data = sort!(data, [order(:DateTime), order(:Emotion)])

    # Create Matrices to be used in plotting
    X_Time = Array{Int64}(range_length) # X-axis: Time
    Y_EmotionAvgs = zeros(range_length, length(emotions)) # Y-axis: Avg count of emotions, 1 column per emotion
    for i = 1:range_length
        X_Time[i] = Dates.value(Dates.Hour(range[i]))
        for j = 1:length(emotions)
            ij_count = data[(data[:DateTime] .== Dates.Hour(X_Time[i])) .& (data[:Emotion] .== emotions[j]), :x1]
            if !isempty(ij_count)
                Y_EmotionAvgs[i,j] = sum(ij_count) / n_days
            end
        end
    end

    # Return tuple of matrices X and Y
    return (X_Time, Y_EmotionAvgs)
end

function plot_data(X::Array{Int64, 1}, Y::Array{Float64, 2})
    # Create layout of plot
    layout = Layout(
        title=string("Emotion avg count per hour from ", X[1], " to ", X[end], "."),
        xaxis_title="Hour of Day",
        xaxis_tickvals=X,
        xaxis_ticktext=map(x -> string(x, ":00"), X),
        yaxis_title="Emotion Avg",
        barmode="stack",

    )
    # Create instance of traces for plot
    traces = Array{PlotlyBase.GenericTrace}(length(emotions))
    for i = 1:length(emotions)
        traces[i] = bar(x=X, y=Y[:,i], name=emotions[i])
    end
    # Create instance of plot
    plt = plot(traces, layout)

    # Show plot
    display(plt)
end

end
