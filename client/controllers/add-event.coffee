Template.addEvent.rendered = ->
	$('.datepicker').datepicker
		format: 'dd/mm/yyyy', 
		startDate: 1.day().ago(),
		autoclose: true,
		todayHighlight: true

	$('.accordion').collapse
		toggle: false

	if window.filepicker
		filepicker.constructWidget(elem) for elem in $('[type="filepicker"]')

Template.addEvent.freqChecked = (freq) ->
	val = Session.get('add_event.frequency')
	return 'checked' unless val? && freq != 'onceoff'
	val == freq && 'checked'

Template.addEvent.nextMonthlyOccurrence = ->
	data = Helpers.serializeForm(this.find('#form-event'))
	cycle = new Evcy.EventCycle()
	cycle.setFrequency(EventCycle.FREQ_MONTHLY)
	cycle.getNextDate().toString('dddd, ddS MMM yyyy')

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

	'submit #form-event': (e) ->
		e.preventDefault()
}
