$(document).ready ->
	# Add selected class to the first task which is loaded at first.
	$('#tasks .task').first().addClass 'selected'

	# Load the details of a meeting.
	$('#tasks').on 'click touchstart', '.task', ->
		url = $(this).attr 'data-link'
		$.ajax
			url: url
			success: (data)->
				$('#details').html data
				#Load userSearch plugin *****FIX THIS******
				$('form').find('.user-search').userSearch()

	# Select the clicked meeting.
	$('#tasks').on 'click touchstart', '.task', ->
		$(".split-side").css "margin": "0px"
		$('#tasks').find('.task.selected').removeClass 'selected'
		$(this).addClass("selected")




	return