<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="favicon.ico">
<title>Insight</title>
<!-- Simple bar CSS -->
<link rel="stylesheet" href="/resources/light/css/simplebar.css">
<!-- Fonts CSS -->
<link
   href="https://fonts.googleapis.com/css2?family=Overpass:ital,wght@0,100;0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap"
   rel="stylesheet">
<!-- Icons CSS -->
<link rel="stylesheet" href="/resources/light/css/feather.css">
<link rel="stylesheet" href="/resources/light/css/select2.css">
<link rel="stylesheet" href="/resources/light/css/dropzone.css">
<link rel="stylesheet" href="/resources/light/css/uppy.min.css">
<link rel="stylesheet" href="/resources/light/css/jquery.steps.css">
<link rel="stylesheet" href="/resources/light/css/jquery.timepicker.css">
<link rel="stylesheet" href="/resources/light/css/quill.snow.css">
<!-- Date Range Picker CSS -->
<link rel="stylesheet" href="/resources/light/css/daterangepicker.css">
<!-- App CSS -->
<link rel="stylesheet" href="/resources/light/css/app-light.css"
   id="lightTheme">
<link rel="stylesheet" href="/resources/light/css/app-dark.css"
   id="darkTheme" disabled>
<!-- FullCalendar CSS -->
<link rel="stylesheet" href="/resources/light/css/fullcalendar.css">
<!-- Mobiscroll JS and CSS Includes -->
<link rel="stylesheet" href="/resources/light/css/mobiscroll.javascript.min.css">
<script src="/resources/js/mobiscroll.javascript.min.js"></script>
<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">

<!-- DataTables -->
<link rel="stylesheet" href="/resources/adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="/resources/adminlte/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
<link rel="stylesheet" href="/resources/adminlte/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">



<!-- jQuery plugin으로 만들어졌으니 jquery 필수 포함  (페이지당 1번만 포함시키면 됨. 여러번 넣으면 깨짐) -->  
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" integrity="sha512-A5OJVuNqxRragmJeYTW19bnw9M2WyxoshScX/rGTgZYj5hRXuqwZ+1AVn2d6wYTZPzPXxDeAGlae0XwTQdXjQA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- jstree lib 포함 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/jstree.min.js" integrity="sha512-zTdDEt8tOqDRVRFKgypzg8g7FJE7A9lhnTZ6YpUlufaF/XvjIGF/zaPljDhER8XmIwePEAjBjv27TEuubED0/A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>  


<script>
	$(function(){
		let closeModal = document.querySelector("#closeClick");
		$('#closemodal').on("click",function(){
			closeModal.click();
		})
		
		
	//새로운 소식 클릭시
      const $newPopup = $("#showNewWindow")
      let temp = false;
		
		$("#newPosition").on("click",function(){
	         console.log()
	         if(!temp){
	            $newPopup.css("display","block");
	         }else{
	            $newPopup.css("display","none");
	         }
	        temp = !temp;
		});
		
		$(document).mouseup(function (e){
		   if(temp){
		 	  $newPopup.css('display','none');
			   temp = !temp;
		   }
		});
		
	})//function
	
	
</script>
</head>

<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.EmpVO" var="myEmpVO" />
<%--    <div>세션테스트: ${empVO }</div> --%>
</sec:authorize>


<style>
a:hover{
color:black;
text-decoration: none;
}

 #wetreeJsContaner{
 display: none; 
 } 

#showNewWindow{
background-color: white;
z-index: 8000;
top: 147px;
left: 260px;
display: none;
}


</style>




<body class="vertical  light" style="position: relative;">
	<!-- 소캣 알림 -->
   <div id="showNewWindow" style="position:absolute;" class=""></div>
	<!-- 소캣 알림 -->
	
     <div id="wetreeJsContaner">
		 <div id="wetreeJs">
		 	 <button type="button" id="open" class="btn mb-2 btn-outline-link"><span class="fe fe-24 fe-book-open"></span></button>
		     <div id="sujiTree"></div>    
			    <input type="text" id="schText" va>
		     	<button id="myModalClose" type="button" class="btn mb-2 btn-secondary" data-dismiss="modal">닫기</button>
		     <div class="modal-footer">
			 </div>
	     </div>
    </div>
	 
	 
	 <!-- 나의 권한 -->
	 <div id="myAuthView" style="position:absolute; top:60px; left:240px; display:none;  z-index: 90000;" class="card shadow" >
