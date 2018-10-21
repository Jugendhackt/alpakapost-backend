/**
 * This file is responsible for providing easy to use Loggers,
 * with an prefix for easier grouping to the components.
 *
 * @license GPL 3.0
 * @author Jens Hausdorf
 */

/**
 * Holds all singletons by their loggername
 * @type Map<string,Logger>
 */
const INITALIZED_LOGGERS = new Map();

class Logger {

    /**
     * @param {string} loggerName
     */
    constructor(loggerName) {
        this.loggerName = loggerName;
    }

    /**
     * @param {string} loggerName
     */
    static getInstance(loggerName) {
        // format the name of the logger to always ensure the first char is uppercased.
        // database => Database
        loggerName = loggerName.charAt(0).toUpperCase() + loggerName.slice(1);

        // check storage for already initalized instance.
        if (!INITALIZED_LOGGERS.has(loggerName)) {
            // it doesn't exist yet, so I'll guess we just create one ;)
            INITALIZED_LOGGERS.set(loggerName, new Logger(loggerName));
        }

        return INITALIZED_LOGGERS.get(loggerName);
    }

    doLog(logLevel = 'log', ...message) {
        message.unshift(`${this.loggerName.padStart(8)} --`);

        // FIXME: This logs an array but it is not useful most of the time.
        console[logLevel].apply(this, message);
    }

    warn(...message) {
        message.unshift('WARN');
        this.doLog('warn', message);
    }

    error(...message) {
        message.unshift('ERROR');
        this.doLog('error', message);
    }

    log(...message) {
        this.doLog('log', message);
    }
}

module.exports = Logger;