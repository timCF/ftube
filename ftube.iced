page = require('webpage').create()
system = require('system')
rand = () -> Math.floor(Math.random() * 5000)
setTimeout((() -> console.log("UNEXPECTED ERROR, TIMEOUT, HALT!") ; phantom.exit()), 600000)
page.open(system.args[1], (status) ->
	if (status == "success")
		console.log(Date()+" start video")
		setTimeout((() -> console.log(Date()+" end video") ; phantom.exit()), 540000 + rand())
	else
		console.log("error on connection "+status+" HALT")
		phantom.exit())
