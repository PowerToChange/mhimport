////
//// PermissionsTasks
////
//// This model is the interface to the site_perm_tasks_data table.


(function () {
	  var onServer = false;
	  if (typeof exports !== 'undefined') {
	      // exports are defined on the server side node modules
	      onServer = true;
	  } 
	  
	  var attr = {
	      // Client Definitions
          _adModule:'site',
          _adModel:'PermissionsTasks',
          id:'task_id',
          labelKey:'task_label',
          _isMultilingual:true
      }
      
      if (onServer) {
          // Server Definitions
          attr['__serverModel'] = {
              type:'multilingual',  // 'single' | 'multilingual'
              tables:{
                  data:'site_perm_tasks_data',
                  trans:'site_perm_tasks_trans'
              },
              fields: {
                  data: {
  		              task_id:"int(11)",
		              task_key:"varchar(25)",

                  },
                  trans: {
  		              trans_id:"int(11)",
		              task_id:"int(11)",
		              language_code:"varchar(25)",
		              task_label:"text",

                  
                  }
              },
              filters: {
                  role_id: {
                      tableName: "site_perm_role_tasks",
                      foreignKey: "task_id"
                  },
                  viewer_guid: {
                      tableName: "site_perm_viewer_roles",
                      foreignKey: "role_id"
                  }
              },
              primaryKey:'task_id',
              multilingualFields: ['task_label']
          };
      }
	  
	  
	  AD.Model.extend("site.PermissionsTasks",
	  attr,
	  {
		  // define instance methods here.
	  });

	  if (onServer) {
		  module.exports = AD.Model.List["site.PermissionsTasks"];
	  }

})()