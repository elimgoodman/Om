_ = require 'underscore'
ometa = require 'ometajs'
fs = require 'fs'

expression_grammar = require './expression.ometajs'

project_root = "./om_project/"
grammars = {}

grammar_dir = project_root + "/grammars"
expression_dir = project_root + "/expressions"

grammar_files = fs.readdirSync grammar_dir
expression_files = fs.readdirSync expression_dir

_.each grammar_files, (grammar_file) ->
    filename = grammar_dir + "/" + grammar_file
    grammar = require filename
    _.extend grammars, grammar

_.each expression_files, (expression_file) ->
    filename = expression_dir + "/" + expression_file
    expression = fs.readFileSync filename, 'UTF-8'
    grammar = expression_grammar.Expression.matchAll expression, "grammarsUsed"
    grammar_obj = grammars[grammar]
    grammar_obj.matchAll expression, "topLevel"

