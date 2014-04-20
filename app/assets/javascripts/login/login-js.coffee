$(window).load ->

		delay 1000, ->
			$(".logo-wrapper").addClass "show"



delay = (ms, func) -> setTimeout func, ms