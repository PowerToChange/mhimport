/**
 *  Setup the Model List Widget
 */

steal('//appDev/widgets/appdev_list_searchable_new/appdev_list_searchable_new.js').then(function() {

    // Keep all variables and functions inside an encapsulated scope
    (function() {
    
    
        //// Setup Widget:
        AppdevListSearchableNew.extend('ModelListWidget', {
    
            
            init: function (el, data) {
                
                this._super(el, data);
            },
            onSelection:function(item) {
                
                AD.Comm.Notification.publish('apprad.model.selected', item);
                AD.Comm.Notification.publish('apprad.panel.show', {name:'model'});
            },
            'apprad.module.selected subscribe': function(message, data) {
                    // data should be { name:'[moduleName]' }
                    this.findAll({module: data.name});
            }
        });
        
    }) ();

});
