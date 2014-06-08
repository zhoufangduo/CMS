
var config = {
		"0":{type:"all",img:"0.png"},
		"1":{type:"Word",img:"1.png"},
		"2":{type:"Excel",img:"2.png"},
		"3":{type:"PPT",img:"3.png"},
		"4":{type:"图片",img:"4.png"},
		"5":{type:"视频",img:"5.png"},
		"6":{type:"超链接",img:"6.png"},
		"7":{type:"Html文件",img:"7.png"},
		"8":{type:"实战项目",img:"8.png"},
		"9":{type:"组内讨论",img:"9.png"},
		"10":{type:"考试",img:"10.png"},
		"11":{type:"练习",img:"11.jpg"},
		"12":{type:"测验",img:"12.jpg"},
		"13":{type:"面试",img:"13.jpg"},
		"14":{type:"常用软件讲解",img:"14.jpg"},
		"15":{type:"经典代码讲解",img:"15.jpg"},
		"16":{type:"Java文件",img:"16.png"},
		"17":{type:"压缩包",img:"17.png"},
		"18":{type:"文本",img:"18.png"},
		"19":{type:"文件",img:"19.png"}
};

function setImg(ele,ctxpath,index){
	$(ele).attr("src",ctxpath + "/resource/images/templ/" + config[index].img) ;
}

function setType(ele,index){
	$(ele).html(config[index].type);
}
