Template.profile.profile = ->	
	Meteor.user().profile

Template.profile.googleData = ->
	_.omit(Meteor.user().services.google, 
		'accessToken','expiresAt','id','verified_email', 'picture')

Template.profile.googlePicture = ->
	Meteor.user().services.google.picture

Template.profile.events {
	'click #btn-save': (e, template) ->	
		$self = $(e.target)
		$self.prop('disabled', true)
		e.preventDefault()	
		data = Helpers.serializeForm(template.find('form'))
		Meteor.users.update(Meteor.userId(), $set: {profile: data}, ->
			$self.prop('disabled', false)
		)	

	'click #btn-delete-account': (e) ->
		e.preventDefault()

		showDialog('deleteAccountConfirm')
}