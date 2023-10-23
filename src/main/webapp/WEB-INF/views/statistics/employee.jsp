<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>

<meta charset="UTF-8">

<style type="text/css">
	#one, #two{
		display: inline-block;
		float: right;
	}
	#two{
		display: none;
	}
</style>
<title>통계</title>
<script type="text/javascript">
// function chkOne(){
// 	console.log("개똥이1");
// 	$("#one").css("display","inline-block");
// 	console.log("개똥이2");
// }

// function chkOneLeave(){
// 	console.log("개똥이11");
// 	$("#one").css("display","none");
// 	console.log("개똥이21");
// }

// function chkTwo(){
// 	console.log("개똥이3");
// 	$("#two").css("display","inline-block");
// 	console.log("개똥이4");
// }

// function chkTwoLeave(){
// 	console.log("개똥이31");
// 	$("#two").css("display","none");
// 	console.log("개똥이41");
// }

$(document).on("click", "#buttonOne", function(){
	console.log("맞아?")
	$("#two").css("display","none");
	$("#one").css("display","inline-block");
})
$(document).on("click", "#buttonTwo", function(){
	console.log("힝?;")
	$("#one").css("display","none");
	$("#two").css("display","inline-block");
})
</script>
</head>
<body>
<div class="col-12">
              <h1 class="h1 page-title" style="padding-top: 30px;">인사이트</h1><br>

              <p style="display: inline-block;">
              <button id="buttonOne" type="button" class="btn mb-2 btn-primary" >직원관리</button>
              <button id="buttonTwo" type="button" class="btn mb-2 btn-secondary">채용관리</button>
               </p>
              
			  <div id="one">             
              <button type="button" id="quatersOne" class="btn mb-2 btn-primary">단위 : 분기</button>
              <button type="button" id="yearsOne" class="btn mb-2 btn-secondary">단위 : 년</button>
              </div>
              
             <div id="two">
              <button type="button" id="quatersTwo" class="btn mb-2 btn-primary">단위 : 분기</button>
              <button type="button" id="yearsTwo" class="btn mb-2 btn-secondary">단위 : 년</button>
             </div>
            
            
              <div class="row"> <!--  첫번째줄 시작 -->
              	<!-- 첫번째 시작 -->
              	<div id="chart" class="col-md-6 mb-4">
                  <div class="card shadow">
                    <div class="card-header">
                      <strong class="card-title mb-0">현재 남여 수</strong>

                    </div>
                    <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                      <canvas id="Chart1" width="557" height="269" style="display: block; height: 300px; width: 620px;" class="chartjs-render-monitor"></canvas>
                    </div> <!-- /.card-body -->
                  </div> <!-- /.card -->
                </div>
              	<!-- 첫번째 끝 -->
              	<!-- 두번째 시작 -->
              	  <div id="chart2" class="col-md-6 mb-4">
                  <div class="card shadow">
                    <div class="card-header">
                      <strong class="card-title mb-0">직급별 평균 근무 시간</strong>

                    </div>
                    <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                      <canvas id="Chart2" width="315" height="300" style="display: block; width: 315px; height: 300px;" class="chartjs-render-monitor"></canvas>
                    </div> <!-- /.card-body -->
                  </div> <!-- /.card -->
                </div> <!-- /. col -->
              	<!-- 두번째 끝 -->
              </div> <!-- 첫번재 줄 끝 -->
              
				<!-- 세번째 시작  -->			 
              <div class="row my-4"> <!-- 2번째줄 -->
                <div id="chart3" class="col-md-6 mb-4">
                  <div class="card shadow">
                    <div class="card-header">
                      <strong class="card-title mb-0">평균 출근 시간</strong>
                    </div>
                    <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                      <canvas id="Chart3" width="315" height="300" style="display: block; width: 315px; height: 300px;" class="chartjs-render-monitor"></canvas>
                    </div> <!-- /.card-body -->
                  </div> <!-- /.card -->
                </div> <!-- /. col -->
                <!-- 세번째 끝  -->	
                <div id="chart4" class="col-md-6 mb-4">
                  <div class="card shadow">
                    <div class="card-header">
                      <strong class="card-title mb-0">평균 퇴근 시간</strong>
                    </div>
                    <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                      <canvas id="Chart4" width="315" height="300" style="display: block; width: 315px; height: 300px;" class="chartjs-render-monitor"></canvas>
                    </div> <!-- /.card-body -->
                  </div> <!-- /.card -->
                </div> <!-- 차트-->
              </div> <!-- 두번쨰줄 -->
              
              
            <div class="row my-4"> <!--  세번째줄 시작 -->
              	<!-- 다섯번째 시작 -->
              	<div id="chart5" class="col-md-6 mb-4">
                  <div class="card shadow">
                    <div class="card-header">
                      <strong class="card-title mb-0">평균 급여</strong>

                    </div>
                    <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                      <canvas id="Chart5" width="557" height="269" style="display: block; height: 300px; width: 620px;" class="chartjs-render-monitor"></canvas>
                    </div> <!-- /.card-body -->
                  </div> <!-- /.card -->
                </div>
              	<!-- 다섯번째 끝 -->
              	<!-- 여섯번째 시작 -->
              	  <div id="chart6" class="col-md-6 mb-4">
                  <div class="card shadow">
                    <div class="card-header">
                      <strong class="card-title mb-0">여섯번째 차트</strong>
                    </div>
                    <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                      <canvas id="Chart6" width="315" height="300" style="display: block; width: 315px; height: 300px;" class="chartjs-render-monitor"></canvas>
                    </div> <!-- /.card-body -->
                  </div> <!-- /.card -->
                </div> <!-- /. col -->
              	<!-- 여섯번째 끝 -->
              </div> <!-- 세번재 줄 끝 -->
              
            </div>  <allchart>
            
            

           
