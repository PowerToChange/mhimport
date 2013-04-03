
 
////
//// AppRAD Module
////

var $ = AD.jQuery;

var appRADModule = new AD.App.Module({
    nameModule: 'appRAD',
    pathModule: __dirname,
        
    });
    

appRADModule.createRoutes();
var mI = appRADModule.initialize();  // mI == Module Initialization Done
$.when(mI).then(function(){
    // do any post initialization setup instructions here.
    // by the time you get here, all module resources are loaded.
});


module.exports = appRADModule;

var app = appRADModule.app;

/*
////
//// setup any AppRAD specific routes here
////




////
//// On any /appRAD/* route, we make sure our Client Models are loaded:
//// 
app.get('/init/appRAD/*', function(req, res, next) {

Log(req,' init/appRAD/*  : adding model dependencies.');

    addJavascripts( req, appRADModule.clientModels );

    next();
});






//// 
//// Scan any sub interfaces to gather their routes
////

appRADModule.loadInterfaces();



////
//// The Model objects 
////
//// Load the Server side model objects to handle incoming model actions.
////

appRADModule.loadServerModels();
exports.listModels=appRADModule.listModels;



////
//// 
//// Load the Client Side models and be sure they are included in the page
//// dependencies.

appRADModule.loadClientModels();

*/