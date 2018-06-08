module DataAccess

using DataFrames, Mongo, LibBSON

function read_csv()
    data = readtable("data/faces.csv")
    return copy(data)
end

function query_realtime(dt_from::DateTime)
    client = MongoClient()
    faces = MongoCollection(client, "fer", "faces")
    df = DataFrame(Emotion = String[], DateTime = DateTime[])

    for doc in find(faces, query("DateTime" => gt(dt_from)))
        df = vcat(df, DataFrame(Emotion = doc["Emotion"], DateTime = doc["DateTime"]))
    end

    return df
end

end
