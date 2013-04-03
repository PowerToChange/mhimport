////
//// Viewer
////
//// This model is the interface to the site_perm_role_tasks table.
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
          _adModel:'PermissionsRoleTasks',
          id:'roletask_id',
          labelKey:'',
          _isMultilingual:false 
      }
      
      if (onServer) {
          // Server Definitions
          attr['__serverModel'] = {
              type:'single',  // 'single' | 'multilingual'
              dbTable:'site_perm_role_tasks',
              model: {
		          roletask_id:"int(11) unsigned",
		          role_id:"int(11)",
		          task_id:"int(11)"

              },
              lookupLabels: {
                  task_id: {
                      tableName: "site_perm_tasks_trans",
                      foreignKey: "task_id",
                      label: "task_label"
                  }
              },
              primaryKey:'roletask_id'
          }
      }
	  
	  
	  AD.Model.extend("site.PermissionsRoleTasks",
	  attr,
	  {
		  // define instance methods here.
	  });

	  if (onServer) {
		  module.exports = AD.Model.List["site.PermissionsRoleTasks"];
	  }

})()