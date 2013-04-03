////
//// Settings
////
//// This model is the interface to the site_settings table.


(function () {
	  var onServer = false;
	  if (typeof exports !== 'undefined') {
	      // exports are defined on the server side node modules
	      onServer = true;
	  } 
	  
	  var attr = {
	      // Client Definitions
          _adModule:'site',
          _adModel:'Settings',
          id:'settings_id',
          labelKey:'settings_label',
          _isMultilingual:false 
      }
      
      if (onServer) {
          // Server Definitions
          attr['__serverModel'] = {
              type:'single',  // 'single' | 'multilingual'
              dbTable:'site_settings',
              model: {
		          settings_id:"int(11) unsigned",
		          settings_key:"text",
		          settings_value:"text",

              },
              primaryKey:'settings_id'
          }
      }
	  
	  
	  AD.Model.extend("site.Settings",
	  attr,
	  {
		  // define instance methods here.
	  });

	  if (onServer) {
		  module.exports = AD.Model.List["site.Settings"];
	  }

})()