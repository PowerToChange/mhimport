
////
//// Labels Export
////
//// This service is designed to take all the labels of a module from the 
//// database and export them as a gettext (.PO) file.
////
////    /appRad/labels/export   : module=M & destLang=X [& srcLang=Y] 
////                                [& fileDest=Z]
////        Creates a new .po file:  
////                    /root/modules/[M]/install/data/labels_[X].po
////        or:
////                    as specified by [Z]
////
//// srcLang is optional and will be the site default language if not specified.
////
//// The saved .po file name will only contain the target language,
//// regardless of what the source language is.
////
//// fileDest can either be a full absolute directory path, or a relative path
//// to the appDev base directory. If the given path is invalid, the default
//// will be used instead.
////


////
//// Setup the Template Definitions:
////

//// NOTE: the keys in listTemplatesModel & listDestinationsModel must match.
////       


var Label = require(__appdevPath + '/modules/site/models/Labels.js');


////---------------------------------------------------------------------
var hasPermission = function (req, res, next) {
    // Verify the current viewer has permission to perform this action.


    // if viewer has 'appRAD.Developer' action
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

}



// Supposed to be like the PHP isset()
var isset = function(thing) {
    if (typeof thing == 'undefined') {
        return false;
    }
    return true;
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
var parseReqParams = function(req) {
    
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


////---------------------------------------------------------------------
var initData = function (req, res, next) {
    // Gather the required Data for this operation.

    var $_REQUEST = parseReqParams(req);
    var module = $_REQUEST['module'];
    var pathKey = $_REQUEST['pathKey'];
    var langSrc = $_REQUEST['srcLang'];
    var langDest = $_REQUEST['destLang'];
    var fileDest = $_REQUEST['fileDest'];
    
    
    if (!module || !langDest) {
        Log(req, '  - error: some data not provided langDest['+langDest+'] module['+module+']');
        LogDump(req, '');

        AD.Comm.Service.sendError(req, res, {errorMSG:'some data not provided destLang['+langDest+'] module['+module+']'} );
        return;
    }

    else {
        // if pathKey !provided then use module instead:
        if (!pathKey) {
            pathKey = module;
        }
    
        // Find the default site language if needed
        if (!langSrc) {
            langSrc = 'en';
            if (AD.Defaults.langDefault) {
                langSrc = AD.Defaults.langDefault;
            }
        }
        
        req.aRAD.module = module;
        req.aRAD.pathKey = pathKey;
        req.aRAD.langSrc = langSrc;
        req.aRAD.langDest = langDest;
        req.aRAD.fileDest = fileDest;

        // Labels will be semi-parsed and stored here after being read 
        // from the DB, 
        req.aRAD.labelsExport = {};

        // This is the final array of labels that will be sent to the template
        // to become the .PO gettext file.
        req.aRAD.arayFinal = [];
        
        next();
    }
    
}


// read the module's source language labels from the database
var readSourceLabels = function(req, res, next) {
    
    var langSrc = req.aRAD.langSrc;
    var module = req.aRAD.module;
    var pathKey = req.aRAD.pathKey;
    
    // Read out all the labels from the module
    var conditionSrc = "label_path LIKE '/" + pathKey +"/%' AND language_code = '" + langSrc + "'";
    
    Label.findAll({ dbCond: conditionSrc },function(resultArray) {

            req.aRAD.labelsSrc = resultArray;
            //console.log(resultArray);
            // Parse the source labels
            var labelsExport = req.aRAD.labelsExport;
            for (var i=0; i<req.aRAD.labelsSrc.length; i++) {
                var thisLabel = req.aRAD.labelsSrc[i];
                
                // path
                var labelPath = thisLabel['label_path'];
                if (typeof labelsExport[labelPath] == 'undefined') {
                    labelsExport[labelPath] = {};
                }
                
                // path -> key
                var key = thisLabel['label_key'];
                if (typeof labelsExport[labelPath][key] == 'undefined') {
                    labelsExport[labelPath][key] = {}
                }
                
                // path -> key -> lang
                var lang = thisLabel['language_code'];
                labelsExport[labelPath][key][lang] = thisLabel['label_label'];
            }

            next();
    });

}


// read the module's destination language labels from the database
var readDestLabels = function(req, res, next) {

    var langDest = req.aRAD.langDest;
    var module = req.aRAD.module;
    var pathKey = req.aRAD.pathKey;
    
    // Read out all the labels from the module
    var conditionDest = "label_path LIKE '/" + pathKey +"/%' AND language_code = '" + langDest + "'";

    Label.findAll({ dbCond: conditionDest },function(resultArray) {

            req.aRAD.labelsDest = resultArray;

            // Parse the destination labels
            var labelsExport = req.aRAD.labelsExport;
            for (var i=0; i<req.aRAD.labelsDest.length; i++) {
                var thisLabel = req.aRAD.labelsDest[i];
                
                // path
                var labelPath = thisLabel['label_path'];
                if (typeof labelsExport[labelPath] == 'undefined') {
                    labelsExport[labelPath] = {};
                }
                
                // path -> key
                var key = thisLabel['label_key'];
                if (typeof labelsExport[labelPath][key] == 'undefined') {
                    labelsExport[labelPath][key] = {}
                }
                
                // path -> key -> lang
                var lang = thisLabel['language_code'];
                labelsExport[labelPath][key][lang] = thisLabel['label_label'];
            }

            next();
    });

}


/**
 * Create the .PO gettext file from the parsed labels
 */
var createExport = function(req, res, next) {
    
    var labelsExport = req.aRAD.labelsExport;
    var langSrc = req.aRAD.langSrc;
    var langDest = req.aRAD.langDest;
    
    // Final parsing
    var arrayFinal = [];
    var labelsTracker = [];
    for (var labelPath in labelsExport) {
        for (var key in labelsExport[labelPath]) {
        	var source = labelsExport[labelPath][key][langSrc];
            var dest = labelsExport[labelPath][key][langDest];
            // Fill in any missing source/destination labels
            if (!dest) {
            	dest = source;
            }
            if (!source) {
            	source = dest;
            } else {            	
            	if (labelsTracker.indexOf(source) != -1)
            		source = '(translators ignore this tag:[' + labelsTracker.length + ']) ' + source;
            	
        		labelsTracker.push(source);
            }
            
            // Escape unsafe characters
            source = source
                .replace(/"/gm, '\\"')
                .replace(/[\n\r]/gm, '\\n');
            dest = dest
                .replace(/"/gm, '\\"')
                .replace(/[\n\r]/gm, '\\n');
            // Ready for the template
            arrayFinal.push({
                'label_path': labelPath,
                'label_key': key,
                'label_source': source,
                'label_label': dest
            });
        }
    }

    // Use the EJS template to create the .po file
    var templateName = __dirname + '/../../../data/templates/node/po.ejs';
    var templateStr = fs.readFileSync(templateName, 'utf8');
    var thisEJS = require('ejs');
    var poString = thisEJS.render(templateStr, {
        locals: {
            'labels': arrayFinal,
            'moduleKey': req.aRAD.module,
            'sourceLangCode': langSrc,
            'targetLangCode': langDest
        }
    });
    
    //// Save the .po file
    // Default is to use the module's install/data directory.
    var poFileName = 'labels_' + langDest + '.po';
    var poFilePath = ''
        + __appdevPath
        + '/modules/' + req.aRAD.module + '/install/data/'
        + poFileName;
    // But the location may also be passed in using 'fileDest'
    if (req.aRAD.fileDest) {
        var fileDest = req.aRAD.fileDest;
        // relative path
        if (fileDest.charAt(0) != '/') {
            // convert to absolute
            var fileDest = __appdevPath + '/' + fileDest;
        }
        // Only allow destinations within the appDev framework hierarchy
        if (fileDest.indexOf(__appdevPath) == '0') {
            // No using '../../' to break out
            var afterAppDev = fileDest.substr( __appdevPath.length );
            if (afterAppDev.indexOf('../') == -1) {
                // Make sure directory exists
                if (path.existsSync(fileDest)) {
                    var stat = fs.statSync(fileDest);
                    if (stat.isDirectory()) {
                        // Confirmed that the given 'fileDest' is valid!
                        // Use that instead of the default
                        poFilePath = fileDest + '/' + poFileName;
                    }
                    else {
                        console.log(' -- fileDest must be a directory');
                    }
                }
                else {
                    console.log(' -- fileDest directory path does not exist');
                }
            }
            else {
                console.log(' -- fileDest path cannot use ../');
            }
        }
        else {
            console.log(' -- fileDest path must be inside appDev hierarchy');
        }
    }

    fs.writeFile(poFilePath, poString, 'utf8', function() {
    
        // All done. Send final response back to the browser.
        AD.Comm.Service.sendSuccess(req, res, { 
            message: 
                //'cwd: ' + process.cwd() + '\n' + 
                //'dirname: ' + __dirname + '\n' +
                //'__appdevPath: ' + __appdevPath + '\n' +
                'poFilePath: ' + poFilePath
        } );
    });
    
    
}


//// Define functions for passing control to our templateTool object:
var createDirectory = function (req, res, next) { 

    // list of directories that need to be created for the Module
    var listDestinationsDirectories = {
        '/modules/[module]/install/data': '-',
        };

    //// Create our Template Tools object
    var TemplateTools = require('./objects/templateTools.js');
    var templateTool = new TemplateTools({
        listDirectories: listDestinationsDirectories
    });
    req.appRAD = {
        'listTags': {
            'module': req.aRAD.module
        }
    };

    templateTool.createDirectory(req, res, next); 
}






//// perform these actions in sequence:
var moduleStack = [
        hasPermission,  // make sure we have permission to access this
        initData,       // prepare data (name & listTags)    
        createDirectory,// verify all the Directories exist
        readSourceLabels,
        readDestLabels,
        createExport
        ];
        
        
exports.setup = function(app) {
    ////---------------------------------------------------------------------
    app.all('/appRad/labels/export', moduleStack, function(req, res, next) {
        //// Exports a set of labels from a module to gettext format for translation
        // test using: http://localhost:8085/appRad/labels/export?module=site&pathKey=page/site&destLang=zh-hans&srcLang=en
    
        
            // by the time we enter this, we should have done all our steps
            // for this operation.
            LogDump(req,'  - finished');
    
            
            // send a success message
            AD.Comm.Service.sendSuccess(req, res, {message:'all module templates written.' } );
    
        
    });
    
}