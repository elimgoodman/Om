$(function(){
    var opts = {
        lineNumbers: true
    };

    var expr_mirror = CodeMirror.fromTextArea($("#expression").get(0), opts);
    var grammar_mirror = CodeMirror.fromTextArea($("#grammar").get(0), opts);
    var output_mirror = CodeMirror.fromTextArea($("#output").get(0), opts);
});
