Accounts.validateNewUser (user) ->
	unless user.services.google?
		throw new Meteor.Error(403, "Please use Google to login.");

	email = user.services.google.email
	emails = EntryList.find({}, {email: 1})

	# If you are the first user ever, we assume that you are an admin
	if emails.count() == 0
		return true

	unless (_.any emails, (_email) -> email == _email.email)
		throw new Meteor.Error(403, "Sorry, this is invite only!");