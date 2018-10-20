/**
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
        loggerName = loggerName.charAt(0).toUpperCase() + loggerName.slice(1);
        if (!INITALIZED_LOGGERS.has(loggerName)) {
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