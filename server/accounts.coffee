Accounts.validateNewUser (user) ->
	unless user.services.google?
		throw new Meteor.Error(403, "Please use Google to login.");
	
	# If this is the first user ever, make the user an admin
	if Meteor.users.find().count(admin: 1) == 0
		user.admin = true
		return true

	email = user.services.google.email
	entry = Invitations.findOne({email: email})

	unless entry
		throw new Meteor.Error(403, "Sorry, you have to be invited to use this app!");	

	user.admin = !!entry.admin

	Invitations.remove({_id: entry._id}, true)

	true


Meteor.methods {
	deleteUser: (args) ->
		unless args.userId == this.userId || Meteor.user().admin
			throw new Meteor.Error(403, 'You do not have permission to delete this user.')

		Meteor.users.remove(_id: this.userId)
		true
}