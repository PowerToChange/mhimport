
////
//// TemplateHTML
////
//// Performs the actions for templateHTML.
////
////    /appRad/templateHTML/create 
////
////


//var myDB = require('database.js').sharedDB();
var log = AD.Util.Log;
var logDump = AD.Util.LogDump;

var spawn = require('child_process').spawn;
var path = require('path');


////---------------------------------------------------------------------
var hasPermission = function (req, res, next) {
    // Verify the current viewer has permission to perform this action.

    console.log('in hasPermission');

    // if viewer has 'appRAD.Developer' action
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

}



////---------------------------------------------------------------------
var setupReq = function (req, res, next) {
    // setup our req object as if we were a /page request 
   

    // This route is designed to act as a page in the system, with all the properly loaded 
    // javascripts and such.
    
    req.aRAD.response.pathTemplate = __dirname+'/../views/templateHTMLSite.ejs';

//    var viewer = AD.Viewer.currentViewer(req);
//    req.aRAD.response.labels.langKey = viewer.languageKey;
    
    req.aRAD.response.templateData = { title:'login', labels:req.aRAD.response.labels, listLanguages:req.aRAD.response.listLanguages };
    
 //   req.aRAD.response.pathSteal = '/init/appRAD/portal/portal.js';  // request our 
    
    AD.App.Page.addCSS( req, [] );
    
    // now the req obj should be ready for rendering:
    next();
}



////---------------------------------------------------------------------
var createTempOutputDir = function (req, res, next) {
    // Create a temporary output directory to store our package in


    AD.Util.Temp.mkdir('aRAD_htmlTmpl',function( err, dirPath){
        
        if (err){
            AD.Util.Error(req,'   * Error making temp directory: '+err);
            next(err);
        }
        else {
            AD.Util.Log(req,'   - Temp directory made['+dirPath+']');
            req.aRAD._pathTmpDir = dirPath;
//req.aRAD._pathTmpDir = __appdevPath+'/../development/package';
            next();
        }
        
    });

}



////---------------------------------------------------------------------
var saveRenderedPage = function (req, res, next) {
    //Create a temporary output directory to store our package in
    
    var renderedPage = req.aRAD._renderedPage;
    
    // replace 'http://localhost:xxxx' with 'data'
    renderedPage = AD.Util.String.replaceAll(renderedPage, AD.Defaults.siteURL, 'data');
    var path = req.aRAD._pathTmpDir;
    fs.writeFile(path + '/index.html', renderedPage, function (err) {
        if (err) {
            AD.Util.Error(req, '   * Error writing index.html:'+err);
            next(err);
        }
        else {
            AD.Util.Log(req, '   - Wrote index.html');
            next();
        }
      });

}



////---------------------------------------------------------------------
var determineFilesToCopy = function (req, res, next) {
    // figure out what additional resources to copy into the dest directory
    
    var fileContent = req.aRAD._renderedPage;
    
    // figure out which files are being required for the page:
    // Figure out which Theme:
    var theme = 'default';
    //   var myCSSRegexp= /data\/theme\/([^\/]*)/g;
    var myCSSRegexp = new RegExp("<link href=\""+AD.Defaults.siteURL+"/theme/([^/]*)","g");
    var match = myCSSRegexp.exec(fileContent);
    if (match != null) {
        theme = match[1];
    }
    
    // find all javascript files:
    var listJS = [];
    var myJSRegexp = new RegExp("<script src=\""+AD.Defaults.siteURL+"([^\"]*)","g");
    //var myJSRegexp= /<script src="http:\/\/localhost:8085([^"]*)/g;
    var match = myJSRegexp.exec(fileContent);
    while(match != null) {
        
        listJS.push(match[1]);
        match = myJSRegexp.exec(fileContent);
    }
    
    req.aRAD._filesToCopy = {};
    req.aRAD._filesToCopy.themeToCopy = theme;
    req.aRAD._filesToCopy.listJS = listJS;
    
    next();
}



////---------------------------------------------------------------------
var recursiveDirCreate = function(currIndx, listDir, next) {
    // sequentially create the given directories then call next();
    
    if (currIndx < listDir.length) {
        fs.mkdir(listDir[currIndx], function() {
           
            recursiveDirCreate(currIndx+1, listDir, next);
        });
    } else {
        next();
    }
    
}



