module KPIAgeGender

include("data_access.jl")

using DataFrames, StatPlots

plotly() # Plotting Front-end

#Global variables
DA = DataAccess
youngMalesHappinessCount = 0

function run_kpi()
    data = DA.query_all()

    cleanData = structure_data(data)
    plot_data(cleanData)
end


function structure_data(data::DataFrames.DataFrame)
    #sum_happiness = 0
    #for item in data[:Age]
    #    sum_happiness += item
    #return data
    print("structuring tony's data")
    print(data)

    return data

end

function plot_data(data::DataFrames.DataFrame)

end

end
