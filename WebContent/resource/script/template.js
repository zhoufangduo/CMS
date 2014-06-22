
var config = {
		"1":{type:"Word", img:"1.png", showType:"file",fileType:"doc"},
		"2":{type:"Excel", img:"2.png", showType:"file",fileType:"xls"},
		"3":{type:"PPT", img:"3.png", showType:"file",fileType:"ppt"},
		"4":{type:"图片", img:"4.png", showType:"file",fileType:"png"},
		"5":{type:"视频", img:"5.png", showType:"file",fileType:"mp4"},
		"6":{type:"超链接", img:"6.png", showType:"link",fileType:"url"},
		"7":{type:"Html文件", img:"7.png", showType:"file",fileType:"html"},
		"8":{type:"实战项目", img:"8.png", showType:"text",fileType:"text"},
		"9":{type:"组内讨论", img:"9.png", showType:"text",fileType:"text"},
		"10":{type:"考试", img:"10.png", showType:"select",fileType:"select"},
		"11":{type:"练习", img:"11.jpg", showType:"text",fileType:"text"},
		"12":{type:"测验", img:"12.jpg", showType:"text",fileType:"text"},
		"13":{type:"面试", img:"13.jpg", showType:"text",fileType:"text"},
		"14":{type:"常用软件讲解", img:"14.jpg", showType:"text",fileType:"text"},
		"15":{type:"经典代码讲解", img:"15.jpg", showType:"text",fileType:"text"},
		"16":{type:"Java文件", img:"16.png", showType:"file",fileType:"java"},
		"17":{type:"压缩包", img:"17.png", showType:"file",fileType:"zip"},
		"18":{type:"文本", img:"18.png", showType:"text",fileType:"text"},
		"19":{type:"文件", img:"19.png", showType:"file",fileType:"all"},
		"20":{type:"PDF文件", img:"20.png", showType:"file",fileType:"pdf"}
};

function setImg(ele,ctxpath,index){
	$(ele).attr("src",ctxpath + "/resource/images/templ/" + config[index].img) ;
	$(ele).attr("title", config[index].type);
}

function setType(ele,index){
	$(ele).html(config[index].type);
	$(ele).attr("title", config[index].type);
}

function setTypes(ele,indexs){
	var types = indexs.split(";");
	var html = "";
	for(var i = 0;  i < types.length; i ++ ){
		html += config[types[i]].type + "  ";
	}
	$(ele).attr("title", html);
	$(ele).html(html);
}
