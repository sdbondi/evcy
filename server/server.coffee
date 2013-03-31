Meteor.publish 'events', ->
	return Events.find({})

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