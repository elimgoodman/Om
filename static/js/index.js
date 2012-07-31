$(function(){
    var opts = {
        lineNumbers: true
    };

    var expr_mirror = CodeMirror.fromTextArea($("#expression").get(0), opts);
    var grammar_mirror = CodeMirror.fromTextArea($("#grammar").get(0), opts);
    var output_mirror = CodeMirror.fromTextArea($("#output").get(0), opts);

    $("#execute").click(function(){
        var params = {
            expr: expr_mirror.getValue(),
            grammar: grammar_mirror.getValue(),
            grammar_used: $("#grammar-used").val()
        };

        $.post("/execute", params, function(data){
            output_mirror.setValue(data.output);
        }, "json");
    });
});
