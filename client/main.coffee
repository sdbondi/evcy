# Pub/Sub
Meteor.autosubscribe ->
	Meteor.subscribe 'userData'
	Meteor.subscribe 'allUserData'
	Meteor.subscribe 'events'

Meteor.startup ->
	Helpers.addScript '//api.filepicker.io/v1/filepicker.js', ->
		filepicker.setKey('AReFnWtjMQ2ePGk0rVzd1z')

	Helpers.addCss '/css/datepicker.css'
	Helpers.addScript '/js/bootstrap-datepicker.js'

	setPage('eventList')
	showDialog(null)
	clearAlerts()

Meteor.autorun = ->
	clearAlerts()

Template.main.yieldPage = ->
	activePage = Session.get('_activePage')
	Template[activePage]() if activePage of Template
