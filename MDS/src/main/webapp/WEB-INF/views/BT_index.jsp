<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="resources/BT_css/styles.css" rel="stylesheet" /><script src="https://code.jquery.com/jquery-3.1.0.js"></script>
		<link href="resources/images/cam.png" rel="shortcut icon"
			type="image/png">
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
			<div class="logo_img">
				<a class="logo" href="javascript:listView('${result.u_id}')"> 
					<img alt="MDS로고" src="resources/images/MDS_logo.png" width="180px" height="60px">
				</a>
			</div>
			<div class="header">
				<div>알림</div>
				<a href="logout.com">로그아웃</a>
			</div>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">CCTV</div>
	                        <div class="nav-link" id="radio-1">
	                           <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
	                            실시간 영상
	                        </div>
                            <div class="sb-sidenav-menu-heading">데이터</div>
                            <div id="radio-2" class="nav-link collapsed" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                데이터 조회
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </div>
                            <div id="radio-3" class="nav-link collapsed" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                데이터 분석
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </div>
                            <div class="sb-sidenav-menu-heading">정보수정</div>
                            <div id="radio-4" class="nav-link" href="tables.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
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
            
            <div id="">
            
            
            </div>
            
            <div id="layoutSidenav_content">
                <main>
                	<div class="videoPlayer" id="page1-content">
						<c:choose>
							<c:when test="${result.u_id eq list.u_id && result ne null}">
								<video autoplay="true" id="videoElement"></video>
								<canvas class="canvas" id="mirrored"></canvas>
							</c:when>
						</c:choose>
					</div>
                	
                	<div class="calendar_page" id="page2-content" style="display: none;" value="데이터조회">

						<div id="calendar">
							<div id="calendar_header">
								<i class="icon-chevron-left"></i>
								<h1></h1>
								<i class="icon-chevron-right"></i>
							</div>
							<div id="calendar_weekdays"></div>
							<div id="calendar_content"></div>
						</div>
			
					</div>
			
					<div id="date_content" style="display: none;">
						<h1>이거나오나</h1>
						
					
					</div>
					
			
					
			
					<div class="" id="page3-content" style="display: none;" value="데이터분석">
					
						<div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                        Area Chart Example
                                    </div>
                                    <div class="card-body"><canvas id="myAreaChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        Bar Chart Example
                                    </div>
                                    <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                        </div>
					
					
					
					</div>
			
					<div class="" id="page4-content" style="display: none;" value="마이페이지">
					
						마이페이지
					
					
					
					</div>
					
					
	                </main>
				</div>
                
                
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2023</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
            
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="resources/BT_js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="resources/BT_assets/demo/chart-area-demo.js"></script>
        <script src="resources/BT_assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
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
    </body>
</html>
