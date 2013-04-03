////
//// Viewer
////
//// This model is the interface to the site_perm_viewer_roles table.
////


(function () {
	  var onServer = false;
	  if (typeof exports !== 'undefined') {
	      // exports are defined on the server side node modules
	      onServer = true;
	  } 
	  
	  var attr = {
	      // Client Definitions
          _adModule:'site',
          _adModel:'PermissionsViewerRoles',
          id:'viewerroles_id',
          labelKey:'',
          _isMultilingual:false 
      }
      
      if (onServer) {
          // Server Definitions
          attr['__serverModel'] = {
              type:'single',  // 'single' | 'multilingual'
              dbTable:'site_perm_viewer_roles',
              model: {
		          viewerroles_id:"int(11) unsigned",
		          viewer_globalUserID:"text",
		          role_id:"int(11)"

              },
              primaryKey:'viewerroles_id'
          }
      }
	  
	  
	  AD.Model.extend("site.PermissionsViewerRoles",
	  attr,
	  {
		  // define instance methods here.
	  });

	  if (onServer) {
		  module.exports = AD.Model.List["site.PermissionsViewerRoles"];
	  }

})()