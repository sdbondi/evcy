Template.addEvent.rendered = ->
	$('.datepicker').datepicker
		format: 'dd/mm/yyyy', 
		startDate: new Date(),
		autoclose: true,
		todayHighlight: true

	if window.filepicker
		filepicker.constructWidget(elem) for elem in $('[type="filepicker"]')

	Session.set('add_event.frequency', 'onceoff')

Template.addEvent.freqChecked = (freq) ->
	debugger
	Session.equals('add_event.frequency', freq)

Template.addEvent.eventImageSrc = (eventId) ->	
	if file = Session.get('add_event.picture') then file.url else null

Template.addEvent.yieldFrequencyTemplate = ->
	freq = Session.get('add_event.frequency')
	if freq && "frequency_#{freq}" of Template
		Template["frequency_#{freq}"]() 

Template.addEvent.events {
	'change #picture-event': (e) ->
		Session.set('add_event.picture', e.fpfile)

	'change #event-frequency input': (e) ->
		Session.set('add_event.frequency', e.target.value)

	'click .cancel': (e) ->
		e.preventDefault()
		setPage('eventList')

	'submit #form-add-event': (e) ->
		e.preventDefault()
}
