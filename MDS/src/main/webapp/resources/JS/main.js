
// script.js
$(document).ready(function() {
    // 페이지 1 로드 버튼 클릭 시
    $("#radio-1").click(function() {
        // 비동기로 페이지 2의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
        $("#page2-content").hide();
        $("#page3-content").hide();
        $("#page4-content").hide();
        $("#page5-content").hide();
        
        $("#page1-content").show();
    });

    // 페이지 2 로드 버튼 클릭 시
    $("#radio-2").click(function() {
        // 비동기로 페이지 2의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
        $("#page1-content").hide();
        $("#page3-content").hide();
        $("#page4-content").hide();
        $("#page5-content").hide();
        
        $("#page2-content").show();
    });
    
    $("#radio-3").click(function() {
        // 비동기로 페이지 3의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
        $("#page1-content").hide();
        $("#page2-content").hide();
        $("#page4-content").hide();
        $("#page5-content").hide();
        
        $("#page3-content").show();
    });
    
    $("#radio-4").click(function() {
        // 비동기로 페이지 4의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
        $("#page1-content").hide();
        $("#page2-content").hide();
        $("#page3-content").hide();
        $("#page5-content").hide();
        $("#page4-content").show();
    });
    
    $("#radio-5").click(function() {
        // 비동기로 페이지 5의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
        $("#page1-content").hide();
        $("#page2-content").hide();
        $("#page3-content").hide();
        $("#page4-content").hide();
        $("#page5-content").show();
    });
});



	