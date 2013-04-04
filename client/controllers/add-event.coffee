Template.addEvent.selectTimeOptions = Helpers.selectTimeOptions

Template.addEvent.today = ->
	date = new Date()

	"#{date.getDate()}/#{date.getMonth()}/#{date.getYear()}"

Template.addEvent.rendered = ->
	$('.datepicker').datepicker
		format: 'dd/mm/yyyy', 
		startDate: new Date(),
		autoclose: true,
		todayHighlight: true

	if window.filepicker
		filepicker.constructWidget(elem) for elem in $('[type="filepicker"]')

Template.addEvent.eventImageSrc = (eventId) ->	
	if file = Session.get('add_event.picture') then file.url else null

Template.addEvent.events {
	'change #picture-event': (e) ->
		Session.set('add_event.picture', e.fpfile)

	'click .cancel': (e) ->
		e.preventDefault()
		setPage('eventList')

	'submit #form-add-event': (e) ->
		e.preventDefault()
		# ....
}