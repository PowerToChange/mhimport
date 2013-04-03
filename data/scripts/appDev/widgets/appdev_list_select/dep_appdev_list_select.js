

//// AppDev List Select
////
//// This is the dependency information for the appdev_list_select widget.
//// Our serverside node scripts will load this to know what other 
//// resources are required to use this widget.

//// Any Interface/container using this widget will report these resources
//// on the loading of the page.


// paths here should be from the 'data' directory. (appDevRoot/data/)
// our default dir is '/siteRoot/data/theme/default/'
exports.listCSS = [ '/theme/default/css/appdev.css' ];


// paths here should be from the RootDir/data/scripts
exports.listJS = [ 'appDev/widgets/appdev_list_select/appdev_list_select.js' ];

exports.listLabels = [ '/site/widget/appdev_list_select' ];