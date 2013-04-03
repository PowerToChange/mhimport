
////
//// Interface List
////
//// Performs the actions for interface.
////
////    /appRAD/interface/list 
////
////

var fs = require('fs');

var log = AD.Util.Log;
var logDump = AD.Util.LogDump;



var appRADInterfaceList = new AD.App.Service({});
module.exports = appRADInterfaceList;


var appRADHub = null;   // Module's Notification Center (note: be sure not to use this until setup() is called)
var appRADDispatch = null;  // Module's Dispatch Center (for sending messages among Clients)


//-----------------------------------------------------------------------------
appRADInterfaceList.setup = function() {
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


    // if viewer has 'appRAD.interface.list' action/permission
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

}



////---------------------------------------------------------------------
var gatherList = function (req, res, next) {
    // get a list of all the directory names under .../moduleName/interfaces/*
    var moduleName = (req.body.module || req.query.module);
    if (moduleName) {
        var filePath = __appdevPath+'/modules/'+moduleName+'/interfaces';
        templateTool.listDirNames(filePath, function(err, list) {
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
                // Verify that each folder is an 'interface'
                var verifyFile = function(item, filterCallback) {
                    // Should contain a file named 'node_<interface>.js'
                    path.exists(filePath+'/'+item.name+'/node_'+item.name+'.js', function(exists) {
                        filterCallback(exists);
                    });
                };
                async.filter(list, verifyFile, function(filteredList) {
                    // All done
                    // package the file info into an array of filenames
                    req.aRad = {};
                    req.aRad.listFiles = filteredList;
                    next();
                });
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


var interfaceStack = [
        hasPermission,      // make sure we have permission to access this
        gatherList 			// get a list of all files
    ];
        
var totalCount = 0;

////---------------------------------------------------------------------
app.all('/appRAD/interface/list', interfaceStack, function(req, res, next) {
    // test using: http://localhost:8088/appRAD/interface/list


    // By the time we get here, all the processing has taken place.
	totalCount++;
	
    logDump(req, 'finished interface/list ['+totalCount+']');
    
   
    
    // send a success message
    AD.Comm.Service.sendSuccess(req, res, req.aRad.listFiles );
    
});

