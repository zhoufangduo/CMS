var ele ;

function showErrorPlacement(error, element) {
	ele = element;
	$(element).attr("title",$(error).html());
	
	if($(element).attr("class") == "time error"){
		$(element).attr("class","timeErr");
	}else{
		$(element).parents(".form-group").attr("class","form-group has-error");
	}
}

function success(label) {
	$(ele).attr("title","");
	
	if($(ele).attr("class") == "timeErr"){
		$(ele).attr("class","timeSucc");
	}else{
		$(ele).parents(".form-group").attr("class","form-group has-success");
	}
}

function showErrorTab(error, element){
	$('#navTab a:first').tab('show'); 
	showErrorPlacement(error, element);
}