# Pub/Sub
Meteor.autosubscribe ->
    Meteor.subscribe 'userData'
    # Meteor.subscribe 'allUserData'
		Meteor.subscribe 'events'

showLoading = (flag) ->
	Session.set('_loading', flag)

showMessage = (type, message) ->
	Session.set('_flashMessage', [type, message])

setPage = (page) ->
	Session.set('_activePage', page)	

showDialog = (name) ->
	Session.set('_currentDialog', name)

Meteor.startup ->
	setPage('eventList')
	showDialog(null)

Meteor.autorun = ->
	showLoading(true)

Template.main.yieldPage = ->
	activePage = Session.get('_activePage')
	Template[activePage]() if activePage of Template

# _Header
Template._header.events {
	'click .nav a': (e) ->
		showDialog(null)
		$target = $(e.target)
		
		page = $target.data('page')

		return unless page

		$target.closest('li').addClass('active')
			.siblings().removeClass('active')

		setPage(page) 

	'click .nav a#nav-invite': (e) ->
		showDialog('invite')
}

Template._header.showLoading = ->
	Session.get('_loading')

# Home
Template.home.rendered = ->
	unless Meteor.userId()
		showLoading(false)

# _Dialogs
Template._dialogs.canShowDialog = (name) ->
	Session.get('_currentDialog') == name

Template._dialogs_invite.rendered = ->
	$(this.find('#dialog-invite')).modal
		backdrop: 'static',
		keyboard: true,
		show: true

Template._dialogs_invite.events {
	'show #dialog-invite': ->
		console.log('shown')

	'click #btn-close': ->
		showDialog(null)
}