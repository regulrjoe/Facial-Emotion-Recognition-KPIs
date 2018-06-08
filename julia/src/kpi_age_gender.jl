module KPIAgeGender

using DataFrames, StatPlots

plotly() # Plotting Front-end

function run_kpi(data::DataFrames.DataFrame)
    cleanData = structure_data(data)
    plot_data(cleanData)
end

function structure_data(data::DataFrames.DataFrame)
    sum_happiness = 0
    for item in data[:Age]
        sum_happiness += item
    return data
end

function plot_data(data::DataFrames.DataFrame)

end

end
