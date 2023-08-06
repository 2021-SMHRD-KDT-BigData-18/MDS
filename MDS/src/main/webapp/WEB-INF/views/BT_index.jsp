<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Dashboard - SB Admin</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="resources/BT_css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
<link href="resources/images/cam.png" rel="shortcut icon"
   type="image/png">
<!-- fullcalendar CDN -->
<link
   href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css'
   rel='stylesheet' />
<script
   src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script
   src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
</head>
<body class="sb-nav-fixed">
   <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-6">
                <div class="logo_img">
                    <a class="logo" href="javascript:listView('${result.u_id}')">
                        <img alt="MDS로고" src="resources/images/MDS_logo.png" width="180px" height="60px">
                    </a>
                </div>
            </div>
            <div class="col-6 d-flex justify-content-end">
                <div class="header">
                <!-- 
                    <button type="button" class="icon-button" id="icon-button">
                        <img src="resources/images/bell.svg" alt="알림" name="bell"> 
                        <span class="glider" id="countAlarm"></span> 
                        <span class="notification"></span>
                 -->
                    </button>
                    <a href="logout.com">로그아웃</a>
                </div>
            </div>
        </div>
    </div>
</nav>

   <div id="layoutSidenav">
      <div id="layoutSidenav_nav">
         <nav class="sb-sidenav accordion sb-sidenav-dark"
            id="sidenavAccordion">
            <div class="sb-sidenav-menu">
               <div class="nav">
                  <div class="sb-sidenav-menu-heading">CCTV</div>
                  <div class="nav-link" id="radio-1">
                     <div class="sb-nav-link-icon">
                        <i class="fas fa-tachometer-alt"></i>
                     </div>
                     실시간 영상
                  </div>
                  <div class="sb-sidenav-menu-heading">데이터</div>
                  <div id="radio-2" class="nav-link collapsed"
                     data-bs-toggle="collapse" data-bs-target="#collapseLayouts"
                     aria-expanded="false" aria-controls="collapseLayouts">
                     <div class="sb-nav-link-icon">
                        <i class="fas fa-columns"></i>
                     </div>
                     데이터 조회
                     <div class="sb-sidenav-collapse-arrow">
                        <i class="fas fa-angle-down"></i>
                     </div>
                  </div>
                  <div id="radio-3" class="nav-link collapsed"
                     data-bs-toggle="collapse" data-bs-target="#collapsePages"
                     aria-expanded="false" aria-controls="collapsePages">
                     <div class="sb-nav-link-icon">
                        <i class="fas fa-book-open"></i>
                     </div>
                     데이터 분석
					<div class="sb-sidenav-collapse-arrow">
						<i class="fas fa-angle-down"></i>
					</div>
					<div class="collapse show", id="collapsePages">
						<nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages"></nav>
						<div class="nav-link collapsed">
						    <input id="data_pas" class = "navdatachkbx" type="checkbox" name="dataanalyze" value="passing" onclick="getNavChkbxVal(this)" style="display: none"><label for="data_pas">출입</label>
						</div>
						<div class="nav-link collapsed">
						    <input id="data_itr" class = "navdatachkbx" type="checkbox" name="dataanalyze" value="intrude" onclick="getNavChkbxVal(this)" style="display: none"><label for="data_itr">침입</label>
						</div>
					</div>
				</div>
				<div class="sb-sidenav-menu-heading">정보수정</div>
				<div id="radio-4" class="nav-link" href="tables.html">
					<div class="sb-nav-link-icon">
						<i class="fas fa-table"></i>
					</div>
                     마이페이지
                  </div>
               </div>
            </div>
            <div class="sb-sidenav-footer">
               <div class="small">
                  <c:choose>
                     <c:when test="${result ne null}">
                           ${result.u_id}님,환영합니다!
                        </c:when>
                  </c:choose>
               </div>

            </div>
         </nav>
      </div>


      <div id="layoutSidenav_content">
         <main>

            <div class="videoPlayer" id="page1-content">
               <c:choose>
                  <c:when test="${result.u_id eq list.u_id && result ne null}">
                     <div class=outerHouse>
                     	<div class="bieber_camera" value="1번 카메라" >
                     		<div class="bieber_ment">
                     			<img alt="체포하겠어!" src="resources/images/siren.png">
								<div>
									<svg id="siren1" width="100" height="100" xmlns="http://www.w3.org/2000/svg">
									  <circle class="red-light" cx="50" cy="50" r="20" />
									</svg><br>
	                     			<h4>1번 카메라에서 감시모델이 작동중입니다.</h4>
								</div>
                     		</div>
                     		<div class="bieber_list" id="countList">출입 정보
                     		</div>
                     	</div>
                     	<div class="bieber_camera" value="2번 카메라">
                     		<div class="bieber_ment">
	                     		<img alt="체포하겠어!" src="resources/images/siren.png">
									<div>
										<svg id="siren2" width="100" height="100" xmlns="http://www.w3.org/2000/svg">
										  <circle class="red-light" cx="50" cy="50" r="20" />
										</svg><br>
		                     			<h4>2번 카메라에서 감시모델이 작동중입니다.</h4>
									</div>
	                     		</div>
                     		<div class="bieber_list" id="intrusionList">침입정보</div>
                     	</div>
                     </div>
                  </c:when>
               </c:choose>
            </div>

            <div class="calendar_page" id="page2-content" style="display: none;"
               value="데이터조회">

               <div id="calendar" class="calendar_size"></div>
               <div class="date" id="nows"></div>

            </div>


            <div class="analyze" id="page3-content" style="display: none;"
               value="데이터분석">
				<div><p></div>
					<fieldset class="checkbox-group">
						<div class="checkbox">
							<label class="checkbox-wrapper">
								<input type="checkbox" id="data_car" class="datachkbx" type="checkbox" name="dataanalyze" value="car" onclick="getChkbxVal(this)"/> 
								<span class="checkbox-tile">
									<span class="checkbox-icon">
										<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512" xml:space="preserve" fill="#000000"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M384,302.933c-23.552,0-42.667,19.115-42.667,42.667s19.115,42.667,42.667,42.667c23.552,0,42.667-19.115,42.667-42.667 S407.552,302.933,384,302.933z M384,371.2c-14.08,0-25.6-11.52-25.6-25.6c0-14.08,11.52-25.6,25.6-25.6s25.6,11.52,25.6,25.6 C409.6,359.68,398.08,371.2,384,371.2z"></path> <path d="M503.467,157.867h-25.6v-25.6c0-4.693-3.84-8.533-8.533-8.533H221.867c-3.499,0-6.656,2.133-7.936,5.376l-32,79.957H25.6 c-4.693,0-8.533,3.84-8.533,8.533v68.267H8.533C3.84,285.867,0,289.707,0,294.4v51.2c0,4.693,3.84,8.533,8.533,8.533h51.2 c4.693,0,8.533-3.84,8.533-8.533c0-32.939,26.795-59.733,59.733-59.733s59.733,26.795,59.733,59.733c0,4.693,3.84,8.533,8.533,8.533 h119.467c4.693,0,8.533-3.84,8.533-8.533c0-32.939,26.795-59.733,59.733-59.733s59.733,26.795,59.733,59.733 c0,4.693,3.84,8.533,8.533,8.533H486.4c4.693,0,8.533-3.84,8.533-8.533v-51.2c0-4.693-3.84-8.533-8.533-8.533h-8.533V268.8h25.6 c4.693,0,8.533-3.84,8.533-8.533V166.4C512,161.707,508.16,157.867,503.467,157.867z M341.333,140.8H460.8v68.267H341.333V140.8z M227.669,140.8h96.597v68.267H200.363L227.669,140.8z M477.867,337.067h-17.579C456.107,298.752,423.424,268.8,384,268.8 s-72.107,29.952-76.288,68.267H204.288C200.107,298.752,167.424,268.8,128,268.8s-72.107,29.952-76.288,68.267H17.067v-34.133H25.6 c4.693,0,8.533-3.84,8.533-8.533v-34.133h8.533c4.693,0,8.533-3.84,8.533-8.533s-3.84-8.533-8.533-8.533h-8.533v-17.067H460.8V243.2 h-8.533c-4.693,0-8.533,3.84-8.533,8.533s3.84,8.533,8.533,8.533h8.533V294.4c0,4.693,3.84,8.533,8.533,8.533h8.533V337.067z M494.933,251.733h-17.067v-76.8h17.067V251.733z"></path> <rect x="477.867" y="174.933" width="17.067" height="76.8"></rect> <path d="M128,302.933c-23.552,0-42.667,19.115-42.667,42.667s19.115,42.667,42.667,42.667s42.667-19.115,42.667-42.667 S151.552,302.933,128,302.933z M128,371.2c-14.08,0-25.6-11.52-25.6-25.6c0-14.08,11.52-25.6,25.6-25.6s25.6,11.52,25.6,25.6 C153.6,359.68,142.08,371.2,128,371.2z"></path> <path style="fill:#FFFFFF;" d="M145.067,345.6c0-12.621-9.276-23.108-21.333-25.165c-12.058,2.057-21.333,12.544-21.333,25.165 c0,12.621,9.276,23.108,21.333,25.165C135.791,368.708,145.067,358.221,145.067,345.6z"></path> <path style="fill:#F4F4F4;" d="M128,320c-1.459,0-2.867,0.196-4.267,0.435c12.058,2.057,21.333,12.544,21.333,25.165 c0,12.621-9.276,23.108-21.333,25.165c1.399,0.239,2.807,0.435,4.267,0.435c14.08,0,25.6-11.52,25.6-25.6 C153.6,331.52,142.08,320,128,320z"></path> <path style="fill:#FFFFFF;" d="M401.067,345.6c0-12.621-9.276-23.108-21.333-25.165c-12.058,2.057-21.333,12.544-21.333,25.165 c0,12.621,9.276,23.108,21.333,25.165C391.791,368.708,401.067,358.221,401.067,345.6z"></path> <path style="fill:#F4F4F4;" d="M384,320c-1.459,0-2.867,0.196-4.267,0.435c12.058,2.057,21.333,12.544,21.333,25.165 c0,12.621-9.276,23.108-21.333,25.165c1.399,0.239,2.807,0.435,4.267,0.435c14.08,0,25.6-11.52,25.6-25.6 C409.6,331.52,398.08,320,384,320z"></path> <rect x="341.333" y="140.8" style="fill:#FFFFFF;" width="102.4" height="51.2"></rect> <polygon style="fill:#F4F4F4;" points="443.733,140.8 443.733,192 341.333,192 341.333,209.067 460.8,209.067 460.8,140.8 "></polygon> <polygon style="fill:#FFFFFF;" points="307.2,140.8 227.669,140.8 207.189,192 307.2,192 "></polygon> <g> <path style="fill:#F4F4F4;" d="M207.189,192l-6.827,17.067L207.189,192z"></path> <polygon style="fill:#F4F4F4;" points="307.2,140.8 307.2,192 207.189,192 200.363,209.067 324.267,209.067 324.267,140.8 "></polygon> </g> <g> <path style="fill:#AFB42B;" d="M53.367,327.851c-0.06,0.247-0.137,0.495-0.188,0.751C53.239,328.346,53.308,328.107,53.367,327.851 z"></path> <path style="fill:#AFB42B;" d="M458.82,328.61c-0.06-0.256-0.137-0.512-0.196-0.768C458.692,328.098,458.769,328.346,458.82,328.61 z"></path> <path style="fill:#AFB42B;" d="M309.367,327.851c-0.06,0.247-0.137,0.495-0.188,0.751 C309.239,328.346,309.308,328.107,309.367,327.851z"></path> <path style="fill:#AFB42B;" d="M202.82,328.61c-0.06-0.256-0.137-0.512-0.196-0.768C202.692,328.098,202.769,328.346,202.82,328.61 z"></path> <path style="fill:#AFB42B;" d="M469.333,302.933c-4.693,0-8.533-3.84-8.533-8.533v-34.133h-8.533c-4.693,0-8.533-3.84-8.533-8.533 s3.84-8.533,8.533-8.533h8.533v-17.067H34.133V243.2h8.533c4.693,0,8.533,3.84,8.533,8.533s-3.84,8.533-8.533,8.533h-8.533V294.4 c0,4.693-3.84,8.533-8.533,8.533h-8.533V320h38.622c10.547-29.764,38.98-51.2,72.311-51.2s61.756,21.436,72.311,51.2h111.386 c10.547-29.764,38.98-51.2,72.311-51.2s61.756,21.436,72.311,51.2h21.547v-17.067H469.333z"></path> </g> <g> <path style="fill:#827717;" d="M53.18,328.602c-0.631,2.773-1.152,5.589-1.468,8.465C52.028,334.191,52.531,331.366,53.18,328.602z "></path> <path style="fill:#827717;" d="M55.689,320L55.689,320c-0.905,2.56-1.69,5.171-2.321,7.851C54.016,325.18,54.784,322.56,55.689,320 z"></path> <path style="fill:#827717;" d="M17.067,337.067h34.645c0.316-2.876,0.836-5.692,1.468-8.465c0.06-0.256,0.128-0.495,0.188-0.751 c0.631-2.679,1.417-5.291,2.321-7.851H17.067V337.067z"></path> <path style="fill:#827717;" d="M311.689,320L311.689,320c-0.905,2.56-1.69,5.171-2.321,7.851 C310.016,325.18,310.784,322.56,311.689,320z"></path> <path style="fill:#827717;" d="M204.288,337.067c-0.316-2.876-0.836-5.683-1.468-8.457 C203.469,331.375,203.972,334.191,204.288,337.067z"></path> <path style="fill:#827717;" d="M309.18,328.602c-0.623,2.773-1.152,5.589-1.468,8.465 C308.028,334.191,308.531,331.366,309.18,328.602z"></path> <path style="fill:#827717;" d="M200.311,320c0.905,2.56,1.673,5.18,2.321,7.842C201.993,325.171,201.216,322.56,200.311,320 L200.311,320z"></path> <path style="fill:#827717;" d="M202.624,327.842c0.06,0.256,0.137,0.512,0.196,0.768c0.623,2.773,1.152,5.581,1.468,8.457h103.424 c0.316-2.876,0.836-5.692,1.468-8.465c0.06-0.256,0.128-0.495,0.188-0.751c0.631-2.679,1.417-5.291,2.321-7.851H200.311 C201.216,322.56,201.993,325.171,202.624,327.842z"></path> <path style="fill:#827717;" d="M456.311,320c0.905,2.56,1.673,5.18,2.321,7.842C457.993,325.171,457.216,322.56,456.311,320 L456.311,320z"></path> <path style="fill:#827717;" d="M460.288,337.067c-0.316-2.876-0.836-5.683-1.468-8.457 C459.469,331.375,459.972,334.191,460.288,337.067z"></path> 
											<path style="fill:#827717;" d="M458.624,327.842c0.06,0.256,0.137,0.512,0.196,0.768c0.623,2.773,1.152,5.581,1.468,8.457h17.579 V320h-21.555C457.216,322.56,457.993,325.171,458.624,327.842z"></path> </g> 
											</g>
										</svg>
									</span>
									<span class="checkbox-label"><label for="data_car">차량</label></span>
							</label>
						</div>
						<div class="checkbox">
							<label class="checkbox-wrapper">
								<input type="checkbox" id="data_hum" class="datachkbx" name="dataanalyze" value="human" onclick="getChkbxVal(this)" />
								<span class="checkbox-tile">
									<span class="checkbox-icon">
										<svg viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--noto" preserveAspectRatio="xMidYMid meet" fill="#000000"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M67.17 13.34c-2.51-4.06-8.2-7.22-12.91-6.44c-5.28.87-8.11 4.67-8.86 9.49c-.27 1.75-.22 3.49.08 4.72c.04.15.33 1.22.35 1.56c.2 1.3-2.32 2.59-2.61 4.02c-.22 1.08 2.03 1.77 2.21 1.96c.88.97-.51 5.58 5.66 6.04c2.37.18 1.91.03 2.61.3c1.09.42.99 3.32.99 3.32s.61 4.78 4.69 3.51c4.66-1.44 4.84-4.74 4.84-4.74s-1.73-4.6 1.05-9.38c2.21-3.82 3.52-11.75 1.9-14.36z" fill="#f9ddbd"> </path> <path d="M46.05 31.23c.86.05 1.7-.15 2.43-.69c.79-.59.25-1.24-.66-.86c-.55.23-1.32.35-2.02.22l.25 1.33z" fill="#444"> </path> <ellipse transform="rotate(-1.812 49.645 23.394)" cx="49.65" cy="23.39" rx="1.13" ry="1.74" fill="#312d2d"> </ellipse> <path d="M48.77 20.82c-1.12.26-1.34-.48-.94-1.04c.29-.42.98-.74 2.25-.42c1.2.3 1.66 1.03 1.97 1.47s.24.86-.04.89c-.38.02-1.86-1.22-3.24-.9z" fill="#454140"> </path> <path d="M85.26 108.68L71.19 92.63c-.88-1-1.4-2.26-1.48-3.59l-1.38-22.46l-15.5 1.71l4.88 23.17c.79 3.75 2.9 7.09 5.94 9.42l16.49 12.6l5.12-4.8z" fill="#eff0ea"> </path> <path d="M68.15 62.88l-17.58 1.61l-4.53 20.39c-.83 3.76-1.12 7.63-.85 11.47l1.63 23.24h6.67l2.95-25.03s5.01-13.32 5.17-13.4c4.07-1.93 7.59-4.92 7.41-9.83c-.09-2.82-.55-5.66-.87-8.45z" fill="#eff0ea"> </path> <linearGradient id="IconifyId17ecdb2904d178eab19193" gradientUnits="userSpaceOnUse" x1="51.872" y1="77.64" x2="69.122" y2="65.64" gradientTransform="matrix(1 0 0 -1 0 128)"> <stop offset="0" stop-color="#f78c1f"> </stop> <stop offset=".482" stop-color="#f47f12"> </stop> <stop offset="1" stop-color="#ef6c00"> </stop> </linearGradient> <path d="M64.89 73.51h-11.9c-2.27 0-4.12-2.18-4.12-4.86l2.15-22.5c.44-4.11 2.53-8.09 4.63-9.59c1.97-1.41 4.82-1.64 4.82-1.64c1.53-.12 3.8.25 5.25 2.37c.87 1.27 1.52 3.75 1.66 5.88L69 68.65c0 2.69-1.84 4.86-4.11 4.86z" fill="url(#IconifyId17ecdb2904d178eab19193)"> </path> <linearGradient id="IconifyId17ecdb2904d178eab19194" gradientUnits="userSpaceOnUse" x1="59.199" y1="57.617" x2="56.005" y2="76.342" gradientTransform="matrix(1 0 0 -1 0 128)"> <stop offset=".461" stop-color="#f9ddbd"> </stop> <stop offset="1" stop-color="#ffd29c"> </stop> </linearGradient> <path d="M66.8 60.29l-2.25-13.83l-6.97 1.13l2.15 13.19l-3.57 9.84c-.23.45-3.46 1.91-3.66 2.01c-.62.3-1.05.89-1.37 2.06c-.19.72-.67 2.78.34 3.14c-.34.95-.12 2.14.14 2.42c.6.65 1.33.36 1.33.36s.1.83.76 1.06c.82.29 1.39-.16 1.39-.16c.29.22.64.34 1.01.34c.44 0 .83-.17 1.13-.39c.19.08.71.39 1.37-.08c.42-.3 1.74-2.03 2.15-3.14c.28-.76.24-4.58.59-5.25c.35-.67 5.14-10.2 5.14-10.2h-.01c.43-.79.53-1.68.33-2.5z" fill="url(#IconifyId17ecdb2904d178eab19194)"> </path> <linearGradient id="IconifyId17ecdb2904d178eab19195" gradientUnits="userSpaceOnUse" x1="53.334" y1="44.839" x2="55.581" y2="50.692" gradientTransform="matrix(1 0 0 -1 0 128)"> <stop offset=".456" stop-color="#f9ddbd"> </stop> <stop offset="1" stop-color="#ffd29c"> </stop> </linearGradient> <path d="M58.88 78.7c-.23-.6-.38-.64-.8-.53c-.57.15-1.19.13-1.54-.57c-.08-.17-.2-.23-.38-.17c-.61.2-1.37.21-1.63-.71c-.1-.34-.24-.38-.61-.38c-.12 0-.47.15-.83-.23c-.4-.43.14-1.29-.37-1.37c-.15-.02-.87.06-1.09-.71c-.14-.5.44-1.1.45-1.11c-.4.35-.71.9-.94 1.78c-.19.72-.67 2.78.34 3.14c-.34.95-.12 2.14.14 2.42c.6.65 1.33.36 1.33.36s.1.83.76 1.06c.82.29 1.39-.16 1.39-.16c.29.22.64.34 1.01.34c.44 0 .83-.17 1.13-.39c.19.08.71.39 1.37-.08c.35-.25 1.34-1.52 1.89-2.58c-.49.39-1.45.34-1.62-.11z" fill="url(#IconifyId17ecdb2904d178eab19195)"> </path> <path d="M54.6 123.98c.63 0 1.15-.51 1.15-1.15v-2.8c0-1.9-1.93-4.07-1.93-4.07h-6.98l-6.28 2.07c-1.52.6-2.53 2.06-2.54 3.69l-.01 1.26c0 .55.45 1 1 1H54.6z" fill="#494b50"> </path> <path d="M89.65 111.84c.45-.45.45-1.17 0-1.62l-1.98-1.98c-1.35-1.35-4.24-1.52-4.24-1.52l-4.93 4.93l-2.97 5.91c-.65 1.5-.33 3.24.82 4.41l.89.9c.39.39 1.03.39 1.42 0l10.99-11.03z" fill="#494b50"> </path> <path d="M58.37 79.39c.07.49-.06.86-.24 1.22c-.2.34-.44.65-.89.86c-.07-.49.06-.86.24-1.22c.19-.34.44-.65.89-.86z" fill="#edbd82"> </path> <path d="M56.35 78.48c.07.63-.07 1.19-.27 1.72c-.22.52-.48 1.03-.97 1.44c-.07-.64.07-1.19.27-1.72c.22-.51.49-1.02.97-1.44z" fill="#edbd82"> </path> <path d="M53.95 77.48c.12.62.02 1.18-.13 1.72c-.17.53-.4 1.05-.85 1.5c-.12-.62-.02-1.18.13-1.72c.18-.53.41-1.05.85-1.5z" fill="#edbd82"> </path> <path d="M53.8 73.88c-.31.27-.61.55-.86.85c-.27.3-.4.57-.49.96c-.23.74-.46 1.51-1 2.22c-.16-.87 0-1.69.33-2.47c.17-.38.5-.82.86-1.04c.37-.25.76-.42 1.16-.52z" fill="#edbd82"> </path> <g> <path d="M56.4 53l10.9-1.98l-1.76-9.69a5.538 5.538 0 0 0-6.44-4.46a5.538 5.538 0 0 0-4.46 6.44L56.4 53z" fill="#ed6d23"> </path> </g> <g> <path d="M70.66 13.53c-1.32-3.31-4-4.31-4.88-4.55c-.41-1.2-2.49-5.75-10-4.51c-1.83.3-3.17 1.17-4.35 1.94c-.5.33-.98.65-1.43.86c-.37.17-1.01.33-1.54.16c-1.21-.4-.83-2.24-.83-2.24s-4.44.88-2.53 5.17c-1.49.66-2.18 2.24-2.44 3.73c-.36 2.03.63 3.96 2.58 4.83c0 0-.39-3.26 4.32-3.07c1.46.06 2.99.29 4.34-.26c.52-.21 1-.54 1.5-.78h.18c1.78.95-.56 5.16 1.42 7.62c.39.49.72.31.72.31l.79-1.17c.6-.8 1.15-1.5 1.9-1.33c2.22.49 1.82 4.45-.81 5.32c-.26.09.35 4.5 5.8 4.5c2.82 0 3.81-2.34 3.81-2.34s-1.2.3-1.46-.72c-.14-.53.35-1.25 1.23-2.03c2.54-2.26 1.62-4.86 1.25-5.67c.4-.76 1.46-3.18.43-5.77z" fill="#312d2d"> </path> <radialGradient id="IconifyId17ecdb2904d178eab19196" cx="63.435" cy="103.503" r="7.122" gradientTransform="matrix(.9381 .3463 .4988 -1.351 -47.703 142.36)" gradientUnits="userSpaceOnUse"> <stop offset=".45" stop-color="#454140" stop-opacity="0"> </stop> <stop offset="1" stop-color="#454140"> </stop> </radialGradient> <path d="M70.24 19.29c.05-.09-.79 2.01-4.39 1.66c-1.48 0-3.54 3.57-1.38 5.93c1.92 2.08 4.75.83 4.75.83s-.39.11-.96-.08c-.37-.13-.5-.61-.5-.64c-.14-.53.35-1.25 1.23-2.03c2.54-2.27 1.62-4.86 1.25-5.67z" fill="url(#IconifyId17ecdb2904d178eab19196)"> </path> <radialGradient id="IconifyId17ecdb2904d178eab19197" cx="64.277" cy="110.685" r="7.219" gradientTransform="matrix(.9909 -.1344 -.1696 -1.2504 19.355 164.355)" gradientUnits="userSpaceOnUse"> <stop offset=".45" stop-color="#454140" stop-opacity="0"> </stop> <stop offset="1" stop-color="#454140"> </stop> </radialGradient> <path d="M70.66 13.53c-.69-1.74-1.96-3.21-3.64-4.06c-.24-.12-.84-.41-1.25-.49c.2.77.18 1.6-.15 2.45c-.01.03-.39 1.3-1.48 2.31c.79 1.1 1.19 2.43 1.57 3.74c.33 1.14.65 2.4.14 3.47c.69-.04 1.79.15 3-.39c1.16-.52 1.77-1.86 2.05-3.06c.31-1.31.26-2.7-.24-3.97z" fill="url(#IconifyId17ecdb2904d178eab19197)"> </path> <radialGradient id="IconifyId17ecdb2904d178eab19198" cx="56.224" cy="113.176" r="14.858" gradientTransform="matrix(.9882 -.1534 -.1153 -.7428 13.715 107.517)" gradientUnits="userSpaceOnUse"> <stop offset=".45" stop-color="#454140" stop-opacity="0"> </stop> <stop offset="1" stop-color="#454140"> </stop> </radialGradient> <path d="M65.61 11.44c.87-2.23-.36-4.29-2.21-5.66c-2.18-1.61-5.04-1.73-7.62-1.31c-1.83.3-3.17 1.17-4.35 1.94c-.51.33-.99.64-1.44.86c-.37.17-1.01.33-1.54.16c-1.21-.4-.83-2.24-.83-2.24s-4.44.88-2.53 5.17c-1.49.66-2.18 2.24-2.44 3.73c-.36 2.03.63 3.96 2.58 4.83c0 0-.39-3.26 4.32-3.07c1.46.06 2.99.29 4.34-.26c1.2-.48 1.6-1.13 2.95-1.06c1.45.08 3.38.63 4.87.4c3.01-.46 3.89-3.45 3.9-3.49z" fill="url(#IconifyId17ecdb2904d178eab19198)"> </path> <radialGradient id="IconifyId17ecdb2904d178eab19199" cx="65.076" cy="102.635" r="7.999" gradientTransform="matrix(.9692 .2463 .1583 -.6231 -14.242 73.291)" gradientUnits="userSpaceOnUse"> <stop offset=".45" stop-color="#454140" stop-opacity="0"> </stop> <stop offset="1" stop-color="#454140"> </stop> </radialGradient> <path d="M64.47 26.88c-.97-1.03-1.23-2.73-2.75-3.63c-.28.99-.99 1.92-2.12 2.3c-.26.09.35 4.5 5.8 4.5c2.82 0 3.81-2.34 3.81-2.34s-2.79 1.24-4.74-.83z" fill="url(#IconifyId17ecdb2904d178eab19199)"> </path> </g> </g></svg>
												<path d="M179.1333,108.32931a112.19069,112.19069,0,0,0-102.3584.04859" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="12"></path>
												<path d="M164.29541,136.71457a79.94058,79.94058,0,0,0-72.68359.04736" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="12"></path>
												<path d="M149.47217,165.07248a47.97816,47.97816,0,0,0-43.03662.04736" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="12"></path>
											</g>
										</svg>
									</span>
									<span class="checkbox-label"><label for="data_hum">사람</label></span>
								</span>
							</label>
						</div>
					</fieldset>
					<div>
					</div>
               <div class="row">
                  <div class="col-xl-6">
                     <div class="card mb-4">
                        <div class="card-header">
                           <i class="fas fa-chart-area me-1"></i> 시간대별 차트
                        </div>
                        <div class="card-body">
                           <canvas id="myAreaChart" width="100%" height="40"></canvas>
                        </div>
                     </div>
                  </div>
                  <div class="col-xl-6">
                     <div class="card mb-4">
                        <div class="card-header">
                           <i class="fas fa-chart-bar me-1"></i> 월별 차트
                        </div>
                        <div class="card-body">
                           <canvas id="myBarChart" width="100%" height="40"></canvas>
                        </div>
                     </div>
                  </div>
               </div>



            </div>

            <div class="myinfo" id="page4-content" style="display: none;" value="마이페이지">
               
               <div class="containerbody">
            <div class=middle>
               <form method=post action="updateinfoSuccess.com">
                  <br>
                  <h2>내 정보 수정</h2>
                  <table>
                     <tr>
                        <th>ID</th>
                        <td>
                        <span id=id>
                        <c:choose>
                           <c:when test="${result ne null}">
                              ${result.u_id}
                           </c:when>
                        </c:choose>
                        </span>
                        </td>
                     </tr>
                     <tr>
                        <th>PW</th>
                        <td><input type=password name=pw id=pw disabled
                           placeholder="필수 입력 사항입니다." value="2">
                           <input type=button id=pw_button value="변경"
                           onclick="change_pw();"></td>
                        <input type=hidden name="user_pw" id=pw2
                           value="3">
                     </tr>
                     <tr>
                        <th>E-mail</th>
                        <td><input type=text name=name id=name disabled
                           placeholder="필수 입력 사항입니다." value="4">
                           <input type=button id=name_button value="변경"
                           onclick="change_name();"></td>
                        <input type=hidden name="user_name" id=name2
                           value="5">
                     </tr>
                     <tr>
                        <th>농장주소</th>
                        <td><input type="text" name=phone id=phone disabled
                           value="6"> <input type=button
                           id=phone_button value="변경" onclick="change_phone();"></td>
                        <input type=hidden name="user_phone" id=phone2
                           value="7">
                     </tr>
                     <tr>
                        <th>자동차 등록</th>
                        <td><input type="text" name=intro id=intro disabled
                           value="8"> <input
                           type=button id=intro_button value="변경"
                           onclick="change_intro();"></td>
                        <input type=hidden name="user_v_account" id=intro2
                           value="9">
                     </tr>
                  </table>
                  <input disabled id=submit type="submit" value="변경사항 확정하기">
               </form>
            </div>
         </div>
               
            </div>


         </main>
      </div>

      <div class="foot">
         <footer>
            <div class="footerContainer">
               <div class="socialIcons">
                  <a href=""><img class="fa-brands fa-facebook" src="resources/images/youtube_icon.png"></img></a>
                  <a href=""><img class="fa-brands fa-instagram" src="resources/images/blogger_icon.png"></img></a>
                  <a href=""><img class="fa-brands fa-twitter" src="resources/images/instagram_icon.png"></img></a>
                  <a href=""><img class="fa-brands fa-youtube" src="resources/images/github_icon.png"></img></a>
               </div>
            </div>
         </footer>
      </div>
   </div>


   <!-- 모달 -->
   <div class="modal-bg" id="modal-bg">
      <div class="modal" id="modal">
         <div class="modal-content">
            <!-- 모달 내용 추가 -->
            <h2>알림</h2>
            <div id="modr" style="display: block;">침입 내역이 없습니다.</div>
            <div id="webAlarm_content"></div>
            <button type="button" class="modal-close-btn" id="modal-close-btn">&times;</button>
         </div>
      </div>
   </div>



   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"></script>
   <script src="resources/BT_js/scripts.js"></script>
   <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
      crossorigin="anonymous"></script>
   <script src="resources/BT_assets/demo/chart-area-demo.js"></script>
   <script src="resources/BT_assets/demo/chart-bar-demo.js"></script>
   <script
      src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
      crossorigin="anonymous"></script>
   <script src="resources/BT_js/datatables-simple-demo.js"></script>

   <script type="text/javascript">
      var data = '${result.u_id}';
   </script>
   <script type="text/javascript" src="resources/JS/main.js"></script>
   <script type="text/javascript" src="resources/JS/account.js"></script>
   <script type="text/javascript" src="resources/JS/chat.js"></script>
   <script type="text/javascript" src="resources/JS/webCam.js"></script>
   <script src="resources/JS/cctv.js"></script>
   <script src="resources/JS/entryLog.js"></script>
   <script type="text/javascript" src="resources/JS/entryLog.js"></script>
   <script type="text/javascript" src="resources/JS/webAlarm.js"></script>
   <script>
   var calendarEl = $('#calendar')[0];
    var calendar = new FullCalendar.Calendar(calendarEl, {
       // contentHeight: 600,
        height: '500px', // calendar 높이 설정
       // 너비가 높이의 두 배
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
        // 해더에 표시할 툴바
        headerToolbar: {
            //left: 'prev,next today',
            left: '',
            center: 'title',
            right:'prev,next today'
            //right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
 //       initialDate: '2023-05-11', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
        navLinks: false, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        editable: true, // 수정 가능?
        selectable: true, // 달력 일자 드래그 설정가능
        nowIndicator: true, // 현재 시간 마크
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정
        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
            console.log(obj);
        },
        
        // 달력에 DB 데이터 연동
       events: function(info, successCallback, failureCallback){
         
           $.ajax({
              url:'calendarDB.com',
              type: 'get',
              dataType: 'json',
              contentType: "application/json;charset=UTF-8",
              data: {'u_id':data},
              success: function(res){
                 /*console.log(res);
                 console.log((res.sac[0].car_num));*/
                 /*console.log(res.sac[0].sac_in_at);
                 console.log(typeof(res.sac[0].sac_in_at));
                 console.log((res.sac[0].sac_in_at).substring(0,10));*/
                
                 var events = [];
                 for(var i = 0; i < (res.sac).length; i++){
                    /*res.sac[i].sac_in_at = (res.sac[i].sac_in_at).substring(0,10);*/
                    
                    events.push({
                       title : '차량침입 '+(res.sac[i].sac_in_at).substring(11,),
                       start : (res.sac[i].sac_in_at).substring(0,10),
                       end : (res.sac[i].sac_in_at).substring(0,10),
                       color : "#FF0000"
                    })
                 }
                 
                 for(var i = 0; i < (res.sah).length; i++) {
                    /*res.sah[i].sah_in_at = (res.sah[i].sah_in_at).substring(0,10);*/
                    
                    events.push({
                       title : '사람침입 '+(res.sah[i].sah_in_at).substring(11, ),
                       start : (res.sah[i].sah_in_at).substring(0,10),
                       end : (res.sah[i].sah_in_at).substring(0,10),
                       color : "#FFFF00",
                       textColor : 'black'
                    })
                 }
                 /*console.log(events);*/
                 successCallback(events);
                 
              },
              error: function(e){
                 alert("요청 실패");
              }
           })
        },
        
        // 날짜 클릭 시 리스트 출력
        eventClick: function(date, calEvent, jsEvent, view){
           /*console.log(date);*/
           /*console.log(date.event._instance.range.start);*/
           /*const today = date.event._instance.range.start;*/
           /*console.log(today.toISOString().slice(0, 10));*/
           
           $.ajax({
              url:'calendarDB.com',
                 type: 'get',
                 dataType: 'json',
                 contentType: "application/json; charset=UTF-8",
                 data: {'u_id':data},
                 success: function(res){
                    /*console.log(res);
                    console.log(res.sac[0].sac_img_link);*/
                    const today = date.event._instance.range.start.toISOString().slice(0, 10);
                    /*console.log(today);
                    console.log(res.sac[0].sac_in_at.substring(0,10));*/
                    
                    for(var i = 0; i < res.sac.length; i++){
                       if(res.sac[i].sac_in_at.substring(0,10) == today){
                          $('#nows').append(`
                       		  <div class="epqlftkdcn">
                          		<div class="epqlf">
                                <div><img src="showImage.com?fileName=\${res.sac[i].sac_img_link}" width="230px" height="150px"></div>
                                <div class="tkdcn">
                                <div>차량침입</div>
                                <div>차량번호 : \${res.sac[i].car_num}</div>
                                <div>침입시간 : \${res.sac[i].sac_in_at}</div>
                                </div>
                                </div>
                               </div>
                                `);
                       }
                    }
                    
                    for(var i = 0; i< res.sah.length; i++){
                       if(res.sah[i].sah_in_at.substring(0,10) == today){
                          $('#nows').append(`
                      		  <div class="epqlftkdcn">
                       			<div class="epqlf">
                                <div><img src="showImage.com?fileName=\${res.sah[i].sah_img_link}" width="230px" height="150px"></div>
                                <div class="tkdcn">
                                <div>사람침입</div>
                                <div>\${res.sah[i].sah_in_count}명 침입</div>
                                <div>침입시간 : \${res.sah[i].sah_in_at}</div>
                                </div>
                                </div>
                               </div>
                                `);
                       }
                    }
                    
                    $('#page2-content').append(`
                            <button id="epqlfBtn" onclick="$('.epqlf').hide();"style="width: 30px; height: 30px; position: fixed; border-radius: 8px; right: 50rem; bottom: 13rem; opacity: 0.5;border: solid 0.5px #e9e9e9;box-shadow: inset 0px 0px 4px 2px #c4c3c3b0;background-color: #fff;}">X</button>
                            `);
                    $('#epqlfBtn').click(function(){
                       $('#epqlfBtn').remove();
                    })
                 }
           })
        },
        
       /*dateClick: function(res){
          console.logr(res));
       }*/
        
    });
    
    calendar.render();
   </script>

</body>
</html>