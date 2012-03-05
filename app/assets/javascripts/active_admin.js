//= require active_admin/base
//= require jquery
//= require tinymce-jquery
//= require jquery.uploadify.v2.1.4.min
//= require swfobject

$(function(){
	$('#post_content').tinymce({
        // General options
        theme : "advanced",
        plugins : "pagebreak,style,layer,table,save,advhr,advimage,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

        // Theme options
        theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
        theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,myImage,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
        theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
        theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
        theme_advanced_toolbar_location : "top",
        theme_advanced_toolbar_align : "left",
        theme_advanced_statusbar_location : "bottom",
        theme_advanced_resizing : true,
	    convert_urls : false,

        // Example content CSS (should be your site CSS)
        //content_css : "css/example.css",

        // Drop lists for link/image/media/template dialogs
        template_external_list_url : "js/template_list.js",
        //external_image_list_url : "js/image_list.js",
        media_external_list_url : "js/media_list.js",

        // Replace values for the template plugin
        template_replace_values : {
                username : "Some User",
                staffid : "991234"
        },
        
        setup: function(ed){
        	// image button
        	ed.addButton('myImage', {
	            title : 'Image Upload',
	            image : '/assets/img_upload.gif',
	            onclick : function() {
	                // display image upload form
	                $("#dialog-form").data('ed',ed)
	                $("#dialog-form").dialog("open");
	            }
        	});
        }
	});
	
  	$( "#dialog-form" ).dialog({
    	autoOpen: false,
	    height: 300,
	    width: 350,
	    modal: true,
	    buttons: {
	    	"Add image": function() {
	    		var ed = $(this).data('ed')
	    		var img = $('#uploaded img',this).attr('src')
                ed.focus();
                ed.selection.setContent('<img src="' + img + '">');
	    		$( this ).dialog( "close" );
	    	},
	      	Cancel: function() {
	      		$( this ).dialog( "close" );
	      	}
	    },
	    open: function() {
	    	$('#uploaded img').remove();
	    },
	    close: function() {
	    	//allFields.val( "" ).removeClass( "ui-state-error" );
	    }
  	});
});
