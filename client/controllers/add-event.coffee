Template.addEvent.events {
	'click .cancel': (e) ->
		e.preventDefault()
		setPage('eventList')

	'submit #form-add-event': (e) ->
		e.preventDefault()
		# ....
}