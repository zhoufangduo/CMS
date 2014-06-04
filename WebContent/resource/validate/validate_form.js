var ele ;

function showErrorPlacement(error, element) {
	ele = element;
	$(element).attr("title",$(error).html());
	$(element).parents(".form-group").attr("class","form-group has-error");
}

function success(label) {
	$(ele).attr("title","");
	$(ele).parents(".form-group").attr("class","form-group has-success");
}

function showErrorTab(error, element){
	$('#navTab a:first').tab('show'); 
	showErrorPlacement(error, element);
}