//// Template Replace:
//   testunit     : the name of this interface's module: (lowercase)
//   test  : the name of this interface :  (lowercase)
//   Test  : the name of this interface :  (Uppercase)
/**
 *  The setup script for the test Interface container. 
 *
 *  The job of this code is to perform all the setup steps on the existing
 *  HTML DOM items now.  Add Events, actions, etc... 
 *
 *  This file will be generated 1x by the RAD tool and then left alone.
 *  It is safe to put all your custom code here.
 */


(function() {


////[appRad] --  setup object definitions here:
var testunitTestSetup = function (topic, data) {


    //// Setup Your Page Data/ Operation Here

/*
          // UI effects
      $('button.submit').mouseenter(function() {
        $(this).addClass('ui-state-hover');
      });
      $('button.submit').mouseleave(function() {
        $(this).removeClass('ui-state-hover');
      });

      // Set focus to the userID field when page first loads
      $("input[name='userID']").focus();
      
      // Pressing "Enter" from the password field should submit the form
      $("input[name='pWord']").keypress(function(event) {
        if (event.keyCode == 13 || event.keyCode == 10 || event.keyCode == 3) {
          $('button.submit').click();
        }
        return true;
      });
    
      // Handle form submission
      $('button.submit').click(function() {
        
        // Show busy animation
        $('.busy').show();
        // Hide any previous messages
        $('#error-message').empty().hide();
        // Gather form data
        var formData = {};
        $('form input').each(function() {
          var key = this.name;
          if (key == 'pWord') {
              var value = MD5(this.value);  // encrypt the pword before sending.
          } else {
              var value = this.value;
          }
          formData[key] = value;
        });
        // Submit data
        $.ajax({
          type: 'POST',
          dataType: 'json',
          data: formData,
          url: '/service/site/login/authenticate',
          success: function (data) {
            // Hide busy animation
            $('.busy').hide();
            // Handle response
            if (data.success) {
              // Success! Redirect to new page.
//              alert('success!!');
              window.location = '/page/test/viewer';
            } else {
              // Error! Display message.
              var message;
              message = data.errorMSG;
              $('#error-message')
                .text(message)
                .fadeIn();
            }
          },
          cache: false,
          error: function() {
            // Hide busy animation
            $('.busy').hide();
            // Unexpected error
            $('#error-message')
              .text('Sorry, there was a technical problem. Please try again.')
              .fadeIn();
          }
        });
      });
*/
	
	$('.component-manager button.submit').run_button();
    $('.component-manager tr.component-row').component_row();
    
} // end testunitTestSetup()
OpenAjax.hub.subscribe('ad.testunit.test.setup',testunitTestSetup);




$(document).ready(function () {

    //// Do you need to do something on document.ready() before the above
    //// testunitTestSetup() script is called?


}); // end ready()

}) ();