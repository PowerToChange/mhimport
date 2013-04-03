
////
//// Strip SVN
//// 
//// RAD tool utility to remove any .svn directories from a directory
//// path.

exec = require("child_process").exec;



////---------------------------------------------------------------------
var cleanDir = function (req, res, next) {
    // process all the deletes.

    deleteDir(req, next, 0, req.appDev.listDir);
}



////---------------------------------------------------------------------
var deleteDir = function (req, next, index, listDir) {
    // delete the directory at index
    
    if ( index >= listDir.length) {
    
        // all done, so do next
        next();
    
    } else {
    
        exec("rm -r "+listDir[index], function(err, stdout, stderr) {
           // handle error, stdout, stderr
           

           if (err) {
            
                AD.Util.Log(req, '  - ERROR: '+ err.message);
                next(err);
                
            } else {
        
                deleteDir( req, next, index+1, listDir);
            
            }
        });
//        fs.rmdir( listDir[index], function (err) {
//
//            
//        });
    
    }


}



////---------------------------------------------------------------------
var gatherList = function (req, res, next) {
    // Gather the required Data for this operation.

    recursiveDirScan(req, res, next, req.appDev.startDir, req.appDev.listDir);
    
}



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
var initData = function (req, res, next) {
    // Gather the required Data for this operation.

    var startDir = '';

    // pull in name & update moduleName/ModuleName
    if (typeof req.params['startDir'] != 'undefined') {
        startDir = req.params['startDir'];
    } else if (typeof req.query['startDir'] != 'undefined') {
        startDir = req.query['startDir'];
    }
    
    
    if (startDir !=  '') {
    
        
        // set up a counter for the number of recursions
        req.appDev = {};
        req.appDev.numRecursions = 0;
        req.appDev.listDir = [];
        
        req.appDev.startDir = startDir;
        
        // everything ok, so continue
        next();
        
 
        
    } else {
    
        Log(req, '  - error: No startDir Provided');
        LogDump(req, '');

        AD.Comm.Service.sendError(req, res, {errorData:'startDir not provided.'} );
        
    
    }

}



var recursiveDirScan = function (req, res, next, directory, listDir) {
    
    // our recursive level is beginning work
    req.appDev.numRecursions ++;
    
    fs.readdir(directory, function (err, files) {

        if (err) { 
                Log(req, ' ');
                Log(req, '**** path['+relativePathFromRoot(directory)+']');
                Log(req, '**** error['+err.message+']');
            
        } else {

            
            for(var fi in files) {
                var filePath = directory+'/'+files[fi];
                
                if (files[fi].indexOf(".svn") == 0) {
                
                    Log(req,'  - +++ adding filePath['+filePath+'] +++ ');
                    listDir.push(filePath);
                
                } else {
                
                    // ignore other files that begin with '.'
                    if (files[fi].indexOf(".") != 0) {
                        
                        var pathStat = fs.statSync(filePath);
                        if (pathStat.isDirectory()) {
                        
                            recursiveDirScan(req, res, next, filePath, listDir);
                        } 
                                                                
                    } // end if ! begin with '.'
                    
                } // end if == .svn
                
            }
        
        }
        
        // we are done at our recursion level:
        req.appDev.numRecursions--;
        if (req.appDev.numRecursions <= 0) {
            next();
        }
        
    });
    
}






//// perform these actions in sequence:
var moduleStack = [
        hasPermission,  // make sure we have permission to access this
        initData,       // prepare data (name & listTags) 
        gatherList,     // get a list of .svn directories under startDir   
        cleanDir,       // perform the rmdir operations
        ];


exports.setup = function(app) {
        
////---------------------------------------------------------------------
    app.all('/appRad/directory/stripsvn', moduleStack, function(req, res, next) 
    {
        //// Recursively scan all subdirectories under [startDir] and remove
        //// any .svn directories.
        //
        // test using: http://localhost:8085/appRad/directory/stripsvn?startDir=data/scripts/jquery/
    
        
            // by the time we enter this, we should have done all our steps
            // for this operation.
               
            AD.Util.LogDump(req,'  - finished');
    
            
            // send a success message
            AD.Comm.Service.sendSuccess(req, res, {message:'all directories traversed.' } );
    
        
    });
    
}
