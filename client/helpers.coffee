class Helpers

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

# Handlebars
Handlebars.registerHelper 'arrayify', Helpers.arrayify
Handlebars.registerHelper 'isEqual', (v1, vn...) ->
	for v in vn
		return false if v != v1

	true