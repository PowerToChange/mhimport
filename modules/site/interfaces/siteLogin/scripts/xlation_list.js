/**
 *  This Controller setups the operation of our translation switcher.
 */



// Keep all variables and functions inside an encapsulated scope
(function() {

    //// Setup Translation Switching Widget:
    $.Controller('XlationList', {

        "change" : function(el, ev) {
            // everytime a new language is selected, make sure to 
            // publish a new 'site.multilingual.lang.set' event
            // with the desired lang_code

            var selected = this.element.find('option:selected');
            
            var xlationData = { mode: selected.val() };
            
            OpenAjax.hub.publish("site.multilingual.xlation.set", xlationData);

        }

    });
    
}) ();