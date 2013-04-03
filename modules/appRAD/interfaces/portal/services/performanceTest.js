
////
//// Service Performance Test
////
//// This service is designed to measure the performance of AppDev in performing DB operations.
////
////    /appRad/performanceTest/dbUpdate
////
////


var myDB = require('database.js').sharedDB();




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


////---------------------------------------------------------------------
var grabAllViewers = function (req, res, next) {
    // Verify the current viewer has permission to perform this action.

	
		// put all entries in req.aRAD.viewers
		req.aRAD = { viewers:[] };

	   var sql = 'SELECT * FROM '+AD.Defaults.dbName+'.site_viewer ';
	    
	    myDB.query(sql, [], function(err, results, fields) {
	        
	        if (err) {
	        
	            console.log(err);
	            next();
	            
	        } else {

	            if (results.length < 1) {
	            
	                // didn't find a viewer so return 
	                next();
	            
	            } else {
	            
	                // found him, so load the viewer object 
	                req.aRAD.viewers = results;
	                
	                next();
	            }
	        
	        }
	    
	    });

}






////---------------------------------------------------------------------
var updateViewers = function (req, res, next) {
// update each Viewer's entry 


	// put all entries in req.aRAD.viewers
	var viewers = req.aRAD.viewers;
	
	var now = new Date();
    var ymdDate = '' + now.getFullYear() + '-' 
        + (now.getMonth()+1) + '-' 
        + now.getDate() + ' '
        + now.getHours() + ':'
        + now.getMinutes();
	
    var countDone = 0;
    
	// foreach viewer
	for(var i=0; i<viewers.length; i++) {
		
		
		
		var sql = "UPDATE " + AD.Defaults.dbName +".site_viewer  SET viewer_lastLogin='"+ymdDate+"'  WHERE viewer_id = "+viewers[i].viewer_id;
	    
		myDB.query(sql, [], function(err, results, fields) {
			
			countDone ++;
	        
	        if (err) {
	        
	            console.log(err);

	            
	        } 
	        
	        if (countDone >= viewers.length) {
	        	
	        	next();
	        
	        }
	    
	    });
	}

}





var performanceStack = [
        hasPermission,      // make sure we have permission to access this
        grabAllViewers, 	// get a list of all Viewers
//        updateViewers		// update each viewer's entry
    ];
        
var totalCount = 0;


exports.setup = function(app) {
    ////---------------------------------------------------------------------
    app.get('/appRad/performanceTest/dbUpdate', performanceStack, function(req, res, next) {
        //// Creates a new model from DB table X  under application Module Y
        // test using: http://localhost:8085/appRad/modelmultilingual/create?module=test&ModelName=VisaType&tableNameData=hris_visatype_data&tableNameTrans=hris_visatype_trans&primaryKey=visatype_id&listMultilingualFields=visatype_label&labelKey=visatype_label
    
    
        // By the time we get here, all the processing has taken place.
        totalCount++;
        
        LogDump(req, 'finished test ['+totalCount+']');
        
        
        // send a success message
        AD.Comm.Service.sendSuccess(req, res, {message:'all viewer records written. count['+req.aRAD.viewers.length+']' } );
        
        
        
    });
    
}