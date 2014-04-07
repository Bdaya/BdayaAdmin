# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	# Add selected class to the first task which is loaded at first.
	$('#feedbacks .feedback').first().addClass 'selected'

	# Load the details of a meeting.
	$('#feedbacks').on 'click touchstart', '.feedback', ->
		url = $(this).attr 'data-link'
		$.ajax
			url: url
			success: (data)->
				$('#details').html data
				#Load userSearch plugin *****FIX THIS******
				# $('form').find('.user-search').userSearch()

	# Select the clicked meeting.
	$('#feedbacks').on 'click touchstart', '.feedback', ->
		# $(".split-side").css "margin": "0px"
		$('#feedbacks').find('.feedback.selected').removeClass 'selected'
		$(this).addClass("selected")




	return