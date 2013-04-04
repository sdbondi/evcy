@randString = (len = 10) ->
    text = ''
    possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'

    for i  in [0..len]
      text += possible.charAt(Math.floor(Math.random() * possible.length))

    text
