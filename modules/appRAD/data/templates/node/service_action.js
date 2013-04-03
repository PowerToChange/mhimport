//// Template Replace:
//   [moduleName]     : the name of this interface's module: (lowercase)
//   [serviceName]    : the name of this service :  (lowercase)
//   [ServiceName]    : the name of this service :  (Uppercase)
//   [actionName]	  : the action for this service : (lowercase) (optional).


////
//// [ServiceName]
////
//// Performs the actions for [serviceName].
////
////    /[url] 
////
////


var log = AD.Util.Log;
var logDump = AD.Util.LogDump;



var [moduleName][ServiceName] = new AD.App.Service({});
module.exports = [moduleName][ServiceName];


var [moduleName]Hub = null;   // Module's Notification Center (note: be sure not to use this until setup() is called)
var [moduleName]Dispatch = null;  // Module's Dispatch Center (for sending messages among Clients)


//-----------------------------------------------------------------------------
[moduleName][ServiceName].setup = function() {
    // setup any handlers, subscriptions, etc... that need to have passed in 
    // private resources from the Module:
    //  this.hub = the module's Notification Hub
    //  this.listModels = the list of Model objects in the current Module
    // 
    
    [moduleName]Hub = this.module.hub;
    [moduleName]Dispatch = this.module.dispatch;
    
/*    
    var multiHandler = function(event, data) {
        console.log('multiHandler! event received['+event+']' );
    }
    [moduleName]Hub.subscribe('test.ping', multiHandler);
    AD.Comm.Notification.subscribe('test.ping', multiHandler);
*/    
    

} // end setup()








////---------------------------------------------------------------------
var hasPermission = function (req, res, next) {
    // Verify the current viewer has permission to perform this action.


    // if viewer has '[moduleName].[serviceName].[actionName]' action/permission
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

}






var [serviceName]Stack = [
        AD.App.Page.serviceStack,  // authenticates viewer, and prepares req.aRAD obj.
        hasPermission,      // make sure we have permission to access this
//        step2, 	// get a list of all Viewers
//        step3		// update each viewer's entry
    ];
        
var totalCount = 0;

////---------------------------------------------------------------------
app.get('/[url]', [serviceName]Stack, function(req, res, next) {
    // test using: http://localhost:8088/[moduleName]/[serviceName]/[actionName]


    // By the time we get here, all the processing has taken place.
	totalCount++;
	
    logDump(req, 'finished [serviceName]/[actionName] ['+totalCount+']');
    
    
    // publish a notification
    if ([moduleName]Hub != null) [moduleName]Hub.publish('test.ping', {});
    
    // send a success message
    var successStub = {
            message:'done.' 
    }
    AD.Comm.Service.sendSuccess(req, res, successStub );
    
    
    
});

