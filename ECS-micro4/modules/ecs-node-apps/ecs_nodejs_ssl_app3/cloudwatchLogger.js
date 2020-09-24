const winston = require('winston');
//const CloudWatchTransport = require('winston-aws-cloudwatch');

//var NODE_ENV = process.env.NODE_ENV || 'winstondev';


const logger = winston.createLogger({});

logger.add(new winston.transports.Console({
    format: winston.format.simple()
}));


logger.level = process.env.LOG_LEVEL || "silly";

logger.stream = {
  write: function(message, encoding) {
    logger.info(message);
  }
};

module.exports = logger;
