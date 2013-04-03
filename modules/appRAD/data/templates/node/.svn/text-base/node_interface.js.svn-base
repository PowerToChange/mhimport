//// Template Replace:
//   [moduleName]     : the name of this interface's module: (lowercase)
//   [interfaceName]  : the name of this interface :  (lowercase)
//   [InterfaceName]  : the name of this interface :  (Uppercase)


////
//// [InterfaceName]
////
//// This is the Interface level definition for the [InterfaceName] page.
////
//// An "interface" is usually a new page displayed in the browser, 
//// requiring a full page load.  
////
//// An interface is required to load:
////    listJavascripts :  all the javascript files required for this page
////    listCSS : any css files required for this page
////    pathTemplate: the path from the site root to the template file to 
////                  use to render the page content
////    templateData: an object representing all the data to use to render 
////                  the template for this page content



var [interfaceName]Interface = new AD.App.Interface({
    pathInterface: __dirname,
/*
    pathModules: __dirname + '/containers',
    pathScripts: __dirname+'/scripts',
    pathServices: __dirname+'/services',
*/
    listWidgets: [ 
// AppRAD: WIDGET DEPENDENCY //    
                 ]
    });
module.exports = [interfaceName]Interface;   

////
//// View Routes
////

var app = [interfaceName]Interface.app;

////
//// setup any /[moduleName]/[interfaceName] specific routes
////

//// this route is for returning the javascript dependencies for this page
app.get('/init/[moduleName]/[interfaceName]/[interfaceName].js', function(req, res, next) {

    //// We are returning our dependencies to our dependency manager (steal)
    //// We need to return 
    ////    listJavascripts:  our javascript functions 
    ////    listCSS:          our css dependencies
    ////    nameSetupFunction: the name of our client side javascript setup
    ////                      function.
    //// 
    req.aRAD.response.pathLabels = 'labels/[moduleName]/[interfaceName]/labels.js';
    req.aRAD.response.nameSetupFunction = 'ad.[moduleName].[interfaceName].radsetup';
    AD.App.Page.addJavascripts( req, [interfaceName]Interface.getJavascripts() );
    AD.App.Page.returnStealData(req, res);
});



//// this route is for returning the labels for this page
app.get('/labels/[moduleName]/[interfaceName]/labels.js', AD.Lang.loadLabelsByPath, function(req, res, next) {

    //// We are initializing a set of labels associated with this 
    //// Interface.
    ////
    //// load the req object with this interface's path
    //// and let the app.js -> returnLabelData() handle the response.
    //// 
    req.aRAD.response.pathInterface = 'test/viewer/';
    
    
    //// gather a list of all the label paths for this interface:
    var listLabelPaths = [];
    
    // Our basic page interface set:
    listLabelPaths.push('/page/[moduleName]/[interfaceName]');
    
    // gather all the labels required by our included widgets:
    for (var iLw = 0; iLw < [interfaceName]Interface.listWidgets.length; iLw++) {
        
        var key = [interfaceName]Interface.listWidgets[iLw];
        
        // if a site widget then pull label info from ListWidgets
        if (typeof ListWidgets[key] != 'undefined') {
            
            var widget = ListWidgets[key];  // defined in app.js
            for (var i=0; i < widget.listLabels.length; i++) {
                var labelPath = widget.listLabels[i];
                listLabelPaths.push(labelPath);
            }
            
        } else {
            
            // look locally for a widget
        
        }
    }
    req.aRAD.response.listLabelPaths = listLabelPaths;
    AD.App.Page.returnLabelData(req, res);
});



app.get('/page/[moduleName]/[interfaceName]', AD.Lang.loadLabelsByPath, function (req, res, next) {

    //// We are displaying our interface page.  We need to define the 
    //// following:
    ////    pathTemplate : the template to display in the 'content' portion
    ////                   of our siteContent.ejs template
    ////    templateData : any data to send to our template.
    ////                   {
    ////                        key1:value1,
    ////                        key2:value2,
    ////                        ....
    ////                        keyN:valueN
    ////                    }
    ////                    can be referenced in our pathTemplate.ejs file 
    ////                    as <%= data.keyN %>
    ////    listJavascripts : list any javascripts that can be loaded 
    ////                    outside of the steal dependency manager.  
    ////                    (eg only javascripts that do not need to be 
    ////                    loaded before your siteInterfaceRADSetup() is 
    ////                    called.)
    ////    listCSS :       list any css files that can be loaded outside of
    ////                    the steal dependency manager.
    ////    pathSteal:      the url to use for the steal dependency manager.
    ////                    the data returned should be a list of all the 
    ////                    javascript files necessary to load before your
    ////                    setup() routine is called.
    
    req.aRAD.response.pathTemplate = __dirname+'/views/[interfaceName].ejs';
//    req.aRAD.response.themePageStyle = 'empty';  // 'default': default Template Style, 'empty':empty Template Style   
    
    var viewer = AD.Viewer.currentViewer(req);
    req.aRAD.response.labels.langKey = viewer.language_code;
    
    
    req.aRAD.response.templateData = { title:'[interfaceName]', labels:req.aRAD.response.labels };
    
    
    // if we need to add javascripts to the page 
    // (that don't already get included via the steal system)
    // then do: 
    // req.aRAD.response.listJavascripts.push('path/to/script.js');
    req.aRAD.response.pathSteal = '/init/[moduleName]/[interfaceName]';
    
    
    // make sure we load our CSS information
    AD.App.Page.addCSS( req, [interfaceName]Interface.getCSS() );
        
        
    //// The AD.js -> AD.App.Page.returnPage() routine is responsible for  
    //// taking this interface's data and wrapping it in our Site Template. The 
    //// response is returned there.
    req.aRAD.returnPage( req, res );
    
});




/*
 * You can override the default setup routine by uncommenting this and 
 * making changes:
 * 
[interfaceName]Interface.setup = function(callback) 
{
    var $ = AD.jQuery;
    var dfd = $.Deferred();

    //// 
    //// Scan any sub containers to gather their routes
    ////
    var dfdContainers = [interfaceName]Interface.loadContainers();
    
    
    //// 
    //// Scan for any services and load them
    ////
    var dfdInterfaces = [interfaceName]Interface.loadServices();
    
    
    // Scan for any .css files registered for this interface
    [interfaceName]Interface.loadInterfaceCSS();
    
    // Create our routes : interface/css
    [interfaceName]Interface.createRoutes();

    ////
    //// Resolve the deferred when done
    ////
    $.when(dfdContainers, dfdInterfaces).then(function() {
        callback && callback();
        dfd.resolve();
    });
    
    return dfd;
}

*/
