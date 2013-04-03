/**
 *  Setup the Interface List Widget
 */

steal('//appDev/widgets/appdev_list_searchable_new/appdev_list_searchable_new.js').then(function() {

    // Keep all variables and functions inside an encapsulated scope
    (function() {
    
    
        //// Setup Widget:
        AppdevListSearchableNew.extend('InterfaceListWidget', {
    
            
            init: function (el, data) {
                
                this._super(el, data);
                this.module = null;
            },
            onSelection:function(item) {
                item.module = this.module;
                AD.Comm.Notification.publish('apprad.interface.selected', item);
                AD.Comm.Notification.publish('apprad.panel.show', {name:'interface'});
            },
            'apprad.module.selected subscribe': function(message, data) {
                // data should be { name:'[moduleName]' }
                this.module = data.name;
                this.findAll({module: data.name});
            }
            
        });
        
    }) ();

});
