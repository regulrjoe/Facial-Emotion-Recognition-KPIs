using Mongo, LibBSON

client = MongoClient()

reactions = MongoCollection(client, "fer", "faces")
