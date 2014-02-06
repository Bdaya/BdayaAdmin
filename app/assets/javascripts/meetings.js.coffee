$(document).ready ->

	$('[data-behaviour~=datepicker]').datepicker
		format: 'dd-mm-yyyy'
		startDate: '+0d'

	$('[data-behaviour~=timepicker]').timepicker();

	return