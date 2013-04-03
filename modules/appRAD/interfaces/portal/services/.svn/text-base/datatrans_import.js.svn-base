
////
//// Data Translations Import
////
//// This service is designed to apply translations from a gettext (.PO) 
//// file onto one or more multilingual tables (*_trans) in the database.
////
//// A .po label will only be imported if the `msgid` value currently exists
//// in the table. For example we have this gettext pair for `en` to `zh-hans`:
////   msgid "China"
////   msgstr "中国"
//// The `msgstr` will only be imported if there is a *_trans entry like so:
////   country_id: 123
////   country_label: "China"
////   language_code: "en"
//// This allows you to use all sorts of 3rd party generic .po files and
//// still import only the labels that are actually needed.
////
//// If you need to do a straight import rather than translation, you should
//// use command line MySQL instead of this service.
////
//// SECURITY NOTE:
////    This service will potentially modify the contents of all *_label fields
////    in all *_trans tables. The imports are done through direct SQL, so this
////    will bypass any field permissions checking done at the Model level.
////    However, permissions checking at the Service level can still be done.
////    Make sure you assign permissions only to users that are allowed to 
////    modify all *_trans tables.
////
////    /appRad/datatrans/import   : tables=T & destLang=X [& srcLang=Y] 
////                                & fileSrc=Z [& excludeTables=U]
////                                [& dbName=D] [& dbUser=E] [& dbPword=F] 
////                                [& dbPort=G] [& dbPath=H]
////        Creates a new .po file:  
////                    as specified by [Z], relative to the appDev root.
////
//// 
////   tables: A comma separated list of table name patterns to include.
////       Tables whose names contain any of the patterns, and also end 
////       in _trans, will be updated.
////   excludeTables: (optional) A comma separated list of table name patterns
////       to exclude. Tables whose names contain any of the patterns will not 
////       be updated.
////   destLang: The code of the destination language to be translated to.
////   srcLang: (optional) The code of the source language to be translated
////       from. The default site language will be used if nothing is specified.
////   fileSrc: The gettext file to import. The path should be relative to 
////       the appDev root.
////   dbName: (optional) The name of the database to modify. Default is 
////       the current appDev database.
////   dbPath: (optional) The database host.
////   dbUser: (optional) The database user.
////   dbPword: (optional) The database user's password.
////   
//// The gettext file must have a .po extension.
////

//// Import [zh-Hans] data translations into the HRIS Test site
// test.dodomail.net:14001/appRad/datatrans/import?tables=hris&excludeTables=hris_ren,hris_attachment,hris_medical,hris_education,hris_emergency,hris_interest,hris_phone,hris_talent,hris_version&destLang=zh-Hans&srcLang=en&fileSrc=hris_data_trans-zh-Hans.po&dbName=test_hris

//// Import [ko] data translations into the HRIS Test site
// test.dodomail.net:14001/appRad/datatrans/import?tables=hris&excludeTables=hris_ren,hris_attachment,hris_medical,hris_education,hris_emergency,hris_interest,hris_phone,hris_talent,hris_version&destLang=ko&srcLang=en&fileSrc=hris_data_trans-ko.po&dbName=test_hris

/**
 * Verify that the current viewer has permission to export translations
 */
var hasPermission = function (req, res, next) 
{

    // if viewer has 'appRAD.Developer' action
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

}



/**
 * Go through an Express req object and return a PHP $_REQUEST style
 * assosiative array.
 *
 * Priority:
 *  1. req.params -- from the path
 *  2. req.body   -- from POST
 *  3. req.query  -- from GET
 *
 * @param object req
 * @return object
 *      Associative array like $_REQUEST
 */
var parseReqParams = function(req) 
{
    var $_REQUEST = {};
    var sets = [ 'params', 'body', 'query' ];
    for (var i=0; i<sets.length; i++) {
        for (var paramName in req[ sets[i] ]) {
            if (typeof $_REQUEST[ paramName ] == 'undefined') {
                $_REQUEST[ paramName ] = req[ sets[i] ][ paramName ];
            }
        }
    }
    
    return $_REQUEST;
}


