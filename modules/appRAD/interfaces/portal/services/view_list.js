
////
//// View List
////
//// Performs the actions for view.
////
////    /appRAD/interface/views/list 
////
////

var fs = require('fs');

var log = AD.Util.Log;
var logDump = AD.Util.LogDump;



var appRADViewList = new AD.App.Service({});
module.exports = appRADViewList;


var appRADHub = null;   // Module's Notification Center (note: be sure not to use this until setup() is called)
var appRADDispatch = null;  // Module's Dispatch Center (for sending messages among Clients)


//-----------------------------------------------------------------------------
appRADViewList.setup = function() {
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


    // if viewer has 'appRAD.view.list' action/permission
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

}



////---------------------------------------------------------------------
var gatherList = function (req, res, next) {
    // get a list of all the file names under .../moduleName/views/*
    var moduleName = (req.body.module || req.query.module);
    var interfaceName = (req.body.interface || req.query.interface);
    if (moduleName && interfaceName) {
        var path = __appdevPath+'/modules/'+moduleName+'/interfaces/'+interfaceName+'/views';
        templateTool.listFileNames(path, function(err, list) {
            // if err then
            if (err) {
                // return error message to browser
                AD.Comm.Service.sendError(req, res, {
                    success: 'false',
                    errorID:'150',
                    errorMSG:'Error reading path['+path+']: '+err,
                    data:{}
                });
            } else{ 
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


var viewStack = [
        hasPermission,      // make sure we have permission to access this
        gatherList 			// get a list of all files
    ];
        
var totalCount = 0;

////---------------------------------------------------------------------
app.all('/appRAD/interface/views/list', viewStack, function(req, res, next) {
    // test using: http://localhost:8088/appRAD/view/list


    // By the time we get here, all the processing has taken place.
	totalCount++;
	
    logDump(req, 'finished view/list ['+totalCount+']');
    
   
    
    // send a success message
    AD.Comm.Service.sendSuccess(req, res, req.aRad.listFiles );
    
});

