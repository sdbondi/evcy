class @Helpers
	@selectTimeOptions: ->
		html = ''
		for i in [0..23]
			h = if i % 12 == 0 then 12 else i % 12
			H = i
			ampm = if i >= 12 then 'pm' else 'am'
			for i in [1..2]
				m = if i % 2 == 0 then '30' else '00'
				html += "<option value='#{H}:#{m}'>#{h}:#{m}#{ampm}</option>"
		html

	@serializeForm: (form) ->
		data = $(form).serializeArray()
		obj = {}
		obj[o.name] = o.value for o in data
		obj

	@arrayify: (obj) ->
		result = [];
		for k, v of obj
			result.push(key:k, value:v)
		result;

	@addScript: (path, loadCb = null, errorCb = null) ->
		script = document.createElement('script')
		script.type = 'text/javascript'
		script.src = path
		script.onload = loadCb
		script.onerror = errorCb

		document.getElementsByTagName('head')[0].appendChild(script)

	@addCss: (path) ->
		link = document.createElement('link')
		link.rel = 'stylesheet'
		link.href = path

		document.getElementsByTagName('head')[0].appendChild(link)

# UI / Session
@showLoading = (flag) ->
	Session.set('_loading', flag)

@showAlert = (type, message) ->
	flash = Session.get('_flashAlerts')
	id = flash.length + 1
	flash.push({id: id, type: type, message: message})
	Session.set('_flashAlerts', flash)

	setTimeout(->
		Session.set('_flashAlerts', _.reject(flash, (alert) -> alert.id == id))
	, 5000)

@setPage = (page) ->
	Session.set('_activePage', page)	

@showDialog = (name) ->
	Session.set('_currentDialog', name)
	if name then $('.modal').show() else $('.modal').hide()

@clearAlerts = ->
	Session.set('_flashAlerts', [])

# Handlebars
Handlebars.registerHelper 'arrayify', Helpers.arrayify
Handlebars.registerHelper 'isEqual', (v1, vn...) ->
	for v in vn
		return false if v != v1

	true