////
//// Login
////
//// This is the Interface level definition for the Login page.
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



var loginInterface = new AD.App.Interface({
    pathModules: __dirname + '/containers',
    pathScripts: __dirname+'/scripts/',
    pathServices: __dirname+'/services/',
    listWidgets: [ 
                    'appdev_menu_ipod', 
// AppRAD: WIDGET DEPENDENCY //    
                 ]
    });
module.exports = loginInterface;

////
//// View Routes
////

var app = loginInterface.app;


////
//// setup any /site/login specific routes
////

//// this route is for returning the javascript dependencies for this page
app.get('/init/site/login/login.js', function(req, res, next) {

    //// We are returning our dependencies to our dependency manager (steal)
    //// We need to return 
    ////    listJavascripts:  our javascript functions 
    ////    listCSS:          our css dependencies
    ////    nameSetupFunction: the name of our client side javascript setup
    ////                      function.
    //// 
    req.aRAD.response.nameSetupFunction = 'ad.site.login.radsetup';
    AD.App.Page.addJavascripts( req, loginInterface.getJavascripts() );
    AD.App.Page.returnStealData(req, res);
});



app.get('/page/site/login', AD.Lang.loadLabelsByPath, AD.Lang.loadLanguages, function (req, res, next) {

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
    
    req.aRAD.response.pathTemplate = __dirname+'/views/login.ejs';
    req.aRAD.response.themePageStyle = 'empty';  // display the login on an empty page style

    var viewer = AD.Viewer.currentViewer(req);
    req.aRAD.response.labels.langKey = viewer.languageKey;
    
    req.aRAD.response.templateData = { title:'login', labels:req.aRAD.response.labels, listLanguages:req.aRAD.response.listLanguages };
    
    // if we need to add javascripts to the page 
    // (that don't already get included via the steal system)
    // then do: 
    // req.aRAD.response.listJavascripts.push('path/to/script.js');
    
    req.aRAD.response.pathSteal = '/init/site/login';
    
    AD.App.Page.addCSS( req, loginInterface.getCSS() );
    
    //// The app.js -> returnPage() routine is responsible for taking this 
    //// interface's data and wrapping it in our Site Template.  The 
    //// response is returned there.
    req.aRAD.returnPage( req, res );
    
});



//// Now insert the authenticate url and it's action:
app.all('/service/site/login/authenticate', AD.Auth.login );



