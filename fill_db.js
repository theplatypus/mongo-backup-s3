const generateRandomObjects = (n) => {
    const randomObjects = [];
    for (let i = 0; i < n; i++) {
        const randomObject = {
            field1: Math.random().toString(36).substring(10),
            field2: Math.floor(Math.random() * 100),
            field3: new Date(),
        };
        randomObjects.push(randomObject);
    }
    return randomObjects;
};

const fillCollectionWithRandomObjects = (db, collectionName, n) => {
    const collection = db[collectionName];
    const randomObjects = generateRandomObjects(n);
    collection.insertMany(randomObjects, (err, result) => {
        if (err) {
            console.error("Error inserting documents:", err);
        } else {
            console.log("Inserted documents:", result.insertedCount);
        }
    });
};

const generateIris = (n) => {
    const randomObjects = [];
    const speciesArray = ["setosa", "versicolor", "virginica"];

    for (let i = 0; i < n; i++) {
        const randomObject = {
            sepalLength: (Math.random() * (7.9 - 4.3) + 4.3).toFixed(1),
            sepalWidth: (Math.random() * (4.4 - 2.0) + 2.0).toFixed(1),
            petalLength: (Math.random() * (6.9 - 1.0) + 1.0).toFixed(1),
            petalWidth: (Math.random() * (2.5 - 0.1) + 0.1).toFixed(1),
            species: speciesArray[Math.floor(Math.random() * speciesArray.length)]
        };
        randomObjects.push(randomObject);
    }
    return randomObjects;
};

const fillIris = (db, collectionName = 'iris', n = 10_000) => {
    const collection = db[collectionName];
    const randomObjects = generateIris(n);
    collection.insertMany(randomObjects, (err, result) => {
        if (err) {
            console.error("Error inserting documents:", err);
        } else {
            console.log("Inserted documents:", result.insertedCount);
        }
    });
};

fillCollectionWithRandomObjects(db, 'foo', 1_000);
fillIris(db);

// Usage example
// const n = 10; // Number of random objects
// const db = yourMongoDbInstance;
// fillCollectionWithRandomObjects(db, 'yourCollectionName', n);
