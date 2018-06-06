using Mongo, LibBSON

client = MongoClient()

reactions = MongoCollection(client, "db", "reactions")
