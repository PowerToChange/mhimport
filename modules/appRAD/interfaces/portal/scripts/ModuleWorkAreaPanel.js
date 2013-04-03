/**
 *  Setup the Module Work Area Panel
 */

steal('//modules/appRAD/interfaces/portal/scripts/WorkAreaPanel.js').then(function() {

	// Keep all variables and functions inside an encapsulated scope
	(function() {
	
	
	    //// Setup Panel:
		WorkAreaPanel.extend('ModuleWorkAreaPanel', {
	
	        
	        init: function (el, data) {
	            
	        	this._super(el, data);
	        	
	            this._name='module';
	                            
	        }
		});
	    
	}) ();

});