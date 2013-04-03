
////
//// Interface Create
////
//// This service is designed to create a new interface directory.
////
////    /appRad/interface/create   : module=M & name=X 
////        Creates a new interface named X:  
////                    /root/modules/[M]/interfaces/[X]/
////
////


////
//// Setup the Template Definitions:
////

//// NOTE: the keys in listTemplatesModel & listDestinationsModel must match.
////       

var listTemplates = {
    '/modules/appRAD/data/templates/node/node_interface.js':{
        data:'',
        destDir:'/modules/[module]/interfaces/[interface]/node_[interface].js',
        userManaged:true
    },
    
    '/modules/appRAD/data/templates/client/interface.js':{
        data:'',
        destDir:'/modules/[module]/interfaces/[interface]/scripts/[interface].js',
        userManaged:true
    },
    
    '/modules/appRAD/data/templates/client/interfaceRAD.js':{
        data:'',
        destDir:'/modules/[module]/interfaces/[interface]/scripts/[interface]RAD.js',
        userManaged:true
    },
    
    
    '/modules/appRAD/data/templates/node/interface.ejs':{
        data:'',
        destDir:'/modules/[module]/interfaces/[interface]/views/[interface].ejs',
        userManaged:true
    },

};
    
   

// list of directories that need to be created for the Module
var listDestinationsDirectories = {
    '/modules/[module]/interfaces/[interface]':'-',
    '/modules/[module]/interfaces/[interface]/containers':'-',
    '/modules/[module]/interfaces/[interface]/css':'-',
    '/modules/[module]/interfaces/[interface]/scripts':'-',
    '/modules/[module]/interfaces/[interface]/services':'-',
    '/modules/[module]/interfaces/[interface]/views':'-',
    
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
        interface:'?interface?',
        interfaceName:'?interfaceName?',
        InterfaceName:'?InterfaceName?',
    };
    
    var name;
    var module;

    // pull in name & update moduleName/ModuleName
    if (typeof req.params['name'] != 'undefined') {
        name = req.params['name'];
        module = req.params['module'];
    } else if (typeof req.query['name'] != 'undefined') {
        name = req.query['name'];
        module = req.query['module'];
    }
    
    
    if ((typeof name !=  'undefined') && (typeof module != 'undefined')){
    
        listTags.module = module;
        listTags.moduleName = module.charAt(0).toLowerCase() + module.substr(1);
        listTags.ModuleName = module.charAt(0).toUpperCase() + module.substr(1);
        
        listTags.interface = name;
        listTags.interfaceName = name.charAt(0).toLowerCase() + name.substr(1);
        listTags.InterfaceName = name.charAt(0).toUpperCase() + name.substr(1);

        
        // save our values to our template tools
        templateTool.saveValues(req, listTags);
        
        // everything ok, so continue
        next();
        
 
        
    } else {
    
        AD.Util.Log(req, '  - error: some data not provided name['+name+'] module['+module+']');
        AD.Util.LogDump(req, '');

        AD.Comm.Service.sendError(req, res, {errorMSG:'some data not provided name['+name+'] module['+module+']'} );
        
    
    }

}





//// Define functions for passing control to our templateTool object:
var createDirectory = function (req, res, next) { templateTool.createDirectory(req, res, next); }
var createTemplates = function (req, res, next) { templateTool.createTemplates(req, res, next); }



//// Create our Template Tools object
var TemplateTools = require('./objects/templateTools.js');
var templateTool = new TemplateTools({
    listDirectories: listDestinationsDirectories,
    listTemplates:listTemplates
});



//// perform these actions in sequence:
var moduleStack = [
        hasPermission,  // make sure we have permission to access this
        initData,       // prepare data (name & listTags)    
        createDirectory,// verify all the Directories exist
        createTemplates,// create all the expected Templates
        ];
        
        
exports.setup = function(app) {

    ////---------------------------------------------------------------------
    app.all('/appRad/interface/create', moduleStack, function(req, res, next) {
        //// Creates a new Interface : /root/[module]/interfaces/[name]
        // test using: http://localhost:8085/appRad/interface/create?name=testInterface&module=testModule
    
        
            // by the time we enter this, we should have done all our steps
            // for this operation.
            AD.Util.LogDump(req,'  - finished');
    
            
            // send a success message
            AD.Comm.Service.sendSuccess(req, res, {message:'all module templates written.' } );
    
        
    });

}




//Asynchronously Load our Model templates when this service is loaded.
for (var ti in listTemplates) {
    var templatePath = __appdevPath+ti;
    templateTool.loadTemplate(ti, templatePath, listTemplates);
}



