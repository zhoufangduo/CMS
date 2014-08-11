
var month_days = {"1":31, "2":{"leap":29,"nonleap":28}, "3":31, "4":30, "5":31, "6":30, "7":31, "8":31, "9":30, "10":31, "11":30, "12":31};

var intervalID ;

var curDate ;

function refush(date){
	
	var index  = 1;
	
	if(hasLastMonth(date)){
		
		var days = getDay(new Date(getYear(date),getMonth(date),1));
		
		if(days == 0){
			
			index = index + 7;
			days  = 7;
			
		}else{
			index  = index + days;
		}
		
		showLastMonth(days, date);
	}
	
	index = showNow(index, date);
	
	if(hasNextMonth(date)){
		showNext(index, date);
	}
}

function hasLastMonth(date){
	return true;
}

function hasNextMonth(date){
	return true;
}

function showNext(index,date){
	
	var days = 1;
	
	for(var i = index ; i <= 42; i ++){
		
		$("#"+i).html("<span class='next'>"+days+"</span>");
		$("#"+i).val(getYear(date) +"-"+ (getMonth(date) + 2) + "-" + days);
		
		days  ++;
	}

}

function showLastMonth(days, date){
	
	var totalDays = getTotalDate(date);
	
	for(var i = days; i >= 1; i --){
		
		$("#"+i).html("<span class='last'>"+totalDays+"</span>");
		
		$("#"+i).val(getYear(date) +"-"+ getMonth(date) + "-" + totalDays);
		
		totalDays --;
	}
}

function showNow(index, date){
	
	var totalDays = getTotalDate(date);
	
	var today = getFormatDate(new Date());
	
	for(var i = 1; i <= totalDays; i ++){
		
		var otherDay = getFormatDate(new Date(getYear(date), getMonth(date),i));
		
		if(today == otherDay){
			$("#"+index).html("<span class='now'>" + i + "</span>");
		}else{
			$("#"+index).html(i);
		}
		
		$("#"+index).val(getYear(date) +"-"+ (getMonth(date) + 1) + "-" +i);
		
		index  ++;
	}
	
	return index ;
}

function getTotalDate(date){
	
	var totalDate = month_days[getMonth(date)+1];
		
	if(getMonth(date) + 1 == 2){
		if(isLeapYear(date)){
			totalDate = month_days[getMonth(date)+1].leap;
		}else{
			totalDate = month_days[getMonth(date)+1].nonleap;
		}
	}
	
	return totalDate;
}


function getYear (date){
	return date.getFullYear();
}

function isLeapYear(date){
	
	var Year = getYear(date);
	
	if (((Year % 4)==0) && ((Year % 100)!=0) || ((Year % 400)==0)) {
		return true;
	}
	
	return false;
}

function getMonth(date){
	return date.getMonth() ;
}

function getDate(date){
	return date.getDate();
}

function getDay(date){
	return date.getDay();
}

function getFormatDate(date){
	return getYear(date) + "-" + getMonth(date) + "-" + getDate(date);
}

function getShowDate(date){
	 return getYear(date) + "-" + (getMonth(date) + 1) + "-" + getDate(date);
}

function getFormatFullTime(date){
	return getYear(date) + "-" + (getMonth(date) + 1) + "-" + getDate(date) + " "
	+ date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
}


function getFormatTime(date){
	return  date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
}

function show(){
	init();
	
	curDate = new Date();
	
	refush(curDate);
}

function init(){
	
	$("#curTime").html(getFormatTime(new Date()));
	
	intervalID =  window.setInterval(function(){
		$("#curTime").html(getFormatTime(new Date()));
	}, 900);
	
	$("#curDate").val(getShowDate(new Date()));
}

function cleanInterval(){
	
	WdatePicker({dateFmt:'yyyy-MM-dd',el: 'curDate',onpicked:function(){
		
		curDate = new Date($("#curDate").val());
		
		refush(curDate);
		
		$dp.hide();
	}});
}

function toLastMonth(){
	
	curDate = new Date(getYear(curDate),getMonth(curDate)-1);
	
	$("#curDate").val(getShowDate(curDate));
	
	refush(curDate);
}

function toNexMonth(){

	curDate = new Date(getYear(curDate),getMonth(curDate) + 1);
	
	$("#curDate").val(getShowDate(curDate));
	
	refush(curDate);
}

$(function(){
	show();
	$("td").bind("click",function(e){
		var date = $(e.target).val();
	});
});