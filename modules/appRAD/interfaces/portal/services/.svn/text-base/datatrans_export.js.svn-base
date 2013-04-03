
////
//// Data Translations Export
////
//// This service is designed to take all the data translations of one or more
//// tables and export them as a gettext (.PO) file.
////
//// SECURITY NOTE:
////    This service will potentially expose the contents of all *_label fields
////    in all *_trans tables. The exports are done through direct SQL, so this
////    will bypass any field permissions checking done at the Model level.
////    However, permissions checking at the Service level can still be done.
////    Make sure you assign permissions only to users that are allowed to 
////    access all *_trans tables.
////
////    /appRad/datatrans/export   : exportTables=T & destLang=X [& srcLang=Y] 
////                                & fileDest=Z [& excludeTables=U]
////                                [& dbName=D] [& dbUser=E] [& dbPword=F] 
////                                [& dbPort=G] [& dbPath=H]
////        Creates a new .po file:  
////                    as specified by [Z], relative to the appDev root.
////
//// 
////   exportTables: A comma separated list of table name patterns to include.
////       Tables whose names contain any of the patterns, and also end 
////       in _trans, will be exported.
////   excludeTables: (optional) A comma separated list of table name patterns
////       to exclude. Tables whose names contain any of the patterns will not 
////       be exported.
////   destLang: The code of the destination language to be translated to.
////   srcLang: (optional) The code of the source language to be translated
////       from. The default site language will be used if nothing is specified.
////   fileDest: The destination file to write the exported data to. The path
////       should be relative to the appDev root.
////   dbName: (optional) The name of the database to export from. Default is 
////       the current appDev database.
////   dbPath: (optional) The database host.
////   dbUser: (optional) The database user.
////   dbPword: (optional) The database user's password.
////   
//// The saved .po file name will only contain the target language,
//// regardless of what the source language is.
////

//// Export [zh-Hans] data translation from the HRIS Translation site
// test.dodomail.net:14001/appRad/datatrans/export?exportTables=hris&excludeTables=hris_ren,hris_attachment,hris_medical,hris_education,hris_emergency,hris_interest,hris_phone,hris_talent,hris_version&destLang=zh-Hans&srcLang=en&fileDest=hris_data_trans-zh-Hans.po&dbName=trans_hris

