module DataAccess

using CSV

function read_csv()
    data = CSV.read("data/faces.csv")
end

end
