
// script.js
$(document).ready(function() {
	// 페이지 1 로드 버튼 클릭 시
	$("#radio-1").click(function() {
		// 비동기로 페이지 2의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
		$("#page2-content").hide();
		$("#page3-content").hide();
		$("#page4-content").hide();
		$("#date_content").hide();
		$("#page1-content").show();
	});

	// 페이지 2 로드 버튼 클릭 시
	$("#radio-2").click(function() {
		// 비동기로 페이지 2의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
		$("#page1-content").hide();
		$("#page3-content").hide();
		$("#page4-content").hide();
		$("#date_content").hide();
		$("#page2-content").show();
	});

	$("#radio-3").click(function() {
		// 비동기로 페이지 3의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
		$("#page1-content").hide();
		$("#page2-content").hide();
		$("#page4-content").hide();
		$("#date_content").hide();
		$("#page3-content").show();
	});

	$("#radio-4").click(function() {
		// 비동기로 페이지 4의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
		$("#page1-content").hide();
		$("#page2-content").hide();
		$("#page3-content").hide();
		$("#date_content").hide();
		$("#page4-content").show();
	});

});

	
$(function(){
	function c(){
	p();
	var e=h();
	var r=0;
	var u=false;
	l.empty();
		while(!u){
			if(s[r]==e[0].weekday){u=true}
				else{l.append('<div class="blank"></div>');r++}
				}for(var c=0;c<42-r;c++){
					if(c>=e.length){
						l.append('<div class="blank"></div>')
							}else{var v=e[c].day; var m=g(new Date(t,n-1,v))?'<div class="today" id="date">':"<div id='date'>"; l.append(m+""+v+"</div>")}} var y=o[n-1]; a.css("background-color",y).find("h1").text(i[n-1]+" "+t);f.find("div").css("color",y);l.find(".today").css("background-color",y); d()}function h(){var e=[];for(var r=1;r<v(t,n)+1;r++){e.push({day:r,weekday:s[m(t,n,r)]})}return e}function p(){f.empty();for(var e=0;e<7;e++){f.append("<div>"+s[e].substring(0,3)+"</div>")}}function d(){var t;var n=$("#calendar").css("width",e+"px");n.find(t="#calendar_weekdays, #calendar_content").css("width",e+"px").find("div").css({"width":e/7+"px", "height":e/7+"px","line-height":e/7+"px"});n.find("#calendar_header").css({"height":e*(1/7)+"px"}).find('i[class^="icon-chevron"]').css("line-height",e*(1/7)+"px")}function v(e,t){return(new Date(e,t,0)).getDate()}function m(e,t,n){return(new Date(e,t-1,n)).getDay()}function g(e){return y(new Date)==y(e)}function y(e){return e.getFullYear()+"/"+(e.getMonth()+1)+"/"+e.getDate()}function b(){var e=new Date;t=e.getFullYear();n=e.getMonth()+1}var e=480;var t=2013;var n=9;var r=[];var i=["JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"];var s=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];var o=["#16a085","#1abc9c","#c0392b","#27ae60","#FF6860","#f39c12","#f1c40f","#e67e22","#2ecc71","#e74c3c","#d35400","#2c3e50"];var u=$("#calendar");var a=u.find("#calendar_header");var f=u.find("#calendar_weekdays");var l=u.find("#calendar_content"); $("#calendar_content").on("click", "#date", function() { $("#date_content").show();}); b();c();a.find('i[class^="icon-chevron"]').on("click",function(){var e=$(this);var r=function(e){n=e=="next"?n+1:n-1;if(n<1){n=12;t--}else if(n>12){n=1;t++}c()};if(e.attr("class").indexOf("left")!=-1){r("previous")}else{r("next")}})})
