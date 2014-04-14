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
		$(".split-side").removeClass('show')
	$("#content").on "click touchstart", ".show-side", ->
		$(".split-side").addClass('show')

	$('#change-pp-form input[type=file]').change ->
		$('#change-pp-form').submit()

	$('#change-pp').on 'click', ->
		$('#change-pp-form input[type=file]').click()

	return