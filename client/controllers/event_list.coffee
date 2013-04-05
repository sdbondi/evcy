# EventList
Template.eventList.eventItems = ->
	Events.find({})

Template.eventList.hasEvents = ->
	Template.eventList.eventItems().count() > 0

Template.eventList.events {
	'click #btn-add-event': ->
		setPage('addEvent')
}

# Add event
Template.addEvent.events {
	'click .close-page, click #btn-cancel': ->
		setPage('eventList')
}