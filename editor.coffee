temp = require 'temp'
fs = require 'fs'
express = require 'express'
ometa = require 'ometajs'
app = express.createServer()

app.set("view options", {layout: false})

app.configure () ->
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))
    app.use(express.methodOverride())
    app.use(express.bodyParser())
    app.use(app.router)
    app.use(express.static(__dirname + '/../static'))

app.get '/', (req, res) ->
  res.render(__dirname + '/../views/index.jade')

app.post '/execute', (req, res) ->

    #unspeakable hack
    temp.open {suffix: '.ometajs'}, (err, info) ->
        fs.write info.fd, req.body.grammar
        fs.close info.fd, (err) ->
            grammar = require info.path
            grammar_used = req.body.grammar_used
            output = grammar[grammar_used].matchAll req.body.expr, "topLevel"
            res.contentType 'json'
            res.send JSON.stringify {output: output.toString()}
          
          
console.log "Running on port 3000"
app.listen(3000)