////---------------------------------------------------------------------
var createDirectories = function (req, res, next) {
    // create all the directories necessary for our new package

    var themeName = req.aRAD._filesToCopy.themeToCopy;
    var pathTempDir = req.aRAD._pathTmpDir;
    var listDirectories = [
           pathTempDir+'/data',
           pathTempDir+'/data/theme',
           pathTempDir+'/data/theme/'+themeName,
           pathTempDir+'/data/scripts'
    ];
    
    
    recursiveDirCreate(0, listDirectories, next);

}



////---------------------------------------------------------------------
var recursiveCommands = function (currIndx, listCommands, next) {
    // sequentially process the array of commands then call next()
    
    if (currIndx < listCommands.length){
        var allCmd = listCommands[currIndx];
        
        AD.Util.Log('   - command:'+ allCmd.cmd);
        
        //// NOTE: spawn can't just say spawn('cp -r /path/to/1 /path/to/2');
        var cmd = spawn(allCmd.cmd, allCmd.args, allCmd.opt);
        cmd.stdout.on('data', function(data){
            AD.Util.Log('     stdout: '+data);
        });
        cmd.stderr.on('data', function(data){
            AD.Util.Error('     stderr: '+data);
        });
        
        cmd.on('exit', function(){
            AD.Util.Log('      done');
            recursiveCommands(currIndx+1, listCommands, next);
        });
    
    } else {
        next();
    }
    
}



////---------------------------------------------------------------------
var copyData = function (req, res, next) {
    // copy our required javascript files
    
    var themeName = req.aRAD._filesToCopy.themeToCopy;
    var pathTempDir = req.aRAD._pathTmpDir;
    
    var listCommands = [];
    
    // command to copy theme info:
    listCommands.push({cmd:'tar', args:[ '-cjf', themeName+'.tbz', themeName ] , opt:{cwd:__appdevPath+'/data/theme/'}});
    listCommands.push({cmd:'mv', args:[ __appdevPath+'/data/theme/'+themeName+'.tbz', pathTempDir+'/data/theme/.'] });
    listCommands.push({cmd:'tar', args:[ '-xjf', themeName+'.tbz'],  opt:{cwd:pathTempDir+'/data/theme/'} });
    listCommands.push({cmd:'rm', args:[ pathTempDir+'/data/theme/'+themeName+'.tbz'] });
    
    
    var listJS = req.aRAD._filesToCopy.listJS;
    var cpJSCmd = '';
    for(var j in listJS) {
        listCommands.push({cmd:'cp', args:[ __appdevPath+'/data'+listJS[j], pathTempDir+'/data/scripts/.'] });
    }
    
    recursiveCommands(0, listCommands, next);
}



////---------------------------------------------------------------------
var compressOutputDir = function (req, res, next) {
    // now compress our resulting directory
    
    var pathTempDir = req.aRAD._pathTmpDir;
    
    var parts = pathTempDir.split('/');
    var actualDir = parts[parts.length-1];
    delete parts[parts.length-1];
    var pathNew = parts.join('/');
    
    req.aRAD._finalPath = pathNew;
    req.aRAD._finalFile = 'package.tbz'; //actualDir+'.tbz';

    var listCommands = [];
    
    // command to copy theme info:
    listCommands.push({cmd:'mv', args:[ actualDir, 'package' ] , opt:{cwd:pathNew}});
    listCommands.push({cmd:'tar', args:[ '-cjf', 'package.tbz', 'package' ] , opt:{cwd:pathNew}});
    listCommands.push({cmd:'rm', args:[ actualDir, 'package' ] , opt:{cwd:pathNew}});
    
    recursiveCommands(0, listCommands, next);
}




var templateHTMLStack = [
        hasPermission,      // make sure we have permission to access this
        AD.Lang.loadLabelsByPath, 

        setupReq,           // make sure our req object has 
        AD.App.Page.renderPageStack,
        createTempOutputDir,
        saveRenderedPage,
        determineFilesToCopy,
        createDirectories,
        copyData,
        compressOutputDir,
//      returnCompressedFile
        
    ];
 

////---------------------------------------------------------------------
app.all('/service/appRad/templateHTML/create', templateHTMLStack, function(req, res, next) {
    //// Creates a new model from DB table X  under application Module Y
    // test using: http://localhost:8085/service/appRad/templateHTML/create

//console.log(req.aRAD);

    logDump(req, 'finished templateHTML/create');
    
    var pathToFile = req.aRAD._finalPath;
    var fileName = req.aRAD._finalFile;
    res.contentType('application/x-tar');
    // NOTE: if you don't do this and your path has a ../ in it, you get "Forbidden" 
    // as a result.
    var finalPath = path.normalize(pathToFile+'/'+fileName);
    res.download(finalPath, 'package.tbz');
    
});





