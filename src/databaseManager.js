const mysql = require('mysql');
const logger = require('./logger');
const DatabaseLogger = logger.getInstance('Database');

let INSTANCE = void 0;

class DatabaseManager {
    constructor(liveOptions = { verbose: true }) {
        this.host = process.env.MYSQL_HOST;
        this.user = process.env.MYSQL_USER;
        this.password = process.env.MYSQL_PASSWORD;
        this.database = process.env.MYSQL_DATABASE;
        this.liveOptions = liveOptions;

        if (this.host === void 0 || this.user === void 0 || this.password === void 0 || this.database === void 0) {
            DatabaseLogger.warn('One or more values are undefined, please check that they are defined in the .env file');
        }

        console.log(this);
    }


    /**
      * @returns Promise
      */
    establishConnection() {
        return new Promise((resolve, reject) => {
            this.connection = mysql.createConnection({
                host: this.host,
                user: this.user,
                password: this.password,
                database: this.database
            });
            this.connection.connect(err => {
                if (err) {
                    DatabaseLogger.error(`Failed to establish connection to database.`);
                    reject(err);
                    return;
                }
                if (this.liveOptions.verbose) {
                    DatabaseLogger.log(`Successfully established connection to database at ${new Date().toLocaleTimeString()}.`);
                }
                resolve();
            });
        });
    }

    queryPromisify(sql, params) {
        return new Promise((resolve, reject) => {
            this.getDatabase().query(sql, params, (err) => {
                if (err) {
                    reject(err);
                    return;
                }

                resolve();
            })
        });
    }

    beginTransactionPromisify() {
        return new Promise((resolve, reject) => {
            this.getDatabase().beginTransaction(null, err => {
                if (err) {
                    reject(err);
                    return;
                }

                resolve();
            })
        });
    }

    commitPromisify() {
        return new Promise((resolve, reject) => {
            this.getDatabase().commit(null, err => {
                if (err) {
                    reject(err);
                    return;
                }

                resolve();
            })
        });
    }

    /**
     * @returns DatabaseManager
     */
    static getInstance(...args) {
        if (INSTANCE === void 0) {
            INSTANCE = new DatabaseManager(args);
        }

        return INSTANCE;
    }

    /**
     * @returns typeof mysql.Connection
     */
    getDatabase() {
        return this.connection;
    }
}

module.exports = DatabaseManager;