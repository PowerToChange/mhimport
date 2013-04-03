/**
 * @class run_test_service
 * @parent Unit_Testing
 *
 * ###Running unit tests
 *  
 * This service allows us to run unit tests from within appDev and view the output in the console.
 *
 * * The URL to access the service is &lt;host&gt;/testunit/test/run
 *  
 * Run the tests in the file 'test/comm_servicetest.js';
 *
 * * &lt;url&gt;?filename=test/comm_servicetest.js
 *
 * Run all the tests in the directory test; 
 *
 * * &lt;url&gt;?filename=test
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

    
    if (!filename ) {
    	AD.Util.Log(req, '  - error: filename not provided');
        AD.Util.LogDump(req, '');

        AD.Comm.Service.sendError(req, res, {errorMSG:'filename not provided'} );
        return;
    }

    else {
                
        req.aRAD.filename = filename;
        
        console.log(req.aRAD);
        next();
    }
    
}


//send email
var runTest = function(req, res, next) {
 
	var filename = req.aRAD.filename; 
	
	var 
	fs = require('fs'),
    path = require('path');

	// TODO: remove this when https://github.com/joyent/node/pull/1312
	//       lands in core.
	//
	// Until then, use console.log from npm (https://gist.github.com/1077544)
	require('../../../../../node_modules/nodeunit/deps/console.log');
	
	//require.paths.push(process.cwd());
	var args = (process.ARGV || process.argv).slice(2);
	
	var files = [];
	
	var testrunner,
	    config_file,
	    config_param_found = false,
	    output_param_found = false,
	    reporter_file = 'default',
	    reporter_param_found = false,
	    testspec_param_found = false;
	    testFullSpec_param_found = false;
	
	var usage = "Usage: nodeunit [options] testmodule1.js testfolder [...] \n" +
	            "Options:\n\n" +
	            "  --config FILE     the path to a JSON file with options\n" +
	            "  --reporter FILE   optional path to a reporter file to customize the output\n" +
	            "  --list-reporters  list available build-in reporters\n" +
	            "  -t name,          specify a test to run\n" +
	            "  -f fullname,      specify a specific test to run. fullname is built so: \"outerGroup - .. - innerGroup - testName\"\n"  + 
	            "  -h, --help        display this help and exit\n" +
	            "  -v, --version     output version information and exit";
	            
	
	
	// load default options
	var rightpath = path.resolve(__dirname + '../../../../../../node_modules/nodeunit/bin/nodeunit.json');
	var content = fs.readFileSync( rightpath, 'utf8');
	var options = JSON.parse(content);
	
	// a very basic pseudo --options parser
	args.forEach(function (arg) {
	    if (arg.slice(0, 9) === "--config=") {
	        config_file = arg.slice(9);
	    } else if (arg === '--config') {
	        config_param_found = true;
	    } else if (config_param_found) {
	        config_file = arg;
	        config_param_found = false;
	    } else if (arg.slice(0, 9) === "--output=") {
	        options.output = arg.slice(9);
	    } else if (arg === '--output') {
	        output_param_found = true;
	    } else if (output_param_found) {
	        options.output = arg;
	        output_param_found = false;
	    } else if (arg.slice(0, 11) === "--reporter=") {
	        reporter_file = arg.slice(11);
	    } else if (arg === '--reporter') {
	        reporter_param_found = true;
	    } else if (reporter_param_found) {
	        reporter_file = arg;
	        reporter_param_found = false;
	    } else if (arg === '-t') {
	        testspec_param_found = true;
	    } else if (testspec_param_found) {
	        options.testspec = arg;
	        testspec_param_found = false;
	    } else if (arg === '-f') {
	        testFullSpec_param_found = true;
	    } else if (testFullSpec_param_found) {
	        options.testFullSpec= arg;
	        testFullSpec_param_found = false;
	    } else if (arg === '--list-reporters') {
	    	var rightpath2 = path.resolve(__dirname + '../../../../../../node_modules/nodeunit/lib/reporters');
	        var reporters = fs.readdirSync(rightpath2);
	        reporters = reporters.filter(function (reporter_file) {
	            return (/\.js$/).test(reporter_file);
	        }).map(function (reporter_file) {
	            return reporter_file.replace(/\.js$/, '');
	        }).filter(function (reporter_file) {
	            return reporter_file !== 'index';
	        });
	        console.log('Build-in reporters: ');
	        reporters.forEach(function (reporter_file) {
	            var reporter = require('../lib/reporters/' + reporter_file);
	            console.log('  * ' + reporter_file + (reporter.info ? ': ' + reporter.info : ''));
	        });
	        process.exit(0);
	    } else if ((arg === '-v') || (arg === '--version')) {
	        var content = fs.readFileSync(__dirname + '/../package.json', 'utf8');
	        var pkg = JSON.parse(content);
	        console.log(pkg.version);
	        process.exit(0);
	    } else if ((arg === '-h') || (arg === '--help')) {
	        console.log(usage);
	        process.exit(0);
	    } else {
	        files.push(arg);
	    }
	});
	
	if (filename.indexOf(',') == -1) {
		files.push(filename);
	} else {
		var filename_split = filename.split(",");
		var name;
		for (name in filename_split) {
			if (name.trim() != "")
				files.push(filename_split[name]);
		}
	}
	
	if (files.length === 0) {
	    console.log('Files required.');
	    console.log(usage);
	    process.exit(1);
	}
	
	if (config_file) {
	    content = fs.readFileSync(config_file, 'utf8');
	    var custom_options = JSON.parse(content);
	
	    for (var option in custom_options) {
	        if (typeof option === 'string') {
	            options[option] = custom_options[option];
	        }
	    }
	}
	
	rightpath = path.resolve(__dirname + '../../../../../../node_modules/nodeunit/lib/reporters');
	var builtin_reporters = require(rightpath);
	if (reporter_file in builtin_reporters) {
	    testrunner = builtin_reporters[reporter_file];
	}
	else {
	    testrunner = require(reporter_file);
	}
	
	testrunner.run(files, options, function(err) {
	    if (err) {
	        process.exit(1);
	    }
	});

	//next();

}



//// perform these actions in sequence:
var moduleStack = [
        hasPermission,  // make sure we have permission to access this
        initData,
        runTest // run test
        ];
        
        
////---------------------------------------------------------------------
app.all('/testunit/test/run', moduleStack, function(req, res, next) {
    
    // by the time we enter this, we should have done all our steps
    // for this operation.
    //LogDump(req,'  - finished');
    
    // send a success message
	AD.Comm.Service.sendSuccess(req, res, { 
        message:            
         'Done. Output sent to console.'
        	
 } );    
});
