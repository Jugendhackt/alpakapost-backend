require('dotenv').config();

const express = require('express');

const database = require('./src/databaseManager').getInstance();

const app = express();

app.get('/locations', function (request, response) {
    database.getDatabase().query('SELECT * FROM hackerspaces', (err, results) => {
        if (err) throw err;

        response.json(results);
    });
});


database.establishConnection().then(function () {
    app.listen(8080, "127.0.0.1");
});