//// Export [ko] data translation from the HRIS Translation site
// test.dodomail.net:14001/appRad/datatrans/export?exportTables=hris&excludeTables=hris_ren,hris_attachment,hris_medical,hris_education,hris_emergency,hris_interest,hris_phone,hris_talent,hris_version&destLang=ko&srcLang=en&fileDest=hris_data_trans-ko.po&dbName=trans_hris


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
 * associative array.
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
    // Supposed to be like the PHP isset()
    var isset = function(thing) {
        if (typeof thing == 'undefined') {
            return false;
        }
        return true;
    }

    var $_REQUEST = {};
    var sets = [ 'params', 'body', 'query' ];
    for (var i=0; i<sets.length; i++) {
        for (var paramName in req[ sets[i] ]) {
            if (!isset($_REQUEST[ paramName ])) {
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
    
    // Tables to be exported
    req.aRAD._exportTables;
    req.aRAD._excludeTables;
    req.aRAD._finalTables;
    
    // Destination file path to save the export
    req.aRAD._fileDest;
    
    // Container array for the final export data
    req.aRAD._exportData;
    
    req.aRAD._exportDB;

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
        req.aRAD._exportDB = require('mysql').createClient({
            user: dbSettings['dbUser'],
            password: dbSettings['dbPword'],
            host: dbSettings['dbPath'],
            port: dbSettings['dbPort']
        });
        sql = "USE " + $_REQUEST['dbName'];
    }
    
    // User is exporting tables from the current appDev database
    else {
        req.aRAD._exportDB = require('database.js').sharedDB();
        sql = "USE " + AD.Defaults.dbName;
    }
    
    req.aRAD._exportDB.query(sql, [], function(err, results, fields) {
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
    req.aRAD._exportData = [];

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
        req.aRAD._fileDest = $_REQUEST['fileDest'];
        if (!req.aRAD._fileDest) {
            throw "Destination file (fileDest) was not provided";
        }
        if (req.aRAD._fileDest[0] != '/') {
            req.aRAD._fileDest = __appdevPath + '/' + req.aRAD._fileDest;
        }
        var destDirname = path.dirname(req.aRAD._fileDest);
        var destFilename = path.basename(req.aRAD._fileDest);
        // Make sure directory exists
        if (!path.existsSync(destDirname)) {
            throw "Destination directory does not exist";
        }
        // Make sure directory is a directory
        var stat = fs.statSync(destDirname);
        if (!stat.isDirectory()) {
            throw "Destination directory (fileDest) is invalid";
        }
        // Make sure directory is within appDev hierarchy
        destDirname = fs.realpathSync(destDirname);
        if (destDirname.indexOf(fs.realpathSync(__appdevPath)) != 0) {
            throw "Destination directory (fileDest) must be within the appDev hierarchy";
        }
        // Replace all non alphanumeric characters in file name
        destFilename = destFilename.replace(/[^\w().-]/g, '_');
        // Make sure it has a .po extension
        if (!destFilename.match(/\.po$/)) {
            destFilename += '.po';
        }
        // Reassemble the file dest
        req.aRAD._fileDest = destDirname + '/' + destFilename;

        
        //// Table options
        req.aRAD._finalTables = [];
        req.aRAD._exportTables = paramToArray($_REQUEST['exportTables']);
        req.aRAD._excludeTables = paramToArray($_REQUEST['excludeTables']);
        if (!req.aRAD._exportTables[0]) {
            throw "Export tables (exportTables) were not provided";
        }
        
        
        /// Done
        next();
    }

    catch (err) {
        // Thrown error is a string. Just report it to the client.
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
 * Get a list tables in the DB that match the `exportTables` and `excludeTables`
 * parameters.
 * This will be stored in `req.aRAD._finalTables`
 */
var findTables = function(req, res, next) 
{
    var tablesRemaining = req.aRAD._exportTables.length;
    var sql = "SHOW TABLES LIKE ?";
    for (var i=0; i<req.aRAD._exportTables.length; i++) {
        req.aRAD._exportDB.query(sql, [ '%' + req.aRAD._exportTables[i] + '%\_trans' ], function(err, results, fields) {
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
 * Read the labels from the database
 */
var readDataTrans = function(req, res, next) 
{
    // Read the labels from a single table
    var readTable = function(tableName, callback) {
        // Determine which columns to export
        var sql = "SHOW COLUMNS FROM `" + tableName + "`";
        req.aRAD._exportDB.query(sql, [], function(err, results, fields) {
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
            var sql = "\
                SELECT `language_code`, `" + labelFieldName + "`, `" + indexFieldName + "` \
                FROM `" + tableName + "` \
                WHERE `language_code` IN ( ?, ? )\
            ";
            req.aRAD._exportDB.query(sql, [ req.aRAD._langSrc, req.aRAD._langDest ], function(err, results, fields) {
                if (err) {
                    throw err;
                }
                // Parse data from this table
                var data = {};
                for (var j=0; j<results.length; j++) {
                    var langCode = results[j]['language_code'];
                    var index = results[j][indexFieldName];
                    var label = results[j][labelFieldName]
                        .replace(/"/gm, '\\"') // escape unsafe chars
                        .replace(/[\n\r]/gm, '\\n');
                    if (!data[index]) {
                        data[index] = {};
                    }
                    data[index]['table'] = tableName;
                    data[index]['index'] = index;
                    data[index][langCode] = label;
                }
                // And add it to the overall data
                for (var index in data) {
                    req.aRAD._exportData.push(data[index]);
                }
                
                callback();
            });
        });
    }
    
    
    if (req.aRAD._finalTables.length == 0) {
        AD.Comm.Service.sendError(req, res, { errorMSG: 'No matching tables' });
        return;
    }
    
    // Loop over all the tables
    var tablesRemaining = req.aRAD._finalTables.length;
    for (var i=0; i<req.aRAD._finalTables.length; i++) {
        readTable(req.aRAD._finalTables[i], function() {
            tablesRemaining -= 1;
            if (!tablesRemaining) {
                next();
                return;
            }
        });
    }
    
}


/**
 * Create the .PO gettext file from the parsed labels
 */
var createExport = function(req, res, next) 
{
    // Final parsing
    for (var i=0; i<req.aRAD._exportData.length; i++) {
        // Fill in any missing source/destination labels
        var source = req.aRAD._exportData[i][req.aRAD._langSrc];
        var dest = req.aRAD._exportData[i][req.aRAD._langDest];
        if (!source) {
            source = '['+req.aRAD._langSrc+'] ' + dest;
        }
        if (!dest) {
            dest = '['+req.aRAD._langDest+'] ' + source;
        }

        // Ready for the template
        req.aRAD._exportData[i][req.aRAD._langSrc] = source;
        req.aRAD._exportData[i][req.aRAD._langDest] = dest;
    }

    // Use the EJS template to create the .po file
    var templateName = __dirname + '/../../../data/templates/node/data_po.ejs';
    var templateStr = fs.readFileSync(templateName, 'utf8');
    var thisEJS = require('ejs');
    var poString = thisEJS.render(templateStr, {
        locals: {
            'labels': req.aRAD._exportData,
            'sourceLangCode': req.aRAD._langSrc,
            'targetLangCode': req.aRAD._langDest
        }
    });
    
    //// Save the .po file
    fs.writeFile(req.aRAD._fileDest, poString, 'utf8', function(err) {
        if (err) {
            console.error(err);
            AD.Comm.Service.sendError(req, res, {message: 'Error saving the .po file'});
        }
        else {
            // All done. Send final response back to the browser.
            AD.Comm.Service.sendSuccess(req, res, { message: 'poFilePath: ' + req.aRAD._fileDest } );
        }
    });
    
}





//// perform these actions in sequence:
var moduleStack = [
        hasPermission,  // make sure we have permission to access this
        initDB,
        initData,       // prepare data (name & listTags)  
        findTables,  
        readDataTrans,
        createExport
        ];
        
        
        
exports.setup = function(app) {

    ////---------------------------------------------------------------------
    app.all('/appRad/datatrans/export', moduleStack, function(req, res, next) {
        //// Exports a set of labels from a module to gettext format for translation
        // test using: http://localhost:8085/appRad/datatrans/export?exportTables=foo,bar&destLang=zh-hans&srcLang=en&fileDest=foobar_zh-hans.po
    
            // by the time we enter this, we should have done all our steps
            // for this operation.
            AD.Util.LogDump(req,'  - finished');
    
            
            // send a success message
            AD.Comm.Service.sendSuccess(req, res, {message:'all datatrans processed written.' } );
    
        
    });

}