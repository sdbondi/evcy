# Pub/Sub
Meteor.autosubscribe ->
		Meteor.subscribe 'userData'
		Meteor.subscribe 'allUserData'
		Meteor.subscribe 'events'

showLoading = (flag) ->
	Session.set('_loading', flag)

showAlert = (type, message) ->
	flash = Session.get('_flashAlerts')
	id = flash.length + 1
	flash.push({id: id, type: type, message: message})
	Session.set('_flashAlerts', flash)

	setTimeout(->
		Session.set('_flashAlerts', _.reject(flash, (alert) -> alert.id == id))
	, 5000)

setPage = (page) ->
	Session.set('_activePage', page)	

showDialog = (name) ->
	Session.set('_currentDialog', name)
	if name then $('.modal').show() else $('.modal').hide()

clearAlerts = ->
	Session.set('_flashAlerts', [])

Meteor.startup ->
	Helpers.addScript '//api.filepicker.io/v1/filepicker.js', ->
		filepicker.setKey('AReFnWtjMQ2ePGk0rVzd1z')

	Helpers.addCss '/css/datepicker.css'
	Helpers.addScript '/js/bootstrap-datepicker.js', ->

	setPage('eventList')
	showDialog(null)
	clearAlerts()

Meteor.autorun = ->
	showLoading(true)
	clearAlerts()

Template.main.yieldPage = ->
	activePage = Session.get('_activePage')
	Template[activePage]() if activePage of Template

# Home
Template.home.rendered = ->
	unless Meteor.userId()
		showLoading(false)
