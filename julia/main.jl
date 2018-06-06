module Main

include("src/kpi_age_gender.jl")
include("src/kpi_avgperhour.jl")
include("src/kpi_realtime.jl")
include("src/data_access.jl")

function run_kpis(rt_seconds::Number = 5, rt_last_x_minutes::Number = 30)
    DA = DataAccess
    KPI1 = KPIRealTime
    KPI2 = KPIAvgPerHour
    KPI3 = KPIAgeGender

    # Get Data
    data = DA.read_csv()
    # Run one-time KPIs
    # KPI2.run_kpi(data)
    # KPI3.run_kpi(data)

    # Run continuous KPI
    while true
        # Run KPI
        KPI1.run_kpi(data, rt_last_x_minutes=30)
        # Wait n seconds
        sleep(rt_seconds)
        # Get Data
        data = DA.read_csv()
    end
end

end