// Helper function that converts a comma separated string into an array
var paramToArray = function(param) 
{
    if (!param) {
        // undefined, or empty
        return [];
    }
    else if (param.indexOf(',') >= 0) {
        // comma separated string
        return param.split(',');
    } 
    else {
        // single parameter
        return [ param ];
    }
}


/**
 * Initialize the DB interface that will be used to do the export.
 */
var initDB = function(req, res, next) 
{
    //// Local variables
    
    // Source and destination language codes
    req.aRAD._langSrc;
    req.aRAD._langDest;
    
    // Tables to be imported
    req.aRAD._tables;
    req.aRAD._excludeTables;
    req.aRAD._finalTables;
    
    // File path to import
    req.aRAD._fileSrc;
    
    // Container array for the final import data
    req.aRAD._importData;
    
    req.aRAD._importDB;
    
    
    var sql = '';
    var $_REQUEST = parseReqParams(req);
    
    // User is exporting tables from a different database
    if ($_REQUEST['dbName']) {
        var dbSettings = {
            dbUser: '',
            dbPword: '',
            dbPath: '',
            dbPort: ''
        };
        for (var setting in dbSettings) {
            if ($_REQUEST[setting]) {
                // User can pass in settings for connecting to the database
                dbSettings[setting] = $_REQUEST[setting];
            } else {
                // Otherwise just use the normal default settings
                dbSettings[setting] = AD.Defaults[setting];
            }
        }
        req.aRAD._importDB = require('mysql').createClient({
            user: dbSettings['dbUser'],
            password: dbSettings['dbPword'],
            host: dbSettings['dbPath'],
            port: dbSettings['dbPort']
        });
        sql = "USE " + $_REQUEST['dbName'];
    }
    
    // User is exporting tables from the current appDev database
    else {
        req.aRAD._importDB = require('database.js').sharedDB();
        sql = "USE " + AD.Defaults.dbName;
    }
    
    req.aRAD._importDB.query(sql, [], function(err, results, fields) {
        if (err) {
            AD.Comm.Service.sendError(req, res, { errorMSG: err.message });
            return;
        }
        
        next();
    });

}


/**
 * Parse the service parameters, and initialize the local variables.
 */
var initData = function(req, res, next) 
{
    // Gather the required Data for this operation.
    var $_REQUEST = parseReqParams(req);
    req.aRAD._importData = [];

    try {
        
        //// Language options
        req.aRAD._langSrc = $_REQUEST['srcLang'];
        req.aRAD._langDest = $_REQUEST['destLang'];
        if (!req.aRAD._langDest) {
            throw "Destination language (destLang) was not provided";
        }
        // Find the default site language if needed
        if (!req.aRAD._langSrc) {
            if (AD.Defaults.langDefault) {
                req.aRAD._langSrc = AD.Defaults.langDefault;
            } else {
                req.aRAD._langSrc = 'en';
            }
        }
        
        
        //// File options
        req.aRAD._fileSrc = $_REQUEST['fileSrc'];
        if (!req.aRAD._fileSrc) {
            throw "Source file (fileSrc) was not provided";
        }
        if (req.aRAD._fileSrc[0] != '/') {
            req.aRAD._fileSrc = __appdevPath + '/' + req.aRAD._fileSrc;
        }
        // Make sure file exists
        if (!path.existsSync(req.aRAD._fileSrc)) {
            throw "Source file [" + req.aRAD._fileSrc + "] does not exist";
        }
        // Make sure directory is within appDev hierarchy
        var realPath = fs.realpathSync(req.aRAD._fileSrc);
        if (realPath.indexOf(fs.realpathSync(__appdevPath)) != 0) {
            throw "Source file (fileSrc) must be within the appDev hierarchy";
        }
        // Make sure the file has a .po extension.
        if (!req.aRAD._fileSrc.match(/\.po$/)) {
            throw "Source file (fileSrc) must have a .po extension";
        }

        
        //// Table options
        req.aRAD._finalTables = [];
        req.aRAD._tables = paramToArray($_REQUEST['tables']);
        req.aRAD._excludeTables = paramToArray($_REQUEST['excludeTables']);
        if (!req.aRAD._tables[0]) {
            throw "Tables (tables) were not provided";
        }
        
        
        //// Done
        next();
    }

    catch (err) {
        // The thrown error is a string. Just report it to the client.
        if (typeof err == 'string') {
            console.error(err);
            AD.Comm.Service.sendError(req, res, {errorMSG: err});
            return;
        }
        else {
            throw err;
        }
    }
}


