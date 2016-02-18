// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//validador jquery
$('#new_user').validate({
  rules: {
    'user[password]': {
      required: true,
      maxlength: 100
    },
    'user[email]': {
      required: true, 
      email: true, 
      maxlength: 150
    }
  },
  messages: {
    'user[password]': {
        required: "Required Field",
        maxlength: "Name too big, max size 100"
    },
    'user[email]': {
        required: "Required Field",
        email: "Invalid email",
        maxlength: "Email too big, max size 150"
    }
  }
});