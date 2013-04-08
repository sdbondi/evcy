# Header partial
Template._header.events {
	'click .nav a': (e) ->
		e.preventDefault()
		showDialog(null)
		$target = $(e.target)
		
		return unless page = $target.data('page')

		$target.closest('li').addClass('active')
			.siblings().removeClass('active')

		setPage(page) 

	'click .nav a#nav-invite': (e) ->
		showDialog('invite')
}

Template._header.alerts = ->
	Session.get('_flashAlerts')

this.onload = ->
	$('.loading-banner').addClass('opacity-none')
	