<%-- 	 	<h1>${myEmpVO} 권한들</h1> --%>
	 	<div class="card-body">
		<c:forEach var="empAuthList" items="${myEmpVO.authList}" varStatus="">
			<c:set var="authrtId" value="${empAuthList.authrtId}" />
			<c:choose>
				<c:when test="${authrtId eq 'ROLE_ADMIN'}">
					<span class="badge badge-pill badge-danger" style="color: white;">최고관리자</span><br>
				</c:when>
				<c:when test="${authrtId eq 'ROLE_MEMBER'}">
					<span class="badge badge-pill badge-success" style="color: white;">일반 사원</span><br>
				</c:when>
				<c:when test="${authrtId eq 'ROLE_DEPHEAD'}">
					<span class="badge badge-pill badge-warning" style="color: black;">조직장</span><br>
				</c:when>
				<c:when test="${authrtId eq 'ROLE_WORK_AP'}">
					<span class="badge badge-pill badge-warning" style="color: black;">근무결재 권한</span><br>
				</c:when>
				<c:when test="${authrtId eq 'ROLE_CUSTOM1'}">
					<span class="badge badge-pill badge-warning" style="color: black;">커스텀권한</span><br>
				</c:when>
				<c:when test="${authrtId eq 'ROLE_CUSTOM2'}">
					<span class="badge badge-pill badge-warning" style="color: black;">인사담당자</span><br>
				</c:when>
				<c:when test="${authrtId eq 'ROLE_CUSTOM3'}">
					<span class="badge badge-pill badge-warning" style="color: black;">급여담당자</span><br>
				</c:when>
				<c:when test="${authrtId eq 'ROLE_CUSTOM4'}">
					<span class="badge badge-pill badge-warning" style="color: black;">근무담당자</span><br>
				</c:when>
				<c:when test="${authrtId eq 'ROLE_CUSTOM5'}">
					<span class="badge badge-pill badge-warning" style="color: black;">중간관리자</span><br>
				</c:when>
			</c:choose>
		</c:forEach>
	 	</div>
	 </div>
	 
     <!-- Fullscreen modal -->
     <div id="closeClick" class="modal fade modal-full" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
       <button aria-label="" type="button" class="close px-2" data-dismiss="modal" aria-hidden="true">
         <span aria-hidden="true">×</span>
       </button>
       <div class="modal-dialog modal-dialog-centered" role="document">
         <div class="modal-content">
           <div class="modal-body text-center">
             <p> 빠른 사원검색 </p>
             <div class="form-inline justify-content-center">
               <input id="such" class="form-control form-control-lg mr-sm-2 bg-transparent" type="text" placeholder="검색" aria-label="검색">
               <button id="closemodal" class="btn btn-primary btn-lg mb-2 my-2 my-sm-0" type="submit">닫기</button><br/>
             </div>
               <div id="suchResult"></div>
           </div>
         </div>
       </div>
     </div> <!-- small modal -->

   <div class="wrapper">
      <!-- //////////////////////////////////////////////nav시작 //////////////////////////////////////////////////// -->
      <tiles:insertAttribute name="header" />
      
      

      <!-- //////////////////////////////////////////////nav끝  //////////////////////////////////////////////////// -->
      <!-- ////////////////////////////////////////////aside 시작////////////////////////////////////////////////// -->
      <tiles:insertAttribute name="aside" />
      <!-- ////////////////////////////////////////////aside 끝////////////////////////////////////////////////// -->
      <main role="main" class="main-content">
      <!-- ////////////////////////////////////////////body 시작////////////////////////////////////////////////// -->
      <tiles:insertAttribute name="body" />
      <!-- ////////////////////////////////////////////body 끝////////////////////////////////////////////////// -->
         
         
         

         
         
         <div class="modal fade modal-notif modal-slide" tabindex="-1"
            role="dialog" aria-labelledby="defaultModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="defaultModalLabel">Notifications</h5>
                     <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body">
                     <div class="list-group list-group-flush my-n3">
                        <div class="list-group-item bg-transparent">
                           <div class="row align-items-center">
                              <div class="col-auto">
                                 <span class="fe fe-box fe-24"></span>
                              </div>
                              <div class="col">
                                 <small><strong>Package has uploaded
                                       successfull</strong></small>
                                 <div class="my-0 text-muted small">Package is zipped
                                    and uploaded</div>
                                 <small class="badge badge-pill badge-light text-muted">1m
                                    ago</small>
                              </div>
                           </div>
                        </div>
                        <div class="list-group-item bg-transparent">
                           <div class="row align-items-center">
                              <div class="col-auto">
                                 <span class="fe fe-download fe-24"></span>
                              </div>
                              <div class="col">
                                 <small><strong>Widgets are updated
                                       successfull</strong></small>
                                 <div class="my-0 text-muted small">Just create new
                                    layout Index, form, table</div>
                                 <small class="badge badge-pill badge-light text-muted">2m
                                    ago</small>
                              </div>
                           </div>
                        </div>
                        <div class="list-group-item bg-transparent">
                           <div class="row align-items-center">
                              <div class="col-auto">
                                 <span class="fe fe-inbox fe-24"></span>
                              </div>
                              <div class="col">
                                 <small><strong>Notifications have been sent</strong></small>
                                 <div class="my-0 text-muted small">Fusce dapibus,
                                    tellus ac cursus commodo</div>
                                 <small class="badge badge-pill badge-light text-muted">30m
                                    ago</small>
                              </div>
                           </div>
                           <!-- / .row -->
                        </div>
                        <div class="list-group-item bg-transparent">
                           <div class="row align-items-center">
                              <div class="col-auto">
                                 <span class="fe fe-link fe-24"></span>
                              </div>
                              <div class="col">
                                 <small><strong>Link was attached to menu</strong></small>
                                 <div class="my-0 text-muted small">New layout has been
                                    attached to the menu</div>
                                 <small class="badge badge-pill badge-light text-muted">1h
                                    ago</small>
                              </div>
                           </div>
                        </div>
                        <!-- / .row -->
                     </div>
                     <!-- / .list-group -->
                  </div>
                  <!-- ///////////////////////////////////////footer시작///////////////////////////////////////////// -->
                  <tiles:insertAttribute name="footer"/>
                  <!-- ///////////////////////////////////////footer끝///////////////////////////////////////////// -->
                  
               </div>
            </div>
         </div>
         <div class="modal fade modal-shortcut modal-slide" tabindex="-1"
            role="dialog" aria-labelledby="defaultModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="defaultModalLabel">Shortcuts</h5>
                     <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body px-5">
                     <div class="row align-items-center">
                        <div class="col-6 text-center">
                           <div class="squircle bg-success justify-content-center">
                              <i class="fe fe-cpu fe-32 align-self-center text-white"></i>
                           </div>
                           <p>Control area</p>
                        </div>
                        <div class="col-6 text-center">
                           <div class="squircle bg-primary justify-content-center">
                              <i class="fe fe-activity fe-32 align-self-center text-white"></i>
                           </div>
                           <p>Activity</p>
                        </div>
                     </div>
                     <div class="row align-items-center">
                        <div class="col-6 text-center">
                           <div class="squircle bg-primary justify-content-center">
                              <i class="fe fe-droplet fe-32 align-self-center text-white"></i>
                           </div>
                           <p>Droplet</p>
                        </div>
                        <div class="col-6 text-center">
                           <div class="squircle bg-primary justify-content-center">
                              <i
                                 class="fe fe-upload-cloud fe-32 align-self-center text-white"></i>
                           </div>
                           <p>Upload</p>
                        </div>
                     </div>
                     <div class="row align-items-center">
                        <div class="col-6 text-center">
                           <div class="squircle bg-primary justify-content-center">
                              <i class="fe fe-users fe-32 align-self-center text-white"></i>
                           </div>
                           <p>Users</p>
                        </div>
                        <div class="col-6 text-center">
                           <div class="squircle bg-primary justify-content-center">
                              <i class="fe fe-settings fe-32 align-self-center text-white"></i>
                           </div>
                           <p>Settings</p>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </main>
      <!-- main -->
   </div>
   <!-- .wrapper -->
   <script src="/resources/light/js/popper.min.js"></script>
   <script src="/resources/light/js/moment.min.js"></script>
   <script src="/resources/light/js/bootstrap.min.js"></script>
   <script src="/resources/light/js/simplebar.min.js"></script>
   <script src='/resources/light/js/daterangepicker.js'></script>
   <script src='/resources/light/js/jquery.stickOnScroll.js'></script>
   <script src="/resources/light/js/tinycolor-min.js"></script>
   <script src="/resources/light/js/config.js"></script>
   <script src="/resources/light/js/d3.min.js"></script>
   <script src="/resources/light/js/topojson.min.js"></script>
   <script src="/resources/light/js/datamaps.all.min.js"></script>
   <script src="/resources/light/js/datamaps-zoomto.js"></script>
   <script src="/resources/light/js/datamaps.custom.js"></script>
   <script src="/resources/light/js/Chart.min.js"></script>
   <script>
      /* defind global options */
      Chart.defaults.global.defaultFontFamily = base.defaultFontFamily;
      Chart.defaults.global.defaultFontColor = colors.mutedColor;
    </script>
    <script src='/resources/light/js/fullcalendar.js'></script>
    <script src='/resources/light/js/fullcalendar.custom.js'></script>
   <script src="/resources/light/js/gauge.min.js"></script>
   <script src="/resources/light/js/jquery.sparkline.min.js"></script>
   <script src="/resources/light/js/apexcharts.min.js"></script>
   <script src="/resources/light/js/apexcharts.custom.js"></script>
   <script src='/resources/light/js/jquery.mask.min.js'></script>
   <script src='/resources/light/js/select2.min.js'></script>
   <script src='/resources/light/js/jquery.steps.min.js'></script>
   <script src='/resources/light/js/jquery.validate.min.js'></script>
   <script src='/resources/light/js/jquery.timepicker.js'></script>
   <script src='/resources/light/js/dropzone.min.js'></script>
   <script src='/resources/light/js/uppy.min.js'></script>
   <script src='/resources/light/js/quill.min.js'></script>
   
   <!-- DataTables & Plugins -->
	<script src="/resources/adminlte/plugins/datatables/jquery.dataTables.min.js"></script>
	<script src="/resources/adminlte/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
	<script src="/resources/adminlte/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
	<script src="/resources/adminlte/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
	<script src="/resources/adminlte/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
	<script src="/resources/adminlte/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
	<script src="/resources/adminlte/plugins/jszip/jszip.min.js"></script>
	<script src="/resources/adminlte/plugins/pdfmake/pdfmake.min.js"></script>
	<script src="/resources/adminlte/plugins/pdfmake/vfs_fonts.js"></script>
	<script src="/resources/adminlte/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
	<script src="/resources/adminlte/plugins/datatables-buttons/js/buttons.print.min.js"></script>
	<script src="/resources/adminlte/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
	   
   <script>
      $('.select2').select2(
      {
        theme: 'bootstrap4',
      });
      $('.select2-multi').select2(
      {
        multiple: true,
        theme: 'bootstrap4',
      });
      $('.drgpicker').daterangepicker(
      {
        singleDatePicker: true,
        timePicker: false,
        showDropdowns: true,
        locale:
        {
          format: 'MM/DD/YYYY'
        }
      });
      $('.time-input').timepicker(
      {
        'scrollDefault': 'now',
        'zindex': '9999' /* fix modal open */
      });
      /** date range picker */
      if ($('.datetimes').length)
      {
        $('.datetimes').daterangepicker(
        {
          timePicker: true,
          startDate: moment().startOf('hour'),
          endDate: moment().startOf('hour').add(32, 'hour'),
          locale:
          {
            format: 'M/DD hh:mm A'
          }
        });
      }
      var start = moment().subtract(29, 'days');
      var end = moment();

      function cb(start, end)
      {
        $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
      }
      $('#reportrange').daterangepicker(
      {
        startDate: start,
        endDate: end,
        ranges:
        {
          'Today': [moment(), moment()],
          'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
          'Last 7 Days': [moment().subtract(6, 'days'), moment()],
          'Last 30 Days': [moment().subtract(29, 'days'), moment()],
          'This Month': [moment().startOf('month'), moment().endOf('month')],
          'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
      }, cb);
      cb(start, end);
      $('.input-placeholder').mask("00/00/0000",
      {
        placeholder: "__/__/____"
      });
      $('.input-zip').mask('00000-000',
      {
        placeholder: "____-___"
      });
      $('.input-money').mask("#.##0,00",
      {
        reverse: true
      });
      $('.input-phoneus').mask('(000) 000-0000');
      $('.input-mixed').mask('AAA 000-S0S');
      $('.input-ip').mask('0ZZ.0ZZ.0ZZ.0ZZ',
      {
        translation:
        {
          'Z':
          {
            pattern: /[0-9]/,
            optional: true
          }
        },
        placeholder: "___.___.___.___"
      });
      // editor
      var editor = document.getElementById('editor');
      if (editor)
      {
        var toolbarOptions = [
          [
          {
            'font': []
          }],
          [
          {
            'header': [1, 2, 3, 4, 5, 6, false]
          }],
          ['bold', 'italic', 'underline', 'strike'],
          ['blockquote', 'code-block'],
          [
          {
            'header': 1
          },
          {
            'header': 2
          }],
          [
          {
            'list': 'ordered'
          },
          {
            'list': 'bullet'
          }],
          [
          {
            'script': 'sub'
          },
          {
            'script': 'super'
          }],
          [
          {
            'indent': '-1'
          },
          {
            'indent': '+1'
          }], // outdent/indent
          [
          {
            'direction': 'rtl'
          }], // text direction
          [
          {
            'color': []
          },
          {
            'background': []
          }], // dropdown with defaults from theme
          [
          {
            'align': []
          }],
          ['clean'] // remove formatting button
        ];
        var quill = new Quill(editor,
        {
          modules:
          {
            toolbar: toolbarOptions
          },
          theme: 'snow'
        });
      }
      // Example starter JavaScript for disabling form submissions if there are invalid fields
      (function()
      {
        'use strict';
        window.addEventListener('load', function()
        {
          // Fetch all the forms we want to apply custom Bootstrap validation styles to
          var forms = document.getElementsByClassName('needs-validation');
          // Loop over them and prevent submission
          var validation = Array.prototype.filter.call(forms, function(form)
          {
            form.addEventListener('submit', function(event)
            {
              if (form.checkValidity() === false)
              {
                event.preventDefault();
                event.stopPropagation();
              }
              form.classList.add('was-validated');
            }, false);
          });
        }, false);
      })();
    </script>
   <script>
      var uptarg = document.getElementById('drag-drop-area');
      if (uptarg)
      {
        var uppy = Uppy.Core().use(Uppy.Dashboard,
        {
          inline: true,
          target: uptarg,
          proudlyDisplayPoweredByUppy: false,
          theme: 'dark',
          width: 770,
          height: 210,
          plugins: ['Webcam']
        }).use(Uppy.Tus,
        {
          endpoint: 'https://master.tus.io/files/'
        });
        uppy.on('complete', (result) =>
        {
          console.log('Upload complete! Weâve uploaded these files:', result.successful)
        });
      }
    </script>

    <script src="/resources/light/js/apps.js"></script>
   <!-- Global site tag (gtag.js) - Google Analytics -->
   <script async src="https://www.googletagmanager.com/gtag/js?id=UA-56159088-1"></script>
   <script>
      window.dataLayer = window.dataLayer || [];

      function gtag()
      {
        dataLayer.push(arguments);
      }
      gtag('js', new Date());
      gtag('config', 'UA-56159088-1');
    </script>
</body>
</html>