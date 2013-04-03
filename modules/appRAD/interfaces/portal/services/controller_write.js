
////
//// Controller Write
////
//// Performs the actions for controller.
////
////    /appRAD/interface/controllers/write 
////
////

var fs = require('fs');

var log = AD.Util.Log;
var logDump = AD.Util.LogDump;



var appRADControllerWrite = new AD.App.Service({});
module.exports = appRADControllerWrite;


var appRADHub = null;   // Module's Notification Center (note: be sure not to use this until setup() is called)
var appRADDispatch = null;  // Module's Dispatch Center (for sending messages among Clients)


//-----------------------------------------------------------------------------
appRADControllerWrite.setup = function() {
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


    // if viewer has 'appRAD.controller.list' action/permission
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

};

////---------------------------------------------------------------------
var writeFile = function (req, res, next) {
    // write the contents of the file
    var moduleName = (req.body.module || req.query.module);
    var interfaceName = (req.body.interface || req.query.interface);
    var controllerName = (req.body.controller || req.query.controller);
    if (moduleName && interfaceName && controllerName) {
        var path = '/modules/'+moduleName+'/interfaces/'+interfaceName+'/scripts/'+controllerName;
        var content = (req.body.content || req.query.content || '');
        templateTool.fileWrite(__appdevPath+path, content, function(err) {
            // if err then
            if (err) {
                // return error message to browser
                AD.Comm.Service.sendError(req, res, {
                    success: 'false',
                    errorID:'150',
                    errorMSG:'Error writing file['+path+']: '+err,
                    data:{}
                });
            } else{ 
                // Success, but no data
                req.aRad = {};
                next();
            }
        });
    } else {
        // No module or invalid module provided
        // Return empty list
        req.aRad = {};
        next();
    }

}



////Create our Template Tools object
var TemplateTools = require('./objects/templateTools.js');
var templateTool = new TemplateTools({
});


var controllerStack = [
        hasPermission,      // make sure we have permission to access this
        writeFile           // write the file content
    ];
        
var totalCount = 0;

////---------------------------------------------------------------------
app.all('/appRAD/interface/controllers/write', controllerStack, function(req, res, next) {
    // test using: http://localhost:8088/appRAD/interface/controllers/write?module=site&interface=email&controller=email.js


    // By the time we get here, all the processing has taken place.
	totalCount++;
	
    logDump(req, 'finished controller/write ['+totalCount+']');
    
   
    
    // send a success message
    AD.Comm.Service.sendSuccess(req, res, req.aRad);
    
});

