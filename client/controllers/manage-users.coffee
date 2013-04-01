Template.manageUsers.users = ->
	Meteor.users.find().fetch()