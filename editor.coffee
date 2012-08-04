temp = require 'temp'
fs = require 'fs'
express = require 'express'
ometa = require 'ometajs'
app = express.createServer()

project_root = "./om_project/"
expression_file = project_root + "expressions/test.ex"
grammar_file = project_root + "grammars/test.ometajs"
default_grammar = "Test"

app.set("view options", {layout: false})

app.configure () ->
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))
    app.use(express.methodOverride())
    app.use(express.bodyParser())
    app.use(app.router)
    app.use(express.static(__dirname + '/../static'))

app.get '/', (req, res) ->
    expression = fs.readFileSync expression_file, 'UTF-8'
    grammar = fs.readFileSync grammar_file, 'UTF-8'

    res.render(__dirname + '/../views/index.jade', {
        expression: expression,
        grammar: grammar,
        default_grammar: default_grammar
    })

app.post '/execute', (req, res) ->

    fs.writeFileSync expression_file, req.body.expr, 'UTF-8'
    fs.writeFileSync grammar_file, req.body.grammar, 'UTF-8'

    #unspeakable hack
    temp.open {suffix: '.ometajs'}, (err, info) ->
        fs.write info.fd, req.body.grammar
        fs.close info.fd, (err) ->
            grammar = require info.path
            grammar_used = req.body.grammar_used
            error = null
            output_str = null
            try
                output = grammar[grammar_used].matchAll req.body.expr, "topLevel"
                output_str = output.toString()
            catch err
                error = err
                
                output_str = ""
            res.contentType 'json'
            res.send JSON.stringify {output: output_str, error: error}
          
          
console.log "Running on port 3000"
app.listen(3000)
