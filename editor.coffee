express = require('express')
app = express.createServer()

app.get '/', (req, res) ->
  res.render(__dirname + '/../views/index.jade')

app.set("view options", {layout: false})

app.configure () ->
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))
    app.use(express.methodOverride())
    app.use(express.bodyParser())
    app.use(app.router)
    app.use(express.static(__dirname + '/../static'))

console.log "Running on port 3000"
app.listen(3000)
