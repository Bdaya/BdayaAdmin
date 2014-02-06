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

	$(".meeting").click ->
		$(".split-side").css "margin": "0px"
		$(this).addClass("selected").siblings(".selected").removeClass("selected")

	$(".split-side .back").click ->
		$(".split-side").css "margin-right": "-100%"

	return