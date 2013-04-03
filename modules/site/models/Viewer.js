////
//// Viewer
////
//// This model is the interface to the site_viewer table.


(function () {
	  var onServer = false;
	  if (typeof exports !== 'undefined') {
	      // exports are defined on the server side node modules
	      onServer = true;
	  } 
	  
	  var attr = {
	      // Client Definitions
          _adModule:'site',
          _adModel:'Viewer',
          id:'viewer_id',
          labelKey:'viewer_userID',
          _isMultilingual:false 
      }
      
      if (onServer) {
          // Server Definitions
          attr['__serverModel'] = {
              type:'single',  // 'single' | 'multilingual'
              dbTable:'site_viewer',
              model: {
		          viewer_id:"int(11) unsigned",
		          language_key:"varchar(12)",
		          viewer_userID:"text",
		          viewer_passWord:"text",
		          viewer_isActive:"int(1)",
		          viewer_lastLogin:"datetime",
		          viewer_globalUserID:"text",

              },
              primaryKey:'viewer_id'
          }
      }
	  
	  
	  AD.Model.extend("site.Viewer",
	  attr,
	  {
		  // define instance methods here.
	  });

	  if (onServer) {
		  module.exports = AD.Model.List["site.Viewer"];
	  }

})()