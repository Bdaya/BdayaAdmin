$(document).ready ->
	$('[data-behaviour~=datepicker]').datepicker
		format: 'dd-mm-yyyy'
		startDate: '+0d'

	$('[data-behaviour~=timepicker]').timepicker();

	# Add selected class to the first meeting which is loaded at first.
	$('#meetings .meeting').first().addClass 'selected'

	# Load the details of a meeting.
	$('#meetings').on 'click touchstart', '.meeting', ->
		url = $(this).attr 'data-link'
		$.ajax
			url: url
			success: (data)->
				$('#details').html data
				#Load userSearch plugin *****FIX THIS******
				$('form').find('.user-search').userSearch()

	# Select the clicked meeting.
	$('#meetings').on 'click touchstart', '.meeting', ->
		$(".split-side").css "margin": "0px"
		$('#meetings').find('.meeting.selected').removeClass 'selected'
		$(this).addClass("selected")


	#$('.pp').popover('toggle')

	return