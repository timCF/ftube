page = require('webpage').create()
system = require('system')
rand = () -> Math.floor(Math.random() * 10000)
mmove = () ->
	page.sendEvent('mousemove', rand(), rand())
	setTimeout(mmove, Math.floor(rand()/100))
setTimeout((() -> console.log("UNEXPECTED ERROR, TIMEOUT, HALT!") ; slimer.exit()), 300000 + rand())
page.open(system.args[1], (status) ->
	if (status == "success")
		console.log(Date()+" start video")
		mmove()
		setTimeout((() -> console.log(Date()+" end video") ; slimer.exit()), 150000 + rand())
	else
		console.log("error on connection "+status+" HALT")
		slimer.exit())
