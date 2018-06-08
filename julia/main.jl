#include("src/kpi_age_gender.jl")
#include("src/kpi_avgperhour.jl")
include("src/kpi_realtime.jl")

function run_kpis(rt_seconds::Number = 5, rt_last_x_minutes::Number = 30)
    KPI1 = KPIRealTime
    # KPI2 = KPIAvgPerHour
    # KPI3 = KPIAgeGender

    # Run one-time KPIs
    # KPI2.run_kpi(data)
    # KPI3.run_kpi(data)

    KPI1.run_kpi(rt_seconds, rt_last_x_minutes)
end

run_kpis(2, 10)
