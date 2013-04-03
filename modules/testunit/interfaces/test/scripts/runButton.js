/**
 *  This Controller sets up the operation of the "Apply" button.
 */

$.Controller('RunButton', 
{

},
{
    init: function(el, options) {
        // apply jQuery UI styling
        el.button();
    },

    "click": function(el, event) {
        var rowsState = ComponentRow.getAllRows();
        $.ajax({
            type: 'GET',
            dataType: ($.browser.msie) ? "text" : "xml",
            data: "filename=" + rowsState["Available Tests"].join(','),
            cache: false,
            url: '/testunit/test/run',
            success: function(data) {
            	console.log("Tests complete.");
                //var url = ''+window.location.href.replace(/\?.*/, '');
                //window.location.assign(url);
                
            },
            error: function(error) {
                console.log(error);
                //window.location.reload();
            }
        
        });
        $.ajax({
            type: 'GET',
            dataType: ($.browser.msie) ? "text" : "xml",
            data: "filename=" + rowsState["Create Tests"].join(','),
            cache: false,
            url: '/testunit/test/create',
            success: function(data) {
            	console.log("Tests created.");
                //var url = ''+window.location.href.replace(/\?.*/, '');
                //window.location.assign(url);
                
            },
            error: function(error) {
                console.log(error);
                //window.location.reload();
            }
        
        });
        
    }

});

