Meteor.publish 'events', ->
	Events.find({})

Meteor.publish 'userData', ->
	Meteor.users.find({_id: this.userId}, fields: {pwd: 0})

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
