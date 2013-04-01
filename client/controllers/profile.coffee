Template.profile.profile = ->	
	Meteor.user().profile

Template.profile.googleData = ->
	data = Meteor.user().services.google
	delete data.accessToken
	delete data.expiresAt
	delete data.id
	delete data.locale
	delete data.verified_email
	delete data.picture
	data

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

	'click #btn-cancel': (e) ->
		e.preventDefault()	
		setPage('eventList')
}