/**
 * This file is respnsible for starting the actual webservice,
 * serving all the APIs.
 *
 * @license GPL 3.0
 * @author Jens Hausdorf
 */

// load .env file into process.env.*
require('dotenv').config();

const express = require('express');
const database = require('./src/databaseManager').getInstance({ verbose: true });
const app = express();

// shows all possible locations goods can go from A to B.
app.get('/locations', function (request, response) {
    database.getDatabase().query('SELECT * FROM hackerspaces', (err, results) => {
        if (err) throw err;

        response.json(results);
    });
});

// only serve the app as soon as we have database access.
database.establishConnection().then(function () {
    app.listen(8080, "127.0.0.1");
});