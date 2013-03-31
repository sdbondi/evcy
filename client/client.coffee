# Pub/Sub
Meteor.subscribe('events')

showLoading = (flag) ->
	Session.set('loading', flag)

setPage = (page) ->
	Session.set('activePage', page)	

Meteor.startup ->
	setPage('eventList')

Meteor.autorun = ->
	showLoading(true)

Template.main.yieldPage = ->
	activePage = Session.get('activePage')
	Template[activePage]() if activePage of Template

# _Header
Template._header.events {
	'click .nav a': (e) ->
		$target = $(e.target)

		$target.closest('li').addClass('active')
			.siblings().removeClass('active')

		setPage($target.data('page'))
}

Template._header.showLoading = ->
	Session.get('loading')

# Home
Template.home.rendered = ->
	unless Meteor.userId()
		showLoading(false)

# Profile
Template.profile.userData = ->	
	Meteor.user().profile

Template.profile.events {
	'click #btn-save': (e, template) ->	
		e.preventDefault()	
		data = $(template.find('form')).serializeArray()
		obj = {}
		[obj[o.name] = o.value for o in data]
		Meteor.users.update(Meteor.userId(), $set: obj)	

	'click #btn-cancel': ->
		setPage('eventList')
}

# EventList
Template.eventList.rendered = ->
	showLoading(false)

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