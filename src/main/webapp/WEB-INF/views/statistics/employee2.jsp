<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>

<meta charset="UTF-8">
<title>통계</title>
</head>
<body>
<div class="col-12">
              <h2 class="h5 page-title">Chartjs</h2>
              <p class="text-muted">Simple yet flexible JavaScript charting for designers &amp; developers</p>
              <button type="button" class="btn mb-2 btn-secondary">단위 : 월</button>
              <button type="button" class="btn mb-2 btn-secondary">단위 : 년</button>
              <p>
              <hr>              
              <button id="buttonOne" type="button" class="btn mb-2 btn-primary">직원관리</button>
              <button id="buttonTwo" type="button" class="btn mb-2 btn-secondary">채용관리</button>
              <button id="buttonThr" type="button" class="btn mb-2 btn-secondary">비용관리</button>
               </p>
              <div class="row"> <!--  첫번째줄 시작 -->
              	<!-- 첫번째 시작 -->
              	<div id="chart" class="col-md-6 mb-4">
                  <div class="card shadow">
                    <div class="card-header">
                      <strong class="card-title mb-0">Bar Chart</strong>
                      <div class="dropdown float-right">
                        <button class="btn btn-sm btn-link text-muted dropdown-toggle p-0" type="button" id="rangeDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 7 days </button>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="rangeDropdown">
                          <a class="dropdown-item small text-muted" href="#">30 days</a>
                          <a class="dropdown-item small active" href="#">90 days</a>
                          <a class="dropdown-item small text-muted" href="#">All</a>
                        </div>
                      </div>
                    </div>
                    <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                      <canvas id="barChartjs" width="557" height="269" style="display: block; height: 300px; width: 620px;" class="chartjs-render-monitor"></canvas>
                    </div> <!-- /.card-body -->
                  </div> <!-- /.card -->
                </div>
              	<!-- 첫번째 끝 -->
              	<!-- 두번째 시작 -->
              	                <div class="col-md-6 mb-4">
                  <div class="card shadow">
                    <div class="card-header">
                      <strong class="card-title mb-0">Line Chart</strong>
                      <span class="badge badge-light float-right mr-2">30 days</span>
                      <span class="badge badge-light float-right mr-2">7 days</span>
                      <span class="badge badge-secondary float-right mr-2">Today</span>
                    </div>
                    <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                      <canvas id="lineChartjs" width="315" height="300" style="display: block; width: 315px; height: 300px;" class="chartjs-render-monitor"></canvas>
                    </div> <!-- /.card-body -->
                  </div> <!-- /.card -->
                </div> <!-- /. col -->
              	<!-- 두번째 끝 -->

              </div> <!-- 첫번재 줄 끝 -->
				<!-- 세번째 시작  -->
				<!-- 세번째 끝  -->
              <div class="row my-4">
                <div class="col-md-6 mb-4">
                  <div class="card shadow">
                    <div class="card-header">
                      <strong class="card-title mb-0">Pie Chart</strong>
                    </div>
                    <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                      <canvas id="pieChartjs" width="315" height="300" style="display: block; width: 315px; height: 300px;" class="chartjs-render-monitor"></canvas>
                    </div> <!-- /.card-body -->
                  </div> <!-- /.card -->
                </div> <!-- /. col -->
                <div class="col-md-6 mb-4">
                  <div class="card shadow">
                    <div class="card-header">
                      <strong class="card-title mb-0">Area Chart</strong>
                    </div>
                    <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                      <canvas id="areaChartjs" width="315" height="300" style="display: block; width: 315px; height: 300px;" class="chartjs-render-monitor"></canvas>
                    </div> <!-- /.card-body -->
                  </div> <!-- /.card -->
                </div> <!-- /. col -->
              </div> <!-- end section -->
            </div>
            <script type="text/javascript">
            $("#buttonOne").on("click", function () {
                document.getElementById("buttonOne").className = "btn mb-2 btn-primary";
                document.getElementById("buttonTwo").className = "btn mb-2 btn-secondary";
                document.getElementById("buttonThr").className = "btn mb-2 btn-secondary";
                $.ajax({
                    type: "get",
                    url: "/statistics/employee",
                    data: "",
                    error: function (error) {
                        alert("Error!");
                    },
                    success: function (result) {
                        // 기존 차트를 삭제
                        $("#chart").empty();

                        // 차트를 다시 생성
                        var cont = `
                            <div class="card shadow">
                                <div class="card-header">
                                    <strong class="card-title mb-0">Bar Chart</strong>
                                    <div class="dropdown float-right">
                                        <button class="btn btn-sm btn-link text-muted dropdown-toggle p-0" type="button" id="rangeDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 7 days </button>
                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="rangeDropdown">
                                            <a class="dropdown-item small text-muted" href="#">30 days</a>
                                            <a class="dropdown-item small active" href="#">90 days</a>
                                            <a class="dropdown-item small text-muted" href="#">All</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="chartjs-size-monitor">
                                        <div class="chartjs-size-monitor-expand"><div class=""></div></div>
                                        <div class="chartjs-size-monitor-shrink"><div class=""></div></div>
                                    </div>
                                    <canvas id="barChartjs" width="557" height="269" style="display: block; height: 300px; width: 620px;" class="chartjs-render-monitor"></canvas>
                                </div> <!-- /.card-body -->
                            </div>`;
                              
                        $("#chart").html(cont);
                        // 이후에 차트 데이터를 업데이트하는 로직을 추가하면 됩니다.
                         ChartData = {
        labels: ["Jan12", "Feb2", "Mar3", "Apr4", "May", "Jun", "Jul", "Aug", "Sep"],
        datasets: [{
            label: "Visitors",
            barThickness: 10,
            backgroundColor: base.primaryColor,
            borderColor: base.primaryColor,
            pointRadius: !1,
            pointColor: "#3b8bba",
            pointStrokeColor: "rgba(60,141,188,1)",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(60,141,188,1)",
            data: [28, 48, 40, 19, 64, 27, 90, 85, 92],
            fill: "",
            lineTension: .1
        }, {
            label: "Orders",
            barThickness: 10,
            backgroundColor: "rgba(210, 214, 222, 1)",
            borderColor: "rgba(210, 214, 222, 1)",
            pointRadius: !1,
            pointColor: "rgba(210, 214, 222, 1)",
            pointStrokeColor: "#c1c7d1",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [65, 59, 80, 42, 43, 55, 40, 36, 68],
            fill: "",
            borderWidth: 2,
            lineTension: .1
        },
        {
            label: "ggg",
            barThickness: 10,
            backgroundColor: "rgba(210, 214, 222, 1)", //그래프 배경
            borderColor: "rgba(111, 111, 111, 1)",  //테투리
            pointRadius: !1,
            pointColor: "rgba(210, 214, 222, 1)",
            pointStrokeColor: "#d1d7d1",
            pointHighlightFill: "#ffd",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [65, 59, 80, 42, 43, 55, 40, 36, 68],
            fill: "",
            borderWidth: 2,
            lineTension: .1
        }]
    },
    lineChartData = {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"],
        datasets: [{
            label: "Visitors",
            barThickness: 10,
            borderColor: base.primaryColor,
            pointRadius: !1,
            pointColor: "#3b8bba",
            pointStrokeColor: "rgba(60,141,188,1)",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(60,141,188,1)",
            data: [28, 48, 30, 19, 64, 27, 90, 85, 92],
            fill: "",
            lineTension: .2
        }, {
            label: "Sales",
            barThickness: 10,
            borderColor: "rgba(40, 167, 69, 0.8)",
            pointRadius: !1,
            pointColor: "#3b8bba",
            pointStrokeColor: "rgba(60,141,188,1)",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(60,141,188,1)",
            data: [8, 18, 20, 29, 26, 7, 30, 25, 48],
            fill: "",
            borderWidth: 2,
            lineTension: .2
        }, {
            label: "Orders",
            backgroundColor: "rgba(210, 214, 222, 1)",
            borderColor: "rgba(210, 214, 222, 1)",
            pointRadius: !1,
            pointColor: "rgba(210, 214, 222, 1)",
            pointStrokeColor: "#c1c7d1",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [65, 59, 80, 42, 43, 55, 40, 36, 68],
            fill: "",
            borderWidth: 2,
            lineTension: .2
        }]
    },
    pieChartData = {
        labels: ["Clothing", "Shoes", "Electronics", "Books", "Cosmetics"],
        datasets: [{
            data: [18, 30, 42, 12, 7],
            backgroundColor: chartColors,
            borderColor: colors.borderColor
        }]
    },
    areaChartData = {
        labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        datasets: [{
            label: "Visitors",
            barThickness: 10,
            backgroundColor: base.primaryColor,
            borderColor: base.primaryColor,
            pointRadius: !1,
            pointColor: "#3b8bba",
            pointStrokeColor: "rgba(60,141,188,1)",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(60,141,188,1)",
            data: [19, 64, 37, 76, 68, 88, 54, 46, 58],
            lineTension: .1
        }, {
            label: "Orders",
            barThickness: 10,
            backgroundColor: "rgba(210, 214, 222, 1)",
            borderColor: "rgba(255, 255, 255, 1)",
            pointRadius: !1,
            pointColor: "rgba(210, 214, 222, 1)",
            pointStrokeColor: "#c1c7d1",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [42, 43, 55, 40, 36, 68, 22, 66, 49],
            lineTension: .1
        }]
    }
                        barChartjs = document.getElementById("barChartjs");
                        barChartjs && new Chart(barChartjs, {
                            type: "bar",
                            data: ChartData,
                            options: ChartOptions
                        });
                    }
                });
            })
            	$("#buttonTwo").on("click", function(){
            		document.getElementById("buttonOne").className="btn mb-2 btn-secondary";
            		document.getElementById("buttonTwo").className="btn mb-2 btn-primary";
            		document.getElementById("buttonThr").className="btn mb-2 btn-secondary";
            		$.ajax({
            			type : "get",
            			url : "/statistics/employee",
            			data : "",
                        error: function (error) {
                            alert("Error!");
                        },
                        success: function (result) {
                        	var cont = "";
                            console.log("성공!!");
							cont +='<div id="chart" class="col-md-6 mb-4">';
							cont +='뀨웅';
							cont +='</div>';
							;
		                  
		                  $("#chart").html(cont);
                        }
            			
            		})
            	})
            	$("#buttonThr").on("click", function(){
            		document.getElementById("buttonOne").className="btn mb-2 btn-secondary";
            		document.getElementById("buttonTwo").className="btn mb-2 btn-secondary";
            		document.getElementById("buttonThr").className="btn mb-2 btn-primary";
            		$.ajax({
            			type : "get",
            			url : "/statistics/employee",
            			data : "",
                        error: function (error) {
                            alert("Error!");
                        },
                        success: function (result) {
                            console.log("dd2");
                            updateBarChart(result);
                        }
            			
            		})
            	})
            	
            	    function updateBarChart(data) {
        // data를 사용하여 차트 업데이트 로직을 작성
        // 예시: 데이터를 받아서 차트 업데이트
        var ctx = document.getElementById('barChartjs').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Label 1', 'Label 2', 'Label 3'], // x축 레이블
                datasets: [{
                    label: 'Bar Chart',
                    data: [10, 20, 30], // 실제 데이터
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

            
            	
            </script>
    <script src="/resources/light/js/tinycolor-min.js"></script>
    <script src="/resources/light/js/config.js"></script>
    <script src="/resources/light/js/Chart.min.js"></script>
	<script src="/resources/js/chartData.js"></script>

</html>