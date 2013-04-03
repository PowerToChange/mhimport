//// Template Replace:
//   site     : the name of this interface's module: (lowercase)
//   viewer    : the name of this service :  (lowercase)
//   Viewer    : the name of this service :  (Uppercase)
//   whoAmI	  : the action for this service : (lowercase) (optional).


////
//// Viewer
////
//// Performs the actions for viewer.
////
////    /site/viewer/whoAmI 
////
////


var log = AD.Util.Log;
var logDump = AD.Util.LogDump;



var siteViewer = new AD.App.Service({});
module.exports = siteViewer;


var siteHub = null;   // Module's Notification Center (note: be sure not to use this until setup() is called)
var siteDispatch = null;  // Module's Dispatch Center (for sending messages among Clients)


//-----------------------------------------------------------------------------
siteViewer.setup = function() {
    // setup any handlers, subscriptions, etc... that need to have passed in 
    // private resources from the Module:
    //  this.hub = the module's Notification Hub
    //  this.listModels = the list of Model objects in the current Module
    // 
    
    siteHub = this.module.hub;
    siteDispatch = this.module.dispatch;
    
/*    
    var multiHandler = function(event, data) {
        console.log('multiHandler! event received['+event+']' );
    }
    siteHub.subscribe('test.ping', multiHandler);
    AD.Comm.Notification.subscribe('test.ping', multiHandler);
*/    
    

} // end setup()








////---------------------------------------------------------------------
var hasPermission = function (req, res, next) {
    // Verify the current viewer has permission to perform this action.


    // if viewer has 'site.viewer.whoAmI' action/permission
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

}






var viewerStack = [
        hasPermission,      // make sure we have permission to access this
//        step2, 	// get a list of all Viewers
//        step3		// update each viewer's entry
    ];
        
var totalCount = 0;

////---------------------------------------------------------------------
app.all('/api/site/viewer/whoAmI', viewerStack, function(req, res, next) {
    // test using: http://localhost:8088/api/site/viewer/whoAmI


    // By the time we get here, all the processing has taken place.
	totalCount++;
	
    logDump(req, 'finished viewer/whoAmI ['+totalCount+']');
    
    // Remove all functions from the returned viewer object
    var viewer = AD.Util.Object.getAttrs(req.aRAD.viewer);
    
    AD.Comm.Service.sendSuccess(req, res, viewer );
    
    
    
});

