# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#content').on 'click touchstart', '.show-side', ->
	# $(".split-side").css "margin": "0px"
	$('#content').find('.show-side.selected').removeClass 'selected'
	$(this).addClass("selected")

$('#content').on 'click touchstart', '.show-side', ->
	url = $(this).attr 'data-link'
	$.ajax
		url: url
		success: (data)->
			$('#details').html data
			fixArabic()
			#Load userSearch plugin *****FIX THIS******
			# $('form').find('.user-search').userSearch()