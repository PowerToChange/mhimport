
////
//// Table List
////
//// Lists available tables.
////
////    /appRAD/model/tables/list 
////
////

var log = AD.Util.Log;
var logDump = AD.Util.LogDump;

var DataStore = AD.Model.Datastore;


var appRADTableList = new AD.App.Service({});
module.exports = appRADTableList;


var appRADHub = null;   // Module's Notification Center (note: be sure not to use this until setup() is called)
var appRADDispatch = null;  // Module's Dispatch Center (for sending messages among Clients)


//-----------------------------------------------------------------------------
appRADTableList.setup = function() {
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


    // if viewer has 'appRAD.model.table.list' action/permission
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

}



////---------------------------------------------------------------------
var gatherList = function (req, res, next) {
    // get a list of all the tables
    var dbName = (req.body.dbName || req.query.dbName || AD.Defaults.dbName);
    DataStore.listTables(dbName, function(err, results, fields){
        // if err then
        if (err) {
            // return error message to browser
            AD.Comm.Service.sendError(req, res, {
                success: 'false',
                errorID:'150',
                errorMSG:'Error retrieving table list: '+err,
                data:{}
            });
        } else{ 
            // package the table info into an array of entries
            // The property of interest should be 'Tables_in_<dbName>'
            var list = [];
            var colName = 'Tables_in_'+dbName;
            for (var ri=0; ri < results.length; ri++) {
                if (typeof results[ri][colName] != 'undefined') {
                    list.push({name:results[ri][colName]});
                }
            }

            req.aRad = {};
            req.aRad.list = list;
            next();
        }
        
    });
}



////Create our Template Tools object
var TemplateTools = require('./objects/templateTools.js');
var templateTool = new TemplateTools({
});


var actionStack = [
        hasPermission,      // make sure we have permission to access this
        gatherList 			// get a list of all files
    ];
        
var totalCount = 0;

////---------------------------------------------------------------------
app.all('/appRAD/model/tables/list', actionStack, function(req, res, next) {
    // test using: http://localhost:8088/appRAD/model/tables/list?dbName=trunk_site


    // By the time we get here, all the processing has taken place.
	totalCount++;
	
    logDump(req, 'finished model/tables/list ['+totalCount+']');
    
   
    
    // send a success message
    AD.Comm.Service.sendSuccess(req, res, req.aRad.list);
    
});

