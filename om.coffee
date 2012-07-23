_ = require 'underscore'
ometa = require 'ometajs'
fs = require 'fs'

project_root = "/Users/eli/dev/om_project/"
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


