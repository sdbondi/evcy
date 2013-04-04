Template._dialogs.yield_dialogs = ->
	dialog = Session.get('_currentDialog')
	Template["_dialogs_#{dialog}"]() if dialog && "_dialogs_#{dialog}" of Template	

Template._dialogs_deleteAccountConfirm.rendered = ->
	$(this.find('.modal')).modal
		backdrop: 'static',
		keyboard: true,
		show: true
	.on('hidden', -> showDialog(null))

	$(this.find('#btn-confirm-delete')).prop('disabled', true)

Template._dialogs_deleteAccountConfirm.events {
	'keyup #text-confirm-delete': (e, template) ->		
		$(template.find('#btn-confirm-delete')).prop('disabled', e.target.value != 'delete')

	'click #btn-confirm-delete': (e, template) ->
		Meteor.call('deleteUser', userId: Meteor.userId(), (error) ->
			if error?
				showAlert 'error', error.reason
			else
				showAlert 'info', 'You account has been successfully removed!'
			window.location = '/'
		)
}

Template._dialogs_invite.mustHide = ->
	if Session.get('dialog.invite.mustHide') then 'hide fade'

Template._dialogs_invite.rendered = ->
	$(this.find('.modal')).modal
		backdrop: 'static',
		keyboard: true,
		show: true
	.on('hidden', -> showDialog(null))
	Session.set('dialog.invite.mustHide', false)

Template._dialogs_invite.error = ->
	Session.get('dialog.invite.error')

Template._dialogs_invite.events {
	'click #btn-close': (e, template) ->
		Session.set('dialog.invite.mustHide', true)
		Session.set('dialog.invite.error', '')

	'click #btn-invite': (e, template) ->
		e.preventDefault()
		Session.set('dialog.invite.error', '')
		Meteor.call 'sendInvitation', 
			{ email: template.find('#field-email').value },
			(err) ->
				Session.set('dialog.invite.error', err.reason) if err?
}