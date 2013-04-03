/**
 *  This is a generic RAD Tool Work Area Panel
 */



// Keep all variables and functions inside an encapsulated scope
(function() {

    //// Setup Panel:
    $.Controller('WorkAreaPanel', {
        
        init: function (el, data) {
            
            this.element.hide();
            this._name = '';
                            
        }, 
        
        "apprad.panel.show subscribe":function(message, data){
        	
        	// data.name
        	if (data.name == this._name){
        		this.element.show();
        	} else {
        		this.element.hide();
        	}
        }


    });
    
}) ();