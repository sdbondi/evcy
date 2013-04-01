# Header partial
Template._header.events {
	'click .nav a': (e) ->
		e.preventDefault()
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

Template._header.alerts = ->
	Session.get('_flashAlerts')

Template._header.showLoading = ->
	Session.get('_loading')