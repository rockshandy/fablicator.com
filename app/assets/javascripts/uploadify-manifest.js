//= require jquery.uploadify.v2.1.4.min
//= require swfobject
$(document).ready(function() {
	var things = $('#ignore').data();
	$('#upload_image').click(function(event) {
		event.preventDefault();
	});
	var sd = {
		'_http_accept' : 'application/javascript',
		'format' : 'json',
		'_method' : 'post',
		'authenticity_token' : encodeURIComponent(things.auth_token)
	}

	sd[things.session_key] = encodeURIComponent(things.cookie_key)

	$('#upload_image').uploadify({
		uploader : '/uploadify/uploadify.swf',
		cancelImg : '/uploadify/cancel.png',
		multi : true,
		auto : true,
		script : '/uploads',
		onComplete : function(event, queueID, fileObj, response, data) {
			resp = $.parseJSON(response);
			$('#uploaded').append('<img src="' + resp.upload.replace(/\?\d+$/, '') + '">')
		},
		scriptData : sd
	});
});
