
////
//// Module Install Files List
////
//// Performs the actions for module.
////
////    /appRAD/module/installFiles/list 
////
////

var fs = require('fs');

var log = AD.Util.Log;
var logDump = AD.Util.LogDump;



var appRADModuleInstallFilesList = new AD.App.Service({});
module.exports = appRADModuleInstallFilesList;


var appRADHub = null;   // Module's Notification Center (note: be sure not to use this until setup() is called)
var appRADDispatch = null;  // Module's Dispatch Center (for sending messages among Clients)


//-----------------------------------------------------------------------------
appRADModuleInstallFilesList.setup = function() {
    // setup any handlers, subscriptions, etc... that need to have passed in 
    // private resources from the Module:
    //  this.hub = the module's Notification Hub
    //  this.listModels = the list of Model objects in the current Module
    // 
    
    appRADHub = this.module.hub;
    appRADDispatch = this.module.dispatch;
    
/*    
    var multiHandler = function(event, data) {
        console.log('multiHandler! event received['+event+']' );
    }
    appRADHub.subscribe('test.ping', multiHandler);
    AD.Comm.Notification.subscribe('test.ping', multiHandler);
*/    
    

} // end setup()








////---------------------------------------------------------------------
var hasPermission = function (req, res, next) {
    // Verify the current viewer has permission to perform this action.


    // if viewer has 'appRAD.module.list' action/permission
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

}



////---------------------------------------------------------------------
var gatherList = function (req, res, next) {
    // get a list of all the filenames under .../moduleName/install/data/*
    var moduleName = (req.body.module || req.query.module);
    if (moduleName) {
        var filePath = __appdevPath+'/modules/'+moduleName+'/install/data';
        templateTool.listFileNames(filePath, function(err, list) {
            // if err then
            if (err) {
                // return error message to browser
                AD.Comm.Service.sendError(req, res, {
                    success: 'false',
                    errorID:'150',
                    errorMSG:'Error reading path['+filePath+']: '+err,
                    data:{}
                });
            } else{ 
                // Verify that each file is a either a .po or .sql file
                for (var i = 0; i < list.length; ) {
                    var filename = list[i].name;
                    if ((filename.slice(-3) == '.po') || (filename.slice(-4) == '.sql')) {
                        // good
                        i++;
                    } else {
                        // bad
                        list.splice(i,1);
                    }
                }

                // All done
                // package the file info into an array of filenames
                req.aRad = {};
                req.aRad.listFiles = list;
                next();
            }
        });
    } else {
        // No module or invalid module provided
        // Return empty list
        req.aRad = {};
        req.aRad.listFiles = [];
        next();
    }

}




////Create our Template Tools object
var TemplateTools = require('./objects/templateTools.js');
var templateTool = new TemplateTools({
});



var moduleStack = [
        hasPermission,      // make sure we have permission to access this
        gatherList 			// get a list of all files
    ];
        
var totalCount = 0;

////---------------------------------------------------------------------
app.all('/appRAD/module/installFiles/list', moduleStack, function(req, res, next) {
    // test using: http://localhost:8088/appRAD/module/installFiles/list?module=site


    // By the time we get here, all the processing has taken place.
	totalCount++;
	
    logDump(req, 'finished module/installFiles/list ['+totalCount+']');
    
   
    
    // send a success message
    AD.Comm.Service.sendSuccess(req, res, req.aRad.listFiles );
    
});
