Template.addEvent.avatarSrc = (eventId) ->
	if event = Session.get('current_event')
		event.avatar
	else if src = Session.get('_add_event_current_avatar')
		src
	else
		false

Template.addEvent.events {
	'click .cancel': (e) ->
		e.preventDefault()
		setPage('eventList')

	'submit #form-add-event': (e) ->
		e.preventDefault()
		# ....
}