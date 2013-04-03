exports.authMethod = '[authType]';
exports.authRequired = true;

var sitePort = '8085';
exports.sitePort = sitePort;

var siteURL = 'http://localhost';
if (sitePort != '') siteURL += ':'+sitePort;
exports.siteURL = siteURL;



//// Setup which storage options we have:
var DATASTORE_MYSQL = 'mysql';
var DATASTORE_MEMORY = 'memory';
exports.DATASTORE_MYSQL = DATASTORE_MYSQL;
exports.DATASTORE_MEMORY = DATASTORE_MEMORY;



// Now indicate which method we are using on this site:
exports.dataStoreMethod = DATASTORE_MYSQL;



//// Session
exports.sessionSecret = 'th3re is n0 sPoOn';


//// DB specific info setup:
exports.dbName = '[dbName]';
exports.dbUser = '[dbUser]';
exports.dbPword = '[dbPword]';
exports.dbPath = [dbPath];  // '127.0.0.1'
exports.dbPort = '[dbPort]'; // 3306



exports.setup = function (req, res, next) {
/// simply make sure our req.aRAD.* data structures are created

Log(req, '   - defaults.setup()');
Log(req, '   req.url['+req.originalUrl+']');

    if (typeof req.aRAD == 'undefined') req.aRAD = {};
    if (typeof req.aRAD.response == 'undefined') {
        req.aRAD.response = {};
        req.aRAD.response.listJavascripts = [];
        req.aRAD.response.listJavascripts.push['/scripts/phpDashboard/phpDashboard.js'];
        req.aRAD.response.siteURL = siteURL;
    }
    next();
}