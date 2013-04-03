/*
 * @class appdev_menu_ipod
 * @parent widgets
 * 
 * ##ipod menu
 * 
 * A widget to create an ipod like menu system
 *
 */

// this widget depends on fg.menu.js to be loaded.  So do that
// here:
steal('//appDev/widgets/appdev_menu_ipod/fg.menu.js').then(function( $ ) {




    $.Controller.extend("AppdevMenuIpod", 
        {
            // This object will transform the data in a menu 
            
            
            
            init: function (el, options) {
            
                
                // this widget needs to get it's data from:
                    // 1) a passed in DataStore
                    // 2) a passed in contentDiv attrib
                    // 3) an embedded href="#divID"
                    
            
                // option.updateMenuWithSelectedOption:T/F : [F]
                
                // 
            
            
                this.onChange = options.onChange || null;
                
                
                var $el = $(el);
                
                options = options || {};
                
                this.$displayValue = $el;
                
                this.prevValue = this.$displayValue.text();
                
                // 
                var me = this;
                options.onClick = function( e, menuItem) {
                    me.clickedMenu(menuItem, e);
                }
                

                
                
                // use the embedded href for this el to determine the 
                // contents of our menu:
                var hrefValue = $el.attr('href');
                
                
                var menuContent = $(hrefValue).html();
                // call the menu() plugin on our element
                $el.menu({ 
                    content: menuContent, // grab content from this page
                    showSpeed: 400,
                    onChosen: function (item) {
                    
                        me.clickedMenu(item);
                    }
                });
                
                //ui-widget ui-widget-content ui-corner-all
                
                // find 
            }, 
            
            
            
            //-----------------------------------------------
            clickedMenu: function ( item ) {
                // process the click event on each of the 
                // labels we are active on.
            
                var $item = $(item);
                var newLabel = $item.text();
                this.element.text(newLabel);
                
                
                var value = newLabel;
                            
                if (this.prevValue != value) {
                
                    // spark an onChange event
                    if (this.onChange != null) {
                    
                        this.onChange( $item );
                    }
                    this.prevValue = value;
                }
                
            },
            
            
            
            //-----------------------------------------------
            destroy: function (topic, data) {
                // cleanly remove our changes to the DOM
            

                // be sure to call this!
                this._super();
                
            }
        });
    
    
});
//// TODO:  Change Filename to appdev_menu_ipod.js
////        develop dependency system to dynamically load .js and .css
////        