<script type="text/javascript">

var chartTitle = "바꾸고싶어!@!@";
$(function(){
	var ChartOptions = {
		    maintainAspectRatio: !1,
		    responsive: !0,
		    legend: {
		        display: !1
		    },
		    scales: {
		        xAxes: [{
		            gridLines: {
		                display: !1
		            },
		            ticks: {
		                padding: 10 // x축 양쪽 끝에 10의 패딩 추가
		            },
		            layout: {
		                padding: {
		                    left: 10,    // x 축 왼쪽 여백 설정
		                    right: 10,   // x 축 오른쪽 여백 설정
		                }
		            }
		        }],
		        yAxes: [{
		            gridLines: {
		                display: !1,
		                color: colors.borderColor,
		                zeroLineColor: colors.borderColor
		            }
		        ,
		            ticks: {
		            	padding: 10,
		            	
		            }

		        }]
		    }
		};
	
//	ChartOptions.scales.yAxes[0].ticks= {
//  min: 0,       // 최소값 설정
//  max: 10,      // 최대값 설정
//  stepSize: 2   // 눈금 간격 설정
//}
	var mfColors = ["#ADC8FF" ,"#FDBAA8"]; 
	var chartColors = ["#CAF67C","#8CE2FD","#FFE08B","#61f2c4","#ECD5E3","#ff83ce"]; // 사원 주임 대리 색상
	chartTitle = "바꾸고싶어!@!@";
	
	var cont = `
        <div class="card shadow">
            <div class="card-header">
                <strong class="card-title mb-0">\${chartTitle}</strong>
            </div>
            <div class="card-body">
                <div class="chartjs-size-monitor">
                    <div class="chartjs-size-monitor-expand"><div class=""></div></div>
                    <div class="chartjs-size-monitor-shrink"><div class=""></div></div>
                </div>
                <canvas id="Chart1" width="557" height="269" style="display: block; height: 300px; width: 620px;" class="chartjs-render-monitor"></canvas>
            </div> <!-- /.card-body -->
        </div>`;
        
    	var cont2 = `
          <div class="card shadow">
            <div class="card-header">
              <strong class="card-title mb-0">\${chartTitle}</strong>
            </div>
            <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
              <canvas id="Chart2" width="315" height="300" style="display: block; width: 315px; height: 300px;" class="chartjs-render-monitor"></canvas>
            </div> <!-- /.card-body -->
          </div>`;
      
      var cont3 = `
          <div class="card shadow">
            <div class="card-header">
              <strong class="card-title mb-0">\${chartTitle}</strong>
            </div>
            <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
              <canvas id="Chart3" width="315" height="300" style="display: block; width: 315px; height: 300px;" class="chartjs-render-monitor"></canvas>
            </div> <!-- /.card-body -->
          </div> <!-- /.card -->
      `;
      
    var cont4 = `
        <div class="card shadow">
            <div class="card-header">
                <strong class="card-title mb-0">\${chartTitle}</strong>
            </div>
            <div class="card-body">
                <div class="chartjs-size-monitor">
                    <div class="chartjs-size-monitor-expand"><div class=""></div></div>
                    <div class="chartjs-size-monitor-shrink"><div class=""></div></div>
                </div>
                <canvas id="Chart4" width="557" height="269" style="display: block; height: 300px; width: 620px;" class="chartjs-render-monitor"></canvas>
            </div>`;
       
        
    	var cont5 = `
          <div class="card shadow">
            <div class="card-header">
              <strong class="card-title mb-0">\${chartTitle}</strong>
            </div>
            <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
              <canvas id="Chart5" width="315" height="300" style="display: block; width: 315px; height: 300px;" class="chartjs-render-monitor"></canvas>
            </div> <!-- /.card-body -->
          </div> <!-- /.card -->`;
      
      var cont6 = `
          <div class="card shadow">
            <div class="card-header">
              <strong class="card-title mb-0">\${chartTitle}</strong>
            </div>
            <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
              <canvas id="Chart6" width="315" height="300" style="display: block; width: 315px; height: 300px;" class="chartjs-render-monitor"></canvas>
            </div> <!-- /.card-body -->
          </div> <!-- /.card -->
      `;
	
 	

 	quaterNo1();
 	
 	function quaterNo1(){
    	  $("#chart").empty();    	 $("#chart2").empty();    	  $("#chart3").empty();    	  $("#chart4").empty();    	  $("#chart5").empty();    	$("#chart6").empty();  
    	  $("#chart").html(cont);     $("#chart2").html(cont2);   $("#chart3").html(cont3);  $("#chart4").html(cont4);  $("#chart5").html(cont5);   $("#chart6").html(cont6);
 	    	  $(".card-title").eq(0).html("현재 남여 수");
 	    	  $(".card-title").eq(1).html("직급별 평균 근무시간");
 	    	  $(".card-title").eq(2).html("평균 출근시간");
 	    	  $(".card-title").eq(3).html("평균 퇴근시간");
 	    	  $(".card-title").eq(4).html("직급별 평균 연봉");
 	    	  $(".card-title").eq(5).html("분기별 지출 경비");

 		
 	//첫번째 
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/MF",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("result : " + JSON.stringify(result));
 	             ChartData = result; 
 	             
 	             ChartData.datasets[0].backgroundColor = mfColors;
 	             ChartData.datasets[0].borderColor = mfColors;
 	             
 	             var pieChartjs = document.getElementById("Chart1");
 	             pieChartjs && new Chart(pieChartjs, {
 	                 type: "pie",
 	                 data: ChartData,
 	                 options: {
 	                     maintainAspectRatio: !1,
 	                     responsive: !0
 	                 }
 	             });
 	             
 	        }
 	    });
 	    

 	 	
 		//두번째
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/tltime",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("2번차트 result : ", result);
 	             ChartData = result; 
 	             
 	            ChartOptions.legend.display = 1;
	        	ChartOptions.scales.yAxes[0].ticks= {
	 	  	 	         min: 8.6,       // 최소값 설정
	 		 	         max: 9.6,      // 최대값 설정
	 		 	         stepSize: 0.2   // 눈금 간격 설정
	 	        }
 	            	 
 	            barChartjs = document.getElementById("Chart2");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions

 	            });
 	        }
 	    });
 	    
 		//세번째
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/stime",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("3번째 차트 result : " , result);
 	             ChartData = result; 
 	             
 	            ChartOptions.legend.display = 1;
 	        	ChartOptions.scales.yAxes[0].ticks= {
 	  	 	         min: 8.6,       // 최소값 설정
 		 	         max: 9.4,      // 최대값 설정
 		 	         stepSize: 0.2   // 눈금 간격 설정
 	  	 	        }
 	             
 	            barChartjs = document.getElementById("Chart3");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "line",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
 	    
 		//네번째
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/etime",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("result : " + result);
 	             ChartData = result; 
 	             
 	            ChartOptions.legend.display = 1;
  	        	ChartOptions.scales.yAxes[0].ticks= {
  	 	 	         min: 17.6,       // 최소값 설정
  		 	         max: 18.4,      // 최대값 설정
  		 	         stepSize: 0.2   // 눈금 간격 설정
	  	 	        }
 	            	 
 	            barChartjs = document.getElementById("Chart4");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "line",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
 	    
 		//다섯번째
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/avgSalary",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("다섯번째 result : " , result);
 	             ChartData = result;
 	             
 	            ChartOptions.legend.display = !1;
 	             ChartData.datasets[0].backgroundColor = chartColors
 	             ChartData.datasets[0].borderColor = chartColors
 	             
  	        	ChartOptions.scales.yAxes[0].ticks= {

	  	 	        }
 	             	 
 	             
 	            barChartjs = document.getElementById("Chart5");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
 		
 		//지출경비
		$.ajax({
 	        type: "get",
 	        url: "/statistics/cost",
 	        async:false,
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log(" 비용관리 비용토탈@! 임금 차트 : " , result);
 	             ChartData = result; 
 	        	ChartOptions.scales.yAxes[0].ticks= {

 	        	}
 	             
 	            barChartjs = document.getElementById("Chart6");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
 	}
    
 	
 	function quaterNo2() {
 		 $("#chart").empty();    	 $("#chart2").empty();    	  $("#chart3").empty();    	  $("#chart4").empty();    	  $("#chart5").empty();    	$("#chart6").empty();  
         $("#chart").html(cont);          $("#chart2").html(cont2);          $("#chart3").html(cont3);          $("#chart4").html(cont4);          $("#chart5").html(cont5);          
         
    	$(".card-title").eq(0).html("입사자 수");
	   	$(".card-title").eq(1).html("퇴사자 수");
	    $(".card-title").eq(2).html("지원자 수");
	    $(".card-title").eq(3).html("희망 연봉");
	    $(".card-title").eq(4).html("지원자 최종학력");
	    $(".card-title").eq(5).html("직급별 평균 연봉");
         
		//채용관리 분기 입사자수
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/inpeople",
 	        async:false,
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log(" 채용관리 입사자번째 차트 : " , result);
 	             ChartData = result; 
   	        	ChartOptions.scales.yAxes[0].ticks= {
	 	  	 	         min: 0,       
	 	  	 	         max: 10
	  	 	        }
   	        	ChartOptions.legend.display = !1;
 	             
 	            barChartjs = document.getElementById("Chart1");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "line",    
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
		
		//채용관리 분기 퇴사
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/outpeople",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("채용관리 퇴사자 수 : " , result);
 	             ChartData = result; 
   	        	ChartOptions.scales.yAxes[0].ticks= {
	 	  	 	         min: 0,       
	 	  	 	         max: 10
	  	 	        }
   	        	ChartOptions.legend.display = !1;
 	             
 	            barChartjs = document.getElementById("Chart2");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "line",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
		
		//채용관리 지원자수 분기 (토탈,신입,경력)
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/employmentApplicant",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("채용관리입사 지원자 수: " , result);
 	             ChartData = result;
 	             
 	            ChartOptions.scales.xAxes[0].ticks = {
 	                // x 축 양쪽 끝에 10의 패딩 추가
 	               margin:100
 	           }
 	           ChartOptions.legend.display = 1;
 	        	ChartOptions.scales.yAxes[0].ticks= {
 	  	 	         min: 0,       // 최소값 설정
 	  	 	         max: 40,      // 최대값 설정
 	  	 	         stepSize: 10, // 눈금 간격 설정
 	  	 	    	 padding: 0
 	  	 	        }
 	             	             
 	            barChartjs = document.getElementById("Chart3");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
		
 		//채용관리 희망연봉
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/avgHansl",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("채용관리 희망연봉 : " + result);
 	             ChartData = result; 
 	            ChartOptions.legend.display = 1;
  	        	ChartOptions.scales.yAxes[0].ticks= {
  	 	  	 	         min: 0,       
  	 	  	 	         max: 7000 
	  	 	        }
 	            	 
 	            barChartjs = document.getElementById("Chart4");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
 		
 		//다섯번째
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/empmnLacd",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("다섯번째 result : " , result);
 	             ChartData = result;
 	            ChartOptions.legend.display = 1;
   	        	ChartOptions.scales.yAxes[0].ticks= {
 	 	  	 	         min: 0,       
 	 	  	 	         max: 20
	  	 	        }
	            	 
 	             
 	            barChartjs = document.getElementById("Chart5");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
		
		
	} // No2 끝
	
	
	
	
	 
	function yearNo1(){
		 $("#chart").empty();    	 $("#chart2").empty();    	  $("#chart3").empty();    	  $("#chart4").empty();    	  $("#chart5").empty();    	$("#chart6").empty();  
         $("#chart").html(cont);          $("#chart2").html(cont2);          $("#chart3").html(cont3);          $("#chart4").html(cont4);          $("#chart5").html(cont5);   $("#chart6").html(cont6);       
         
    	$(".card-title").eq(0).html("연도별 인원수");
	   	$(".card-title").eq(1).html("직급별 평균 근무시간");
	    $(".card-title").eq(2).html("평균 출근시간");
	    $(".card-title").eq(3).html("평균 퇴근시간");
	    $(".card-title").eq(4).html("직급별 평균 연봉");
	    $(".card-title").eq(5).html("연도별 지출경비");
	    
	  //채용관리 분기 입사자수   
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/yearMF",
 	        async:false,
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log(" 연도별 인원수 차트 : " , result);
 	             ChartData = result; 
   	        	ChartOptions.scales.yAxes[0].ticks= {
	 	  	 	         min: 0,       
	 	  	 	         max: 40,
	 	  	 	     stepSize: 5
	  	 	        }
   	        	ChartOptions.legend.display = !1;
 	             
 	            barChartjs = document.getElementById("Chart1");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
	  
 		//연도별 직급별 평균 근무시간
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/yeartltime",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("2번차트 result : ", result);
 	             ChartData = result; 
 	             
 	            ChartOptions.legend.display = 1;
	        	ChartOptions.scales.yAxes[0].ticks= {
	 	  	 	         min: 8.6,       // 최소값 설정
 	 		 	         max: 9.4,      // 최대값 설정
 	 		 	         stepSize: 0.2   // 눈금 간격 설정
	 	        }
 	            	 
 	            barChartjs = document.getElementById("Chart2");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions

 	            });
 	        }
 	    });
 	    
 		//연도별 평균 출근시간
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/yearstime",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("평균 출근 result : " , result);
 	             ChartData = result; 
 	             
 	            ChartOptions.legend.display = 1;
 	        	ChartOptions.scales.yAxes[0].ticks= {
 	 	  	 	         min: 8.6,       // 최소값 설정
 	 		 	         max: 9.4,      // 최대값 설정
 	 		 	         stepSize: 0.2   // 눈금 간격 설정
 	  	 	        }
 	             
 	            barChartjs = document.getElementById("Chart3");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "line",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
 	    
 		//연도별 평균 퇴근시간
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/yearetime",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("평균 퇴근 : " + result);
 	             ChartData = result; 
 	             
 	            ChartOptions.legend.display = 1;
  	        	ChartOptions.scales.yAxes[0].ticks= {
  	  	 	 	         min: 17.6,       // 최소값 설정
  	  		 	         max: 18.4,      // 최대값 설정
  	  		 	         stepSize: 0.2   // 눈금 간격 설정
	  	 	        }
 	            	 
 	            barChartjs = document.getElementById("Chart4");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "line",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
 	    
 		//연도별 직급별 평균연봉
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/avgSalary",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("다섯번째 result : " , result);
 	             ChartData = result;
 	             
 	            ChartOptions.legend.display = !1;
 	             ChartData.datasets[0].backgroundColor = chartColors;
 	             ChartData.datasets[0].borderColor = chartColors
 	             
  	        	ChartOptions.scales.yAxes[0].ticks= {

	  	 	        }
 	             	 
 	             
 	            barChartjs = document.getElementById("Chart5");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
 		
 		//연도별 지출경비
		$.ajax({
 	        type: "get",
 	        url: "/statistics/yearcost",
 	        async:false,
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log(" 비용관리 비용토탈@! 임금 차트 : " , result);
 	             ChartData = result; 
 	        	ChartOptions.scales.yAxes[0].ticks= {

 	        	}
 	             
 	            barChartjs = document.getElementById("Chart6");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
	    
	    
	}
	
	function yearNo2(){
		 $("#chart").empty();    	 $("#chart2").empty();    	  $("#chart3").empty();    	  $("#chart4").empty();    	  $("#chart5").empty();    	$("#chart6").empty();  
         $("#chart").html(cont);          $("#chart2").html(cont2);          $("#chart3").html(cont3);          $("#chart4").html(cont4);          $("#chart5").html(cont5);          
         

    	$(".card-title").eq(0).html("연도별 입사자 수");
	   	$(".card-title").eq(1).html("연도별 퇴사자 수");
	    $(".card-title").eq(2).html("연도별 지원자 수");
	    $(".card-title").eq(3).html("희망 연봉");
	    $(".card-title").eq(4).html("지원자 최종학력");
	    $(".card-title").eq(5).html("직급별 평균 연봉");
	    
		//채용관리 분기 입사자수
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/yearinpeople",
 	        async:false,
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("연도 채용관리 입사자번째 차트 : " , result);
 	             ChartData = result; 
   	        	ChartOptions.scales.yAxes[0].ticks= {

	  	 	        }
   	        	ChartOptions.legend.display = !1;
 	             
 	            barChartjs = document.getElementById("Chart1");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "line",    
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
		
		//채용관리 분기 퇴사
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/yearoutpeople",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("연도 채용관리 퇴사자 수 : " , result);
 	             ChartData = result; 
   	        	ChartOptions.scales.yAxes[0].ticks= {
// 	 	  	 	         min: 100,       
// 	 	  	 	         max: 300
	  	 	        }
   	        	ChartOptions.legend.display = !1;
 	             
 	            barChartjs = document.getElementById("Chart2");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "line",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
		
		//채용관리 지원자수 분기 (토탈,신입,경력)
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/yearemploymentApplicant",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("채용관리입사 지원자 수: " , result);
 	             ChartData = result;
 	             
 	            ChartOptions.scales.xAxes[0].ticks = {
 	                // x 축 양쪽 끝에 10의 패딩 추가
 	               margin:100
 	           }
 	           ChartOptions.legend.display = 1;
 	        	ChartOptions.scales.yAxes[0].ticks= {
//  	  	 	         min: 0,       // 최소값 설정
//  	  	 	         max: 150,      // 최대값 설정
//  	  	 	         stepSize: 10, // 눈금 간격 설정
 	  	 	    	 padding: 0
 	  	 	        }
 	             	             
 	            barChartjs = document.getElementById("Chart3");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
		
 		//채용관리 희망연봉
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/yearavgHansl",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("연도별 채용관리 희망연봉 : " + result);
 	             ChartData = result; 
 	            ChartOptions.legend.display = 1;
  	        	ChartOptions.scales.yAxes[0].ticks= {
  	 	  	 	         min: 0,       
  	 	  	 	         max: 7000 
	  	 	        }
 	            	 
 	            barChartjs = document.getElementById("Chart4");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
 		
 		//다섯번째
 		$.ajax({
 	        type: "get",
 	        url: "/statistics/yearempmnLacd",
 	        data: "",
 	        error: function (error) {
 	            alert("Error!");
 	        },
 	        success: function (result) {
 	        	console.log("연도별 최종학력 result : " , result);
 	             ChartData = result;
 	            ChartOptions.legend.display = 1;
   	        	ChartOptions.scales.yAxes[0].ticks= {
//  	 	  	 	         min: 0,       
//  	 	  	 	         max: 50
	  	 	        }
	            	 
 	             
 	            barChartjs = document.getElementById("Chart5");
 	            barChartjs && new Chart(barChartjs, {
 	                type: "bar",
 	                data: ChartData,
 	                options: ChartOptions
 	            });
 	        }
 	    });
		

	}

 	
 	
 	$(document).on("click", "#buttonOne", function(){
		document.getElementById("buttonTwo").className="btn mb-2 btn-secondary";
		document.getElementById("buttonOne").className="btn mb-2 btn-primary";
		
		document.getElementById("quatersOne").className="btn mb-2 btn-primary";
		document.getElementById("yearsOne").className="btn mb-2 btn-secondary";	
 		console.log("11111111111111111")
 		quaterNo1();
 	})
 	
 	$(document).on("click", "#quatersOne", function(){
		document.getElementById("quatersOne").className="btn mb-2 btn-primary";
		document.getElementById("yearsOne").className="btn mb-2 btn-secondary";	
 		console.log("3333")
 		quaterNo1();
 	})
 	$(document).on("click", "#yearsOne", function(){
		document.getElementById("quatersOne").className="btn mb-2 btn-secondary";
		document.getElementById("yearsOne").className="btn mb-2 btn-primary";	
 		console.log("44444")
 		yearNo1();
 	})
 	
 	
 	
 	
 	$(document).on("click", "#buttonTwo", function(){
		document.getElementById("buttonTwo").className="btn mb-2 btn-primary";
		document.getElementById("buttonOne").className="btn mb-2 btn-secondary";
 		
		document.getElementById("yearsTwo").className="btn mb-2 btn-secondary";
		document.getElementById("quatersTwo").className="btn mb-2 btn-primary";
 		console.log("2222222222222222")
 		quaterNo2();
 	})
 	$(document).on("click", "#quatersTwo", function(){
		document.getElementById("quatersTwo").className="btn mb-2 btn-primary";
		document.getElementById("yearsTwo").className="btn mb-2 btn-secondary";	
 		console.log("666666666")
 		quaterNo2();
 	})
 	$(document).on("click", "#yearsTwo", function(){
		document.getElementById("quatersTwo").className="btn mb-2 btn-secondary";
		document.getElementById("yearsTwo").className="btn mb-2 btn-primary";	
 		console.log("77777777777777")
 		yearNo2();
 	})
 	
	
	
              
//                $("#quaters").on("click", function(){
//             		document.getElementById("quaters").className="btn mb-2 btn-primary";
//             		document.getElementById("years").className="btn mb-2 btn-secondary";
            		
//             		document.getElementById("year-buttonOne").id="buttonOne";
//             		document.getElementById("year-buttonTwo").id="buttonTwo";
            		
//             		document.getElementById("buttonOne").className="btn mb-2 btn-primary";
//             		document.getElementById("buttonTwo").className="btn mb-2 btn-secondary";
            		
//             		quaterNo1();
//             	})
//             	$("#years").on("click", function(){
//             		document.getElementById("quaters").className="btn mb-2 btn-secondary";
//             		document.getElementById("years").className="btn mb-2 btn-primary";
            		
//             		document.getElementById("buttonOne").id="year-buttonOne";
//             		document.getElementById("buttonTwo").id="year-buttonTwo";
            		
            		
//             		document.getElementById("year-buttonOne").className="btn mb-2 btn-primary";
//             		document.getElementById("year-buttonTwo").className="btn mb-2 btn-secondary";
            		
//             		yearNo1();
//             	})
              
              
              
            
//             $(document).on("click", "#buttonOne" , function () {
//             	document.getElementById("buttonOne").className="btn mb-2 btn-primary";
//         		document.getElementById("buttonTwo").className="btn mb-2 btn-secondary";
        		
//         		quaterNo1();
              
//             });
            
            
//                $(document).on("click", "#buttonTwo" , function () {
//             		document.getElementById("buttonOne").className="btn mb-2 btn-secondary";
//             		document.getElementById("buttonTwo").className="btn mb-2 btn-primary";
            		           		
//             		quaterNo2();
            		
                  
//                 });
            	
            	

            	
            	
            	
            	
            	
            	///////////YEAR 변경
            $(document).on("click", "#year-buttonOne" , function () {
            	document.getElementById("year-buttonOne").className="btn mb-2 btn-primary";
        		document.getElementById("year-buttonTwo").className="btn mb-2 btn-secondary";
        		
        		yearNo1();
              
            });
            
            
            $(document).on("click", "#year-buttonTwo" , function () {
            	document.getElementById("year-buttonOne").className="btn mb-2 btn-secondary";
        		document.getElementById("year-buttonTwo").className="btn mb-2 btn-primary";
            		
        		yearNo2();
                  
                });
            	
            	
            	
}); 

            
            	
</script>


</html>