$(document).ready ->

	$('[data-behaviour~=datepicker]').datepicker
		format: 'dd-mm-yyyy'
		startDate: '+0d'

	$('[data-behaviour~=timepicker]').timepicker();

	$('#meetings').on 'click touchstart', '.meeting', ->
		url = $(this).attr 'data-link'
		$.ajax
			url: url
			success: (data)->
				$('#details').html data

	# Add selected class to the first meeting which is loaded at first.
	$('#meetings .meeting').first().addClass 'selected'

	return