/**
 * Read the .po file.
 * This will be temporarily stored in `req.aRAD._importData` for parsing
 */
var readFile = function(req, res, next) 
{
    fs.readFile(req.aRAD._fileSrc, 'utf8', function(err, data) {
        if (err) {
            AD.Comm.Service.sendError(req, res, {errorMSG: err.message});
            return;
        } else {
            req.aRAD._importData = data;
            next();
            return;
        }
    });
}


/**
 * Parse the .po file.
 * This will be stored in `req.aRAD._importData` in the following format:
 * {
 *     msgid1: msgstr1,
 *     msgid2: msgstr2,
 *     "China": "中国",
 *     ...
 * }
 */
var parseData = function(req, res, next) 
{
    var parsedData = {};
    
    // Split the import data into an array of msgid/msgstr pairs
    // It's too bad that Javascript regex can't do multiline global AND capture
    // matches at the same time.
    var pairs = req.aRAD._importData.match(/^\s*msgid\s+"(.+?)"\s*\n\s*msgstr\s+"(.+?)"\s*$/gm);
    for (var i=0; i<pairs.length; i++) {
        // Extract the msgid and msgstr values from each pair
        var matches = pairs[i].match(/^\s*msgid\s+"(.+?)"\s*\n\s*msgstr\s+"(.+?)"\s*$/);
        var srcLabel = matches[1];
        var destLabel = matches[2];
        if (srcLabel && destLabel) {
            parsedData[ srcLabel ] = destLabel;
        }
    }
    
    req.aRAD._importData = parsedData;
    next();
}


/**
 * Get a list tables in the DB that match the `tables` and `excludeTables`
 * parameters.
 * This will be stored in `req.aRAD._finalTables`
 */
var findTables = function(req, res, next) 
{
    var tablesRemaining = req.aRAD._tables.length;
    var sql = "SHOW TABLES LIKE ?";
    for (var i=0; i<req.aRAD._tables.length; i++) {
        req.aRAD._importDB.query(sql, [ '%' + req.aRAD._tables[i] + '%\_trans' ], function(err, results, fields) {
            if (err) {
                throw err;
            }
            for (var j=0; j<results.length; j++) {
                // Find out the results index name
                var indexName;
                for (indexName in results[j]) { 
                    break; 
                }
                
                // See if this table matches any exclusions
                var tableName = results[j][ indexName ];
                var isTableExcluded = false;
                for (var k=0; k<req.aRAD._excludeTables.length; k++) {
                    var pattern = req.aRAD._excludeTables[k];
                    if (pattern && tableName.match(pattern)) {
                        isTableExcluded = true;
                        break;
                    }
                }
                if (!isTableExcluded) {
                    if (req.aRAD._finalTables.indexOf(tableName) < 0) {
                        req.aRAD._finalTables.push( tableName );
                    }
                }
            }

            tablesRemaining -= 1;
            
            // After the final SQL query
            if (!tablesRemaining) {
                next();
            }
        });
    }
}


/**
 * Write the translated labels to the database
 */
