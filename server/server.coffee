Meteor.publish 'events', ->
	Events.find({})

Meteor.publish 'userData', ->
	Meteor.users.find({_id: this.userId})

Meteor.publish 'allUserData', ->
	user = Meteor.users.findOne(this.userId, fields: {admin: 1})
	unless user?
		throw new Meteor.Error(403, 'You are not logged in.')

	if user.admin
		Meteor.users.find()
	else
		Meteor.users.find(this.userId)

Meteor.users.allow {
	update: (userId, user, fields) ->		
		unless user._id == userId || user.admin
			throw new Meteor.Error(403, 'Permission denied. You are not allowed to edit this user.')

		allowed = ['name']
		unless _.all(fields, (f) -> f in allowed)
			diff = _.difference(fields, allowed)
			throw new Meteor.Error(403, "You are not allowed to update #{diff.join(', ')}.")

		true
}

Meteor.methods {
	'sendInvitation': (options) ->

		# Check if user already exists
		if Meteor.users.find({'services.google.email': options.email}).count() > 0
			throw new Meteor.Error(400, 'This email is already registered on EvCy.')

		# Check if invitation already exists
		if Invitations.find({email: options.email}).count() > 0
			throw new Meteor.Error(400, 'Invitation has already been sent to this user.')

		token = randString()
		Invitations.insert({email: options.email, token: token})

		url = "http://evcy.meteor.com?token=#{token}"

		user = Meteor.user()

		this.unblock()
		Email.send
			to: options.email,
			from: 'no-reply@evcy.meteor.com',
			subject: 'You have been invited to EvCy!',
			html: """
				Hi there,<br>
				<br>
				You have been invited to use EvCy by #{user.profile.name}.<br>
				<br>
				Head over to <a href="#{url}">#{url}</a>, registrations requires 2 clicks!<br>
				<br>
				Over and out,<br>
				EvCy
				""",
			text: """
				Hi there,

				You have been invited to use EvCy by #{user.profile.name}.

				Head over to #{url}, registrations requires 2 clicks!

				Over and out,
				EvCy
				"""
}