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

	return