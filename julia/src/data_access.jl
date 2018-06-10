module DataAccess

using DataFrames, Mongo, LibBSON

# Global variables
client = MongoClient()
faces = MongoCollection(client, "fer", "faces")

function read_csv()
    data = readtable("data/faces.csv")
    return copy(data)
end

function query_realtime(dt_from::DateTime)
    df = DataFrame(Emotion = String[], DateTime = DateTime[])

    for doc in find(faces, query("Date" => gt(dt_from)))
        df = vcat(df, DataFrame(Emotion = doc["Emotion"], DateTime = doc["Date"]))
    end

    return df
end

function query_all()
    df = DataFrame(Emotion = String[], Gender = String[], Age = Number[], DateTime = DateTime[])

    for doc in find(faces, query())
        df = vcat(df, DataFrame(Emotion = doc["Emotion"], Gender = doc["Gender"], Age = doc["Age"], DateTime = doc["Date"]))
    end
    return df
end

end
