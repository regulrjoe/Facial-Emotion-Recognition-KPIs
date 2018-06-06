# FERProject
Visualización de los KPIs del proyecto FER (Facial Emotion Recognition) de la clase de Business Intelligence con Julia.

## Algoritmo

### Paso 1 - Consumir de Mongo

```
using Mongo, LibBSON

# Crear conexión a cliente
client = MongoClient() # default localhost:27017

# Consume de la base de datos
cats = MongoCollection(client, "db", "cats")

#### Query Syntax

```
Dict("\$query" => Dict("age" => Dict("$lt" => 19)))
```

```
# Imprime todos los gatos menores a 19 años
for doc in find(cats, query("age" => lt(19)))
  println("$(doc["name"]) is younger than 19")
end
```

### Paso 2 - Estructurar datos

### Paso 3 - Mostrar datos en Plots
