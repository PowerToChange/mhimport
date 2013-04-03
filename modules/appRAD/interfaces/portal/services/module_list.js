
////
//// Module List
////
//// Performs the actions for module.
////
////    /appRAD/module/list 
////
////

var fs = require('fs');

var log = AD.Util.Log;
var logDump = AD.Util.LogDump;



var appRADModuleList = new AD.App.Service({});
module.exports = appRADModuleList;


var appRADHub = null;   // Module's Notification Center (note: be sure not to use this until setup() is called)
var appRADDispatch = null;  // Module's Dispatch Center (for sending messages among Clients)


//-----------------------------------------------------------------------------
appRADModuleList.setup = function() {
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
    // get a list of all the directory names under appdev/modules/*

    var path = __appdevPath+'/modules';
    templateTool.listDirNames(path, function(err, list) {
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
            
            var convertedList = [];
            
            // list is an array of { name:'xxx' } objects.  We need to add id:x
            // since module names don't really have an id, we'll just reuse the name
            // since that is unique.
            for (var i=0; i < list.length; i++ ) {
            	
            	var obj = { name:list[i].name,
            			id:list[i].name
            	};
//            	obj.id=(i+1);
            	convertedList.push(obj);
            }
            req.aRad.listFiles = convertedList;
            next();
        }
    });

}




////Create our Template Tools object
var TemplateTools = require('./objects/templateTools.js');
var templateTool = new TemplateTools({
});



var moduleStack = [
        AD.App.Page.serviceStack,  // authenticates viewer, and prepares req.aRAD obj.
        hasPermission,      // make sure we have permission to access this
        gatherList 			// get a list of all files
    ];
        
var totalCount = 0;

////---------------------------------------------------------------------
app.all('/appRAD/module/list', moduleStack, function(req, res, next) {
    // test using: http://localhost:8088/appRAD/module/list


    // By the time we get here, all the processing has taken place.
	totalCount++;
	
    logDump(req, 'finished module/list ['+totalCount+']');
    
   
    
    // send a success message
    AD.Comm.Service.sendSuccess(req, res, req.aRad.listFiles );
    
});

