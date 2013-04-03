
////
//// Service Create
////
//// This service is created to handle requests to generate a new service
//// for a Module.
////
////    /appRad/module/service/create   : module=X, serviceName=Y, actionName=Z
////        Creates a new service Y under application Module X
////
////


var myDB = require('database.js').sharedDB();


////
//// Setup the Model Template Definitions:
////
     


var listTemplatesService = {
    '/modules/appRAD/data/templates/node/service_action.js':{
            data:'',
            destDir:'/modules/[moduleName]/data/scripts/[serviceName]_[actionName].js',
            userManaged:false
    }
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
    
    
    var hasMissingData = false;
    var missingData = '';
    
    
    
    
    // a list of the required tags necessary in order to complete the
    // templates.  These tags should be supplied via the service call:
    var listTags = {
        moduleName:'?moduleName?',
        ServiceName:'?ServiceName?',
        serviceName:'?serviceName?',
        actionName:'?actionName?',
        url:''
        
    };
    

    // load Template tags for this model
    for (var ti in listTags) {
    
        if (typeof req.aRAD.$_REQUEST[ti] != 'undefined') {
            listTags[ti] = req.aRAD.$_REQUEST[ti];
        } else if (ti != 'url') {
            hasMissingData = true;
            missingData += ti +', ';
        }
    }
    
    // We can build the URL if it's not provided
    if (listTags.url === '') {
        listTags.url = listTags.moduleName+'/'+listTags.serviceName+'/'+listTags.actionName;
    }
    
    // if we have some missing tags 
    if (hasMissingData) {
    
        // respond with an error
        AD.Comm.Service.sendError(req, res, { errorMSG: 'missing parameters:['+missingData+']'} );
        
        
    } else {
    
        templateToolModel.saveValues(req, listTags);
    
        next();
    
    } 
    

}




// be sure to run through these filters before accessing our Create
// Service service:

//// Create our Template Tools object
var TemplateTools = require('./objects/templateTools.js');
var templateToolModel = new TemplateTools({
    listTemplates:listTemplatesService,
});


var createTemplates = function (req, res, next) { templateToolModel.createTemplates(req, res, next); }

var serviceStack = [
        AD.App.Page.serviceStack,
        hasPermission,  // make sure we have permission to access this
        initData,       // prepare data (name & listTags)    
        createTemplates,// create all the expected Templates
        ];
        


//Asynchronously Load our Service templates when this service is loaded.
for (var ti in listTemplatesService) {

    var path = __appdevPath+ti;
    templateToolModel.loadTemplate(ti, path, listTemplatesService);
    
}


exports.setup = function(app) {

    ////---------------------------------------------------------------------
    app.all('/appRad/module/service/create', serviceStack, function(req, res, next) {
        //// Creates a new model from DB table X  under application Module Y
        // test using: http://localhost:8085/appRad/module/service/create?module=test&serviceName=viewer&ServiceName=Viewer&actionName=update
    
        
        // By the time we get here, all the processing has taken place.
    
        AD.Util.LogDump(req, 'finished');
        
        
        // send a success message
        AD.Comm.Service.sendSuccess(req, res, {message:'all service templates written.' } );
    });
}