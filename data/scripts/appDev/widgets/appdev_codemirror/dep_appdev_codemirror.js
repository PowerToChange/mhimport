

//// AppDev List Searchable
////
//// This is the dependency information for the appdev_codemirror widget.
//// Our serverside node scripts will load this to know what other 
//// resources are required to use this widget.

//// Any Interface/container using this widget will report these resources
//// on the loading of the page.


// paths here should be from the 'Theme Root' directory.
// our default dir is '/siteRoot/data/theme/default/'
exports.listCSS = [ '/theme/default/css/appdev.css',
                    '/scripts/CodeMirror/lib/codemirror.css'];


// paths here should be from the RootDir/data/scripts
exports.listJS = [ 'appDev/widgets/appdev_codemirror/appdev_codemirror.js',
                   'CodeMirror/lib/codemirror.js'];

exports.listLabels = [ '/site/widget/appdev_codemirror' ];