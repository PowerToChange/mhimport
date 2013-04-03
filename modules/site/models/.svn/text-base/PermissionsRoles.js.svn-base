////
//// Viewer
////
//// This model is the interface to the site_perm_roles table.
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
          _adModel:'PermissionsRoles',
          id:'role_id',
          labelKey:'role_label',
          _isMultilingual:false 
      }
      
      if (onServer) {
          // Server Definitions
          attr['__serverModel'] = {
              type:'single',  // 'single' | 'multilingual'
              dbTable:'site_perm_roles',
              model: {
		          role_id:"int(11) unsigned",
		          role_label:"text"

              },
              filters: {
                  viewer_guid: {
                      tableName: "site_perm_viewer_roles",
                      foreignKey: "role_id"
                  }
              },
              primaryKey:'role_id'
          }
      }
	  
	  
	  AD.Model.extend("site.PermissionsRoles",
	  attr,
	  {
		  // define instance methods here.
	  });

	  if (onServer) {
		  module.exports = AD.Model.List["site.PermissionsRoles"];
	  }

})()