var writeDataTrans = function(req, res, next) 
{
    if (req.aRAD._finalTables.length == 0) {
        AD.Comm.Service.sendError(req, res, { errorMSG: 'No matching tables' });
        return;
    }

    // Write the labels to a single table
    var writeTable = function(tableName, callback) {
        // Determine which columns to import to
        var sql = "SHOW COLUMNS FROM `" + tableName + "`";
        req.aRAD._importDB.query(sql, [], function(err, results, fields) {
            if (err) {
                throw err;
            }
            var labelFieldName;
            var indexFieldName;
            // There should be exactly one field that is named *_trans
            // and one field named *_id besides Trans_id.
            for (var j=0; j<results.length; j++) {
                var fieldName = results[j]['Field'];
                if (fieldName.match(/_label$/)) {
                    labelFieldName = fieldName;
                }
                else if (!fieldName.match(/^trans_id$/i) && fieldName.match(/_id$/)) {
                    indexFieldName = fieldName;
                } 
            }
            if (!labelFieldName || !indexFieldName) {
                AD.Comm.Service.sendError(req, res, { errorMSG: 'Could not find the required *_label and *_id columns in table [' + tableName + ']' });
                return;
            }
            
            // Fetch the fields
            var checkSQL = "\
                SELECT * \
                FROM `" + tableName + "` \
                WHERE `language_code` IN ( ?, ? ) \
            ";
            req.aRAD._importDB.query(checkSQL, [ req.aRAD._langSrc, req.aRAD._langDest ], function(err, results, fields) {
                if (err) throw err;
                // Group the results by index and language
                var allLabels = {};
                for (var j=0; j<results.length; j++) {
                    var row = results[j];
                    var index = row[indexFieldName];
                    var label = row[labelFieldName];
                    var lang = row['language_code'];

                    if (!allLabels[index]) {
                        allLabels[index] = {}
                    }
                    allLabels[index][lang] = label;
                }
                
                // Apply translations
                var labelsRemaining = Object.keys(allLabels).length;
                var nextLabel = function() {
                    labelsRemaining -= 1;
                    if (labelsRemaining == 0) {
                        callback();
                    }
                }
                for (var index in allLabels) {
                    var srcLabel = allLabels[index][req.aRAD._langSrc];
                    var destLabel = allLabels[index][req.aRAD._langDest];
                    // Do we have an imported translation for this label?
                    if (req.aRAD._importData[srcLabel]) {
                        var importLabel = req.aRAD._importData[srcLabel];
                        // Translation is new
                        if (typeof destLabel == 'undefined') {
                            var insertSQL = "\
                                INSERT INTO `" + tableName + "` \
                                SET \
                                    `" + labelFieldName + "` = ?, \
                                    `" + indexFieldName + "` = ?, \
                                    `language_code` = ? \
                            ";
                            req.aRAD._importDB.query(insertSQL, [ importLabel, index, req.aRAD._langDest ], function(err) {
                                nextLabel();
                            });
                        }
                        // Don't import placeholder labels
                        // "[zh-hans]..."
                        else if (importLabel.indexOf('[' + req.aRAD._langDest + ']') == 0) {
                            nextLabel();
                        }
                        // Translation has been updated
                        else if (importLabel != destLabel) {
                            var updateSQL = "\
                                UPDATE `" + tableName + "` \
                                SET \
                                    `" + labelFieldName + "` = ? \
                                WHERE `" + indexFieldName + "` = ? \
                                AND `language_code` = ? \
                            ";
                            req.aRAD._importDB.query(updateSQL, [ importLabel, index, req.aRAD._langDest ], function(err) {
                                nextLabel();
                            }); 
                        }
                        // Translation is unchanged
                        else {
                            nextLabel();
                        }
                    }
                    // No imported translation for this label
                    else {
                        nextLabel();
                    }
                }
            });
        });
    } // end writeTable()
            
    
    // Loop over all the tables
    var tablesRemaining = req.aRAD._finalTables.length;
    for (var i=0; i<req.aRAD._finalTables.length; i++) {
        writeTable(req.aRAD._finalTables[i], function() {
            tablesRemaining -= 1;
            if (!tablesRemaining) {
                AD.Comm.Service.sendSuccess(req, res, { message: 'Translations imported' });
                next();
                return;
            }
        });
    }
    
} // end writeDataTrans()



//// perform these actions in sequence:
var moduleStack = [
    hasPermission,  // make sure we have permission to access this
    initDB,
    initData,
    readFile,
    parseData,
    findTables,  
    writeDataTrans
];
        


exports.setup = function(app) {
    
    ////---------------------------------------------------------------------
    app.all('/appRad/datatrans/import', moduleStack, function(req, res, next) {
        //// Imports a set of labels from a gettext format for translation
        // test using: http://localhost:8085/appRad/datatrans/import?exportTables=foo,bar&destLang=zh-hans&srcLang=en&fileSrc=foobar_zh-hans.po
    
            // by the time we enter this, we should have done all our steps
            // for this operation.
            AD.Util.LogDump(req,'  - finished');
            
    });

}