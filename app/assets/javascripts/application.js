// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap
//= require ckeditor/init

$(function(){
    $(".datepicker").datepicker({
        format: 'yyyy-mm-dd'
    });

    // To instantiate multiple CKEditors on the party records page
    $('textarea.editor').each(function() {
        CKEDITOR.replace($(this).attr('id'));
    });

    function clearCollectionFields()
    {
        $("#input_collection_license").val('');
        $("#input_collection_access_rights").val('');
        $("#input_collection_location").val('');
        $("#input_collection_website_name").val('');
        $("#input_collection_url").val('');
    }

    function onLoad()
    {
        val = $(".collection_type:checked").val();
        if (val == 'Local')
        {
            $("#collection_form").hide();
        }
        else if (val == 'Remote')
        {
            $("#collection_form").show();
        }
        else //on new
        {
            $("#collection_form").hide();
        }
    }onLoad();


    $(".collection_type").change(function(){
        val = $(".collection_type:checked").val();
        if (val == 'Local')
        {
            $("#collection_form").hide();
        }
        else if (val == 'Remote')
        {
            $("#collection_form").show();
        }
    });
});

