// Generated by CoffeeScript 1.3.3
(function() {
  var expression_dir, expression_files, expression_grammar, fs, grammar_dir, grammar_files, grammars, ometa, project_root, _;

  _ = require('underscore');

  ometa = require('ometajs');

  fs = require('fs');

  expression_grammar = require('./expression.ometajs');

  project_root = "./om_project/";

  grammars = {};

  grammar_dir = project_root + "/grammars";

  expression_dir = project_root + "/expressions";

  grammar_files = fs.readdirSync(grammar_dir);

  expression_files = fs.readdirSync(expression_dir);

  _.each(grammar_files, function(grammar_file) {
    var filename, grammar;
    filename = grammar_dir + "/" + grammar_file;
    grammar = require(filename);
    return _.extend(grammars, grammar);
  });

  _.each(expression_files, function(expression_file) {
    var expression, filename, grammar, grammar_obj;
    filename = expression_dir + "/" + expression_file;
    expression = fs.readFileSync(filename, 'UTF-8');
    grammar = expression_grammar.Expression.matchAll(expression, "grammarsUsed");
    grammar_obj = grammars[grammar];
    return grammar_obj.matchAll(expression, "topLevel");
  });

}).call(this);
