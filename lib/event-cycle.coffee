class @EventCycle
	@FREQ: 
		ONCEOFF: 'onceoff',
		DAILY: 'daily',
		WEEKLY: 'weekly',
		MONTHLY: 'monthly',
		YEARLY: 'yearly',
		CUSTOM: 'custom'
	
	constructor: ->
		@frequency = @FREQ.ONCEOFF

	setFrequency: (freq) =>
		@frequency = freq

	getNextDate: =>
		Date.today()

