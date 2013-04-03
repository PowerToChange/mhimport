
////
//// View Routes
////



////
//// setup any /site specific routes
////
app.get('/', function (req, res) {

    res.send(' default / ' );
});




////
//// create routes for our module's Data Storage
////
//// these should have /site.data/[modelName]/[id]
////
app.get('query/site.data/:model/:id?', function( req, res) {

    res.send('<h1>siTe model['+req.params.model+'] called['+req.params.id+']</h1>');

});




////
//// On any /site/* route, we make sure our Client Models are loaded:
//// 
app.get('page/site/*', function(req, res, next) {

    getClientModels(req.aRAD.listJavascripts)

    next();
});








//// 
//// Scan any sub interfaces to gather their routes
////


var siteInterfaces = {};

//var pathInterfaces = './modules';
//var pathInterfaces = '../modules/site/modules';
var pathInterfaces = __dirname + '/interfaces';

fs.readdir(pathInterfaces, function (err, files) {

    if (err) { console.log(err)};

    for(var fi in files) {
        
        var interfacePath = pathInterfaces + '/'+files[fi]+'/node_'+files[fi]+'.js';
        console.log('interfaces/'+files[fi]);
        
        if (path.existsSync(interfacePath)) {
        
            console.log('   ['+interfacePath+']');
            
            // ok, requires are based from the current directory:
            
            siteInterfaces[files[fi]] = require('./interfaces/'+files[fi]+'/node_'+files[fi]+'.js'); // require(interfacePath);
        }
        
    }
    
    
});



//// The Model objects 
var siteModels = {};
getClientModels = function(list) {

    console.log('... pulling Client Models...');

}
