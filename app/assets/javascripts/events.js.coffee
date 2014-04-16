$(document).ready ->

	$('#designs-list').masonry
		columnWidth: 100
		itemSelector: '.item'

	# Hack to order designs.
	$('.event .nav li').click ->
		$(window).resize()


	$('#add-design-form input[type=file]').change ->
		$('#add-design-form').submit()

	$('#add-design').click ->
		$('#add-design-form input[type=file]').click()

	img = $(".event .background").attr('data-image')
	$(".event .background").css "background-image", 'url('+img+')'


	return