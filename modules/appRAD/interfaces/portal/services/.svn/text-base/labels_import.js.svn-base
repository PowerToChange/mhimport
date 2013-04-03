
////
//// Labels Import
////
//// Imports a set of labels from a module to gettext format for translation
    // test using: usage:

	// to import a specific file: 
	// 		url?path=/path/one & file=label_en.po

	// to import any label_xx.po file in a given directory:
	// 		url?path=/path/one

	// to import any english .po files in several directories:
	// 		url?path=/path/one,/path/two,/path/three & file=label_en.po

	// to import any .po files in several directories:
	// 		url?path=/path/one,/path/two,/path/three
    


var Label = require(__appdevPath + '/modules/site/models/Labels.js');



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
    var path = $_REQUEST['path'];
    var file = $_REQUEST['file'];
    
    
    if (!path || !file) {
        Log(req, '  - error: some data not provided path['+path+'] path['+file+']');
        LogDump(req, '');

        AD.Comm.Service.sendError(req, res, {errorMSG:'some data not provided path['+path+'] file['+file+']'} );
        return;
    }

    else {
        
        
        req.aRAD.path = path;
        req.aRAD.file = file;

        
        next();
    }
    
}

/*  // Not sure if we want to scan subdirectories too, if so, will need this function
var recursiveFileScan = function (path, listPaths, searchKey) {
    //console.log('recursiveFileScan:' + path + ', ' + searchKey);
    //console.log(listPaths);
    
    // Recursively search for files that match the given 
    // searchKey.  Start in the directory given in path and 
    // search each sub directory.
    // All matches are added to the array listPaths.

    var listFiles = fs.readdirSync(path);
    for (var indx =0; indx < listFiles.length; indx++) {
    
        var fileName = listFiles[indx];
        
        // if this is NOT a .xxx file
        if (fileName.indexOf(".") != 0) {
         
            var filePath =  path + '/' + fileName;

            // if this is a label file,
            if (fileName.indexOf(searchKey) > -1) {
                
                // add to listPaths 
                listPaths.push(filePath );
                
            } else {
            
            
                // if this is a directory
                var stats = fs.statSync(filePath);
                if (stats.isDirectory()) {
                
                    // scan this directory too
                    recursiveFileScan( filePath, listPaths, searchKey);
                }
            
            }
            
        }
    
    }

};
*/

var loadFile = function (filepath) {
	var basedir = fs.realpathSync(__dirname + '/../../../../');
	return fs.readFileSync(basedir + filepath, 'utf8');
}


var loadDirectory = function (dirpath) {
	
    // scan all the directory for possible labels and install
    // them.    
        
	var dirlist =  fs.readdirSync(dirpath);
	var allcontents = '';
	
	for (var i=0; i<dirlist.length; i++) {
		if (dirlist[i].match(/\.po$/) != null)
			{
				allcontents += loadFile(dirpath + dirlist[i]);
			}
	}

	return allcontents;
};



// read the module's source language labels from the database
var loadData = function(req, res, next) {
    
    var all_paths =  req.aRAD.path;
    var all_files =  req.aRAD.file;
    
    var paths = all_paths.split(',');
    var files = all_files.split(',');
    
	var readydata = [];
    var all_contents = '';
    if (paths.length > 0) {
    	
    	for (var i=0; i<paths.length; i++) {
    		
    		if (files.length >0) {
    	    	for (var ii=0; ii<files.length; ii++) {
    	    		all_contents += loadFile(paths[i] + '/' + files[ii]);
    	    	}
    		} else {
    			all_contents += loadDirectory(paths[i]);
    		}
    		
    	}
    	
    	var allcontentssplit = all_contents.split(/(\r\n|\r|\n)\s*(\r\n|\r|\n)/);

    	for (var i=0; i<allcontentssplit.length; i++)
    		{
    			var newstr = trim(allcontentssplit[i]);
    			if (newstr != '') {

    				var iscomment = false;
    			    var thepath = newstr.match(/path\: .*/) == null ? iscomment = true : newstr.match(/path\: .*/)[0].replace('path: ', '').trim() ;
    				var thecode = newstr.match(/code\: .*/) == null ? iscomment = true : newstr.match(/code\: .*/)[0].replace('code: ', '').trim() ;
    				var thekey = newstr.match(/key\: .*/) == null ? iscomment = true : newstr.match(/key\: .*/)[0].replace('key: ', '').trim() ;
    				var thestr = newstr.match(/(?:msgstr ")(.*)(?:"$)/) == null ? iscomment = true : newstr.match(/(?:msgstr ")(.*)(?:"$)/)[1].trim() ;

    				if (!iscomment)
    					{
    						readydata.push({ 
    							label_path: thepath,
    							language_code: thecode, 
    							label_key: thekey, 
    							label_lastMod: new Date(),
    							label_needs_translation: '0',
    							label_label: thestr});
    					}
    			}
    		}
    	
    }
    req.aRAD.readydata = readydata;
    
    next();
}



var grabAllLabels = function(alabel) {

	var code = alabel['language_code'];
	var path = alabel['label_path'];
	var key = alabel['label_key'];
    
    var atPos = key.indexOf('?');
    if (atPos == -1) {
	
        var conditionDest = "language_code='" + code + "' AND label_path='" + path + "' AND label_key='" + key + "'";

        Label.findAll({ dbCond: conditionDest }, function(resultArray) {
            
            //Log(resultArray);
            if (resultArray.length == 0) {
                Label.create(alabel, function(resultArrayc) {
                	Log('Imported label ' + resultArrayc['label_id']);
                });
            } else {
                alabel['dbCond'] = conditionDest;
                Label.update(alabel,function(resultArrayu) {
                    Log('Updated label ['+key+']');
                }, function(erru) {Log(erru); });
                
            }
        });
    
    } else {
    
        Log('   *** label key['+key+'] had a "?" in it which gives us some problems! ');
    
    }
}


// write .po entries to database
var importData = function(req, res, next) {
    
    var labelsImport = req.aRAD.readydata;
    
    
    for (var i=0; i< labelsImport.length; i++) {
    	
    	grabAllLabels(labelsImport[i]);
    	
    	
	}
        
    AD.Comm.Service.sendSuccess(req, res, { 
        message:             
            labelsImport.length + ' labels imported.'
    } );
}



var trim = function (str) {
    return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
};


//// perform these actions in sequence:
var moduleStack = [
        hasPermission,  // make sure we have permission to access this
        initData,       // prepare data (name & listTags)   
        loadData,      
        importData
        ];
        
        
exports.setup = function(app) {

    ////---------------------------------------------------------------------
    app.all('/appRad/labels/import', moduleStack, function(req, res, next) {
        
        // by the time we enter this, we should have done all our steps
        // for this operation.
        LogDump(req,'  - finished');
        
        // send a success message
        AD.Comm.Service.sendSuccess(req, res, {message:'all module templates written.' } );
        
    });
    
}