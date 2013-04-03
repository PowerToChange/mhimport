/**
 * @class create_test_service
 * @parent Unit_Testing
 * 
 * ###Creating unit tests
 * 
 * This service allows us to create unit tests from within appDev. Tests are always created in the 'test'
 * directory in the appDev root. 
 *
 * * The URL to access the service is &lt;host&gt;/testunit/test/create
 * 
 * Create the tests in the file 'test/comm_servicetest.js' for testing functions in '../node_modules/comm_service.js'; 
 *
 * * &lt;url&gt;?filename=../node_modules/comm_service.js&modulename=comm_servicetest
 *
 */

////---------------------------------------------------------------------
var hasPermission = function (req, res, next) {
    // Verify the current viewer has permission to perform this action.


    // if viewer has 'appRAD.Developer' action
        next();
    // else
        // var errorData = { message:'No Permission' }
        // ResponseService.sendError(req, res, errorData );
    // end if

}


var trim = function (str) {
    return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
};


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
    var filename = $_REQUEST['filename'];
    //var modulename = $_REQUEST['modulename'];
    
    
    if (!filename) { // || !modulename
    	AD.Util.Log(req, '  - error: filename or modulename not provided');
        AD.Util.LogDump(req, '');

        AD.Comm.Service.sendError(req, res, {errorMSG:'filename or modulename not provided'} );
        return;
    }

    else {
                
        req.aRAD.filename = filename;
        //req.aRAD.modulename = modulename;
        
        console.log(req.aRAD);
        next();
    }
    
}


//createTest
var createTest = function(req, res, next) {
 
	var files = [];
	
	if (req.aRAD.filename.indexOf(',') == -1) {
		files.push(req.aRAD.filename);
	} else {
		var filename_split = req.aRAD.filename.split(",");
		var name;
		for (name in filename_split) {
			if (name.trim() != "")
				files.push(filename_split[name]);
		}
	}

	for (var counter in files) {
		
		var filename = '../' + files[counter];
		//var filename = '../' + req.aRAD.filename;
		//var modulename = req.aRAD.modulename;
		var modname = files[counter].match(/\/.+?\.js$/);
		//var modpath = files[counter].replace(modname[0], '');
		var modulename = modname[0].replace('.js', '').replace('/', '');
		var writefile = '';
		
		var 
		fs = require('fs'),
	    path = require('path');
		      	
		var templateName = __dirname + '/../views/testcreate.ejs';
	    var templateStr = fs.readFileSync(templateName, 'utf8');
	    var thisEJS = require('ejs');
	    var poString = thisEJS.render(templateStr, {
	        locals: {
	            'modulename': modulename,
	            'filename': filename
	        	}
	    });
	    
		fs.writeFileSync('test/' + modulename + '.js', poString, encoding='utf8');
	}
	next();
	
}



//// perform these actions in sequence:
var moduleStack = [
        hasPermission,  // make sure we have permission to access this
        initData,
        createTest // create test
        ];
        
        
////---------------------------------------------------------------------
app.all('/testunit/test/create', moduleStack, function(req, res, next) {
    
    // by the time we enter this, we should have done all our steps
    // for this operation.
    //LogDump(req,'  - finished');
    
    // send a success message
	AD.Comm.Service.sendSuccess(req, res, { 
        message:            
         'Test created.'
 } );
	
});
