#include("src/kpi_age_gender.jl")
include("src/kpi_avgperhour.jl")
include("src/kpi_realtime.jl")

function run_kpis(rt_seconds::Number = 2, rt_last_x_minutes::Number = 5, range_of_hours::UnitRange{Int64} = 8:16)
    KPI1 = KPIRealTime
    KPI2 = KPIAvgPerHour
    # KPI3 = KPIAgeGender

    # Run one-time KPIs
    KPI2.run_kpi(range_of_hours)
    # KPI3.run_kpi(data)

    KPI1.run_kpi(rt_seconds, rt_last_x_minutes)
end

# run_kpis(2, 10, 8:16)
