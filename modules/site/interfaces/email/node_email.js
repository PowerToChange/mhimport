//// Template Replace:
//   site     : the name of this interface's module: (lowercase)
//   email  : the name of this interface :  (lowercase)
//   Email  : the name of this interface :  (Uppercase)


////
//// Email
////
//// This is the Interface level definition for the Email page.
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



var emailInterface = new AD.App.Interface({
    pathInterface: __dirname,

    //pathModules: __dirname + '/containers',
    pathScripts: __dirname+'/scripts',
    pathServices: __dirname+'/services',

    listWidgets: [ 
                  'appdev_testwidget',
// AppRAD: WIDGET DEPENDENCY //    
                 ]
    });
    
module.exports = emailInterface;    

////
//// View Routes
////

var app = emailInterface.app;


////
//// setup any /site/email specific routes
////

//// this route is for returning the javascript dependencies for this page
app.get('/init/site/email/email.js', function(req, res, next) {

    //// We are returning our dependencies to our dependency manager (steal)
    //// We need to return 
    ////    listJavascripts:  our javascript functions 
    ////    listCSS:          our css dependencies
    ////    nameSetupFunction: the name of our client side javascript setup
    ////                      function.
    //// 
    req.aRAD.response.pathLabels = 'labels/site/email/labels.js';
    req.aRAD.response.nameSetupFunction = 'ad.site.email.radsetup';
    addJavascripts( req, emailInterface.getJavascripts() );
    returnStealData(req, res);
});


/*
//// this route is for returning the labels this page
app.get('/labels/site/email/labels.js', multilingual.loadLabelsByPath, function(req, res, next) {

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
    listLabelPaths.push('/page/site/email');
    
    // gather all the labels required by our included widgets:
    for (var iLw = 0; iLw < emailInterface.listWidgets.length; iLw++) {
        
        var key = emailInterface.listWidgets[iLw];
        
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
    returnLabelData(req, res);
});
*/


app.get('/page/site/email', AD.Lang.loadLabelsByPath, function (req, res, next) {

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
    
    req.aRAD.response.pathTemplate = __dirname+'/views/email.ejs';
    
    var viewer = Viewer.currentViewer(req);
    req.aRAD.response.labels.langKey = viewer.language_code;
    
    
    req.aRAD.response.templateData = { title:'email', labels:req.aRAD.response.labels };
    
    
    // if we need to add javascripts to the page 
    // (that don't already get included via the steal system)
    // then do: 
    // req.aRAD.response.listJavascripts.push('path/to/script.js');
    req.aRAD.response.pathSteal = '/init/site/email';
    
    
    // make sure we load our CSS information
    addCSS( req, emailInterface.getCSS() );
        
        
    //// The app.js -> returnPage() routine is responsible for taking this 
    //// interface's data and wrapping it in our Site Template.  The 
    //// response is returned there.
//    if (typeof req.aRAD.returnPage != 'undefined') {
        req.aRAD.returnPage( req, res );
//    } else {
//        returnPage( req, res );
//    }
    
});


