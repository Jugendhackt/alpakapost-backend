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
const dijlkstra = require('./dijlkstra');

app.get('/route', async (req, res) => {
    let start_location_id = req.query.start_location_id;
    let destination_location_id = req.query.destination_location_id;

    if (!start_location_id || !destination_location_id) {
        res.json({
            error: true,
            error_message: "Missing required parameters"
        });
        return;
    }

    // do the magic
    let route_path = await dijlkstra(Number.parseInt(start_location_id), Number.parseInt(destination_location_id));

    // add start location to output for proper output
    route_path.unshift(Number.parseInt(start_location_id));

    if (route_path === void 0) {
        res.json({
            error: true,
            error_message: "No route found"
        });
        return;
    }

    // add start location to output for proper output
    route_path.unshift(Number.parseInt(start_location_id));

    let sql = 'SELECT * FROM hackerspaces WHERE hackerspace_id IN (?);'
    let output = [];

    database.getDatabase().query(sql, [route_path], (err, results) => {
        if (err) throw err;

        for (route_part of route_path) {
            let hackerspace = results.filter(x => x.hackerspace_id === route_part)[0];
            output.push(hackerspace);
        }

        res.json(output);
    });
});

// shows all possible locations goods can go from A to B.
app.get('/locations', function (request, response) {
    database.getDatabase().query('SELECT * FROM hackerspaces', (err, results) => {
        if (err) throw err;

        response.json(results);
    });
});

// shows all users with their data
app.get('/user', (req, res) => {
    database.getDatabase().query('SELECT * FROM user;', (err, results) => {
        if (err) throw err;

        res.json(results);
    });
});

// shows all goods that are waiting for delivery, including information on both stations
app.get('/goods', (req, res) => {
    let parameters = [];
    let sql = '';

    if (req.query.station_id) {
        sql = `SELECT hs.*, goods.*
        FROM goods
        LEFT JOIN hackerspaces hs ON hs.hackerspace_id = goods.start_location_id
        WHERE name LIKE ?`;
        parameters.push(`%${req.query.station_id}%`);
    } else if (req.query.good_id) {
        sql = `SELECT hs.*, goods.*
        FROM goods
        LEFT JOIN hackerspaces hs ON hs.hackerspace_id = goods.start_location_id
        WHERE good_id = ?`;
        parameters.push(Number.parseInt(req.query.good_id));
    } else if (req.query.user_id) {
        sql = `SELECT hs.*, goods.*
        FROM goods
        LEFT JOIN hackerspaces hs ON hs.hackerspace_id = goods.start_location_id
        WHERE user_id = ?`;
        parameters.push(Number.parseInt(req.query.user_id));
    } else {
        sql = `SELECT goods.*,
hs1.name hs1_name, hs1.logo_url hs1_logo_url, hs1.latitude hs1_latitude, hs1.longitude hs1_longitude,
hs2.name hs2_name, hs2.logo_url hs2_logo_url, hs2.latitude hs2_latitude, hs2.longitude hs2_longitude,
user.user_name
FROM goods
LEFT JOIN hackerspaces hs1 ON hs1.hackerspace_id = goods.start_location_id
LEFT JOIN hackerspaces hs2 ON hs2.hackerspace_id = goods.destination_location_id
LEFT JOIN user ON user.user_id = goods.user_id;`;
    }

    database.getDatabase().query(sql, parameters, (err, results) => {
        if (err) throw err;

        res.json(results);
    });
});

// shows all possible routes
app.get('/connections', (req, res) => {
    let sql = `SELECT
    hs1.name AS hs1_name, hs1.latitude AS hs1_latitude, hs1.longitude AS hs1_longitude,
    hs2.name AS hs2_name, hs2.latitude AS hs2_latitude, hs2.longitude AS hs2_longitude,
    connections.*, user.user_name
    FROM connections
    LEFT JOIN rides ON rides.connection_id = connections.connection_id
    LEFT JOIN user ON user.user_id = connections.user_id
    LEFT JOIN hackerspaces AS hs1 ON hs1.hackerspace_id = rides.start_location_id
    LEFT JOIN hackerspaces AS hs2 ON hs2.hackerspace_id = rides.destination_location_id;
    `;
    database.getDatabase().query(sql, (err, results) => {
        if (err) throw err;

        res.json(results);
    });
});

app.get('/tracking', (req, res) => {
    if (!req.query.good_id) {
        res.json({
            error: true,
            error_message: "Please provide an ID for the good."
        });
        return;
    }

    let good_id = Number.parseInt(req.query.good_id);

    database.getDatabase().query('SELECT * FROM tracking WHERE good_id = ?', [good_id], (err, results) => {
        if (err) throw err;

        // convert ISO timestamp of time to UNIX timestamp
        results = results.map(x => {
            x.time = Date.parse(x.time);
            return x;
        });

        res.json(results);
    });
});

// only serve the app as soon as we have database access.
database.establishConnection().then(function () {
    app.listen(8080, "0.0.0.0");
});