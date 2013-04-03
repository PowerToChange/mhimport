/**
 *  Setup the Code Mirror Widget
 */

steal('//appDev/widgets/appdev_codemirror/appdev_codemirror.js').then(function() {

    // Keep all variables and functions inside an encapsulated scope
    (function() {
    
    
        //// Setup Widget:
        AppdevCodemirror.extend('ControllerEditorWidget', {
    
            
            init: function (el, data) {
                data.readUrl = '/appRAD/interface/controllers/read';
                data.writeUrl = '/appRAD/interface/controllers/write';
                this._super(el, data);
            },
            // Automatically save any changes when the context changes
            switchContext: function() {
                if (this.isModified()) {
                    this.saveCode();
                }
            },
            'apprad.interface.controller.selected subscribe': function(message, data) {
                this.switchContext();
                this.selectFile(data);
                this.element.show();
            },
            'apprad.interface.view.selected subscribe': function(message, data) {
                this.switchContext();
                this.element.hide();
            },
            'apprad.interface.selected subscribe': function(message, data) {
                this.switchContext();
                this.element.hide();
            },
        });
        
    }) ();

});
