
////
//// Module Create
////
//// This service is designed to create a new module directory.
////
////    /appRad/module/create   : name=X 
////        Creates a new module named X:  /dir/modules/[X]/
////
////

var log = AD.Util.Log;
var logDump = AD.Util.LogDump;

////
//// Setup the Model Template Definitions:
////

//// NOTE: the keys in listTemplatesModel & listDestinationsModel must match.
////       

var listTemplatesModule = {
    '/modules/appRAD/data/templates/node/node_module.js':{
        data:'',
        destDir:'/modules/[module]/node_[module].js',
        userManaged:false
    },

};
  

// list of directories that need to be created for the Module
var listDestinationsDirectories = {
    '/modules/[module]':'-',
    '/modules/[module]/data':'-',
    '/modules/[module]/data/scripts':'-',
    '/modules/[module]/data/css':'-',
    '/modules/[module]/interfaces':'-',
    '/modules/[module]/models':'-',
    '/modules/[module]/install': '-',
    '/modules/[module]/install/data': '-',
};





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


// a list of the required tags necessary in order to complete the
    // templates.  These tags should be supplied via the service call:
    var listTags = {
        module: '?module?',
        moduleName: '?moduleName?',
        ModuleName: '?ModuleName?',
    };
    
    var name = '';

    // pull in name & update moduleName/ModuleName    
    if (req.aRAD.$_REQUEST['name'] !== undefined) {
    	name = req.aRAD.$_REQUEST['name'];
    }
    
    
    if (name !=  '') {
    
        listTags.module = name;
        listTags.moduleName = name.charAt(0).toLowerCase() + name.substr(1);
        listTags.ModuleName = name.charAt(0).toUpperCase() + name.substr(1);

        
        // save our values to our template tools
        templateTool.saveValues(req, listTags);
        
        // everything ok, so continue
        next();

    } else {
    
        log(req, '  - error: No Name Provided');
        logDump(req, req);

        AD.Comm.Service.sendError(req, res, {errorData:'name not provided.'} );

    }

}





//// Define functions for passing control to our templateTool object:
var createDirectory = function (req, res, next) { templateTool.createDirectory(req, res, next); }
var createTemplates = function (req, res, next) { templateTool.createTemplates(req, res, next); }



//// Create our Template Tools object
var TemplateTools = require('./objects/templateTools.js');
var templateTool = new TemplateTools({

    listDirectories: listDestinationsDirectories,
    listTemplates:listTemplatesModule,
});



//// perform these actions in sequence:
var moduleStack = [
        AD.App.Page.serviceStack,  // authenticates viewer, and prepares req.aRAD obj.
        hasPermission,  // make sure we have permission to access this
        initData,       // prepare data (name & listTags)    
        createDirectory,// verify all the Directories exist
        createTemplates,// create all the expected Templates
        ];
        

exports.setup = function(app) {

    ////---------------------------------------------------------------------
    app.all('/appRad/module/create', moduleStack, function(req, res, next) {
        //// Creates a new Module : /root/modules/[X]/
        // test using: http://localhost:8085/appRad/module/create?name=testModule
    
        
            // by the time we enter this, we should have done all our steps
            // for this operation.
               
            logDump(req,'  - finished');
    
            // our Model type objects want an id returned after a create type operation
            // so we will add that here.  However, for this service, our id=name
            var name = req.aRAD.$_REQUEST['name'];
            
            // send a success message
            AD.Comm.Service.sendSuccess(req, res, {id:name, message:'all module templates written.' } );
    
        
    });

}




//Asynchronously Load our Model templates when this service is loaded.
for (var ti in listTemplatesModule) {
    
    var templatePath = __appdevPath+ti;
    templateTool.loadTemplate(ti, templatePath, listTemplatesModule);
}



