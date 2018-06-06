import pymongo, csv, os, time
from pymongo import MongoClient

client = MongoClient()
db = client.fer
faces = db.faces

fields = ['Id', 'Age', 'Gender', 'Emotion', 'Date', 'Hour', 'Minute', 'Second']

while True:
    cursor = faces.find()
    with open("../data/faces.csv", "w") as outfile:
        writer = csv.DictWriter(outfile, fields)
        writer.writeheader()
        for x in cursor:
            row = {
                'Id': x['Id'],
                'Age': x['Age']['$numberDouble'],
                'Gender': x['Gender'],
                'Emotion': x['Emotion'],
                'Date': x['Date'],
                'Hour': x['Time']['h'],
                'Minute': x['Time']['m'],
                'Second': x['Time']['s']
            }
            writer.writerow(row)
    time.sleep(1)
