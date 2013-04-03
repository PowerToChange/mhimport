// Replace These Tags:
//  powerToChange  : <-- the name of this module (lowercase)
//  PowerToChange  : <-- the name of this module (uppercase)
 
var log = AD.Util.Log;
var $ = AD.jQuery;


////
//// PowerToChange Module
////

var powerToChangeModule = new AD.App.Module({
    nameModule: 'powerToChange',
    pathModule: __dirname,
/*
    // change the default paths like this:
    pathInterfaces:    __dirname + '/interfaces',
    pathServerModels:  __dirname + '/models/node',
    pathClientModels:  __dirname + '/models/client',
    pathModuleScripts: __dirname + '/data/scripts',
    pathModuleCSS:     __dirname + '/data/css'
*/
/*
    // If you want to override the default notification hub settings:
    hub: {
          wildcard: true, // should the event emitter use wildcards.
          delimiter: '.', // the delimiter used to segment namespaces.
          maxListeners: 0, // the max number of listeners that can be assigned to an event (defautl:10;  0:unlimited).
    }
*/
    
    });
    
powerToChangeModule.createRoutes();
var mI = powerToChangeModule.initialize();  // mI == Module Initialization Done
$.when(mI).then(function(){
    // do any post initialization setup instructions here.
    // by the time you get here, all module resources are loaded.
});


module.exports = powerToChangeModule;
exports.version = 1;  // v1 of our AD.App.Module Definition


var app = powerToChangeModule.app;


/*
////
//// setup any PowerToChange specific routes here
////

### If you want to override the default Route Handling then
### remove powerToChangeModule.createRoutes(); and uncomment this section.  
### Make your changes here:

////
//// On any /powerToChange/* route, we make sure our Client Models are loaded:
//// 
app.get('/init/powerToChange/*', function(req, res, next) {

        log(req,' init/' + powerToChangeModule.nameModule + '/*  : adding model dependencies.');

        AD.App.Page.addJavascripts( req, powerToChangeModule.moduleScripts );
        AD.App.Page.addJavascripts( req, powerToChangeModule.listModelPaths );

        next();
});





////
//// Return any Module defined resources
////
app.get('/powerToChange/data/:resourcePath', function(req, res, next) {

    log(req,' /' + powerToChangeModule.nameModule + '/data/ being processed.');

    var parts = req.url.split('/'+powerToChangeModule.nameModule+'/');
    var urlParts = parts[1].split('?');
    var path = urlParts[0]; // without any additional params

    res.sendfile( powerToChangeModule.pathModule+'/'+path);
});







### If you want to change/prevent any of the automatic directory 
### scanning, then remove the powerToChangeModule.initialize()  and 
### uncomment these lines :




//// 
//// Scan any sub interfaces to gather their routes
////

powerToChangeModule.loadInterfaces();



////
//// The Model objects 
////
//// Load the Server side model objects to handle incoming model actions.
////

powerToChangeModule.loadModels();
exports.listModels=powerToChangeModule.listModels;


////
//// 
//// Load the shared scripts that need to be used on each interface.

powerToChangeModule.loadModuleScripts();



//// Load the services associated with this Module.
powerToChangeModule.loadServices();



//// Load any shared CSS files defined by this Module.
powerToChangeModule.loadModuleCSS();

*/