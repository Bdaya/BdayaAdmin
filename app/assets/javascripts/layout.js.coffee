$(document).ready ->

	$('#leftbar-button').click ->
		$("#content").removeClass('show-rightbar')
		$("#rightbar").removeClass('show')
		$("#leftbar").addClass('show')
		$("#content").toggleClass('show-leftbar')

	$('#rightbar-button').click ->
		$("#content").removeClass('show-leftbar')
		$("#leftbar").removeClass('show')
		$("#rightbar").addClass('show')
		$("#content").toggleClass('show-rightbar')

	$(".split-side .back").click ->
		$(".split-side").css "margin-right": "-100%"

	return