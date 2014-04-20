$(window).load ->

		delay 500, ->
			$(".logo-wrapper").addClass "show"



delay = (ms, func) -> setTimeout func, ms