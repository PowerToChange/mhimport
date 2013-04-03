/**
 *  The setup routines for the Site Login Interface/Page.
 *
 *  This is where we setup all the on screen widget functionality for the
 *  operation of the page.
 */


(function() {


    ////[appRad] --  initialize your page functionality here
    var siteLoginSetup = function (topic, data) {


        //// setup language picker widget
        $('#langList').appdev_menu_ipod({
    //            contentDiv:'#langListContents',
            minWidth:200,
            onChange:function(element) {
                
                var langData = { lang_code: element.attr('code') };
                
                OpenAjax.hub.publish("site.multilingual.lang.set", langData);
            }
        });
        
        
        // install our translation swticher
        // Note: controller defined in: xlation_list.js  
        $('#xlationList').xlation_list();


        // setup our login form
        // Note: controller defined in: login_form.js
        var form = $('#loginForm');
        $('#loginForm').login_form();
        
        
        // note: since anyone can publish a key, we want to prevent 
        // running this a second time:
        OpenAjax.hub.unsubscribe(subscriptionID);
    }

    var subscriptionID = OpenAjax.hub.subscribe('ad.site.login.setup',siteLoginSetup);


    $(document).ready(function () {


    }); // end ready()

}) ();