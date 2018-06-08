module KPIRealTime

include("data_access.jl")

using DataFrames, PlotlyJS

DA = DataAccess

emotions = ["Anger", "Contempt", "Disgust", "Fear", "Happiness", "Neutral", "Sadness", "Surprise"]


function run_kpi(seconds::Int64 = 5, last_x_minutes::Int64 = 30)
    # Create layout of plot
    layout = Layout(
        title=string("[", uppercase(Dates.dayname(Dates.now())), "] Emotions per ", seconds, " seconds from the last ", last_x_minutes, " minutes."),
        xaxis_title="Time",
        yaxis_title="Emotion Count")
    # Create instance of traces for plot
    traces = Array{PlotlyBase.GenericTrace}(length(emotions))
    for i = 1:length(emotions)
        traces[i] = scatter(name=emotions[i], mode="lines")
    end
    # Create instance of plot
    plt = plot(traces, layout)

    # Run the kpi
    while true
        println("\nRunning KPI...")
        # Get current datetime object
        dt_to = Dates.DateTime(Dates.now())
        # Get datetime object from m minutes back
        dt_from = dt_to - Dates.Minute(last_x_minutes)
        # Query from Mongo
        @time data = get_data(dt_from)
        # Structure data for plotting
        @time data_tuple = structure_data(data, seconds, Dates.Time(dt_from), Dates.Time(dt_to))
        # Plot the data
        @time plot_data(data_tuple[1], data_tuple[2], plt)
        # Wait n seconds
        sleep(seconds)
    end
end

function get_data(dt::DateTime)
    println("\nGetting data from Mongo...")
    return DA.query_realtime(dt)
end

function structure_data(data::DataFrames.DataFrame, s::Number, time_from::Dates.Time, time_to::Dates.Time)
    println("\nStructuring data...")
    # Lapse of time to visualize
    lapse_in_seconds = Dates.value(Dates.Second(time_to - time_from))
    tics = Int64(lapse_in_seconds / s)

    # Filter out the date and leave only the time
    data[:DateTime] = map(d -> Dates.Time(d), data[:DateTime])

    # Count entries by emotion and datetime, add count to new column, and sort by datetime and emotion
    data = by(data, [:Emotion, :DateTime], nrow)
    data = sort!(data, [order(:DateTime), order(:Emotion)])

    # Create Matrices to be used in plotting
    X_DateTime = Array{Base.Dates.Time}(tics)       # X-axis: Time
    Y_EmotionCounts = zeros(tics, length(emotions)) # Y-axis: Count of emotions, 1 column for each emotion
    for i = 1:tics
        X_DateTime[i] = time_from + (Dates.Second((i - 1) * s))
        for j = 1:length(emotions)
            ij_count = data[(data[:DateTime] .>= X_DateTime[i]) .& (data[:DateTime] .< X_DateTime[i] + Dates.Second(s)) .& (data[:Emotion] .== emotions[j]), :x1]
            if !isempty(ij_count)
                Y_EmotionCounts[i, j] = sum(ij_count)
            end
        end
    end

    # Return tuple of matrices X and Y
    return (X_DateTime, Y_EmotionCounts)
end

function plot_data(X::Array{Base.Dates.Time, 1}, Y::Array{Float64, 2}, plt::PlotlyJS.SyncPlot)
    println("\nPlotting data...")

    # Create a trace (line) for each emotion
    for i = 1:length(plt.plot.data)
        restyle!(plt, i, x=[X], y=[Y[:,i]])
    end

    display(plt)
end

end
