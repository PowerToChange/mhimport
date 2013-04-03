/**
 *  Setup the Model Work Area Panel
 */



// Keep all variables and functions inside an encapsulated scope
steal('//modules/appRAD/interfaces/portal/scripts/WorkAreaPanel.js').then(function() {

	// Keep all variables and functions inside an encapsulated scope
	(function() {
	
	
	    //// Setup Panel:
		WorkAreaPanel.extend('ModelWorkAreaPanel', {
	
	        
	        init: function (el, data) {
	            
	        	this._super(el, data);
	        	
	            this._name='model';
	                            
	        },
	    });
	    
	}) ();

});