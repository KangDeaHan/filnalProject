<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>



<script>
$(function(){
	
    var urlParams = new URLSearchParams(window.location.search);
    var loadedEmpNo = urlParams.get('empNo');
	
	const resultHt = $("#result"); //결과창
	const resultHt2 = $("#result2"); //결과창2
	const $myFile = $("input[name='file']"); //파일
	const $tempFile = $("input[name='tempFile']"); //직인파일
	const $preImg = $("#preImg")//이미지
	const $update = $("#update")// 수정버튼
	const myimg = document.querySelector("#myImg");
	const myprofileImg = document.querySelector("#myProfileImg");
	

	
	//내정보 가져오기
	function myInfo(){
		 $.ajax({
		 url:"/common/selectEmp",
		 type:"get",
		 data: { empNo: loadedEmpNo }, // empNo 값을 전달
		 dataType:"json",
		 success:function(result){
			 	console.log("하 ㅠㅠㅠ" + result)
				console.log("결과??" + result.authList)
			 // 예제로 사용한 타임스탬프 값
			 const timestamp = result.entDate;

			 // 타임스탬프 값을 Date 객체로 변환
			 const date = new Date(Number(timestamp));

			 // 로컬 날짜 형식으로 변환
			 const formattedDate = date.toLocaleDateString();
			 console.log("formattedDate"+formattedDate);
			 
			 console.log("통신결과",result);
			 let htmlCode = "";
			 let htmlCode2 = "";
			 htmlCode += "<table width='70%' style='font-size: 15px; margin: 10px;'>";
			 htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
			 htmlCode += "<td style='padding-bottom: 20px;'>인사 정보</td>";
			 htmlCode += "</tr>";
			 htmlCode += "<tr><td>사번</td><td>"+result.empNo+"</td></tr>";
             if (formattedDate === null || formattedDate === undefined) {
                 htmlCode += "<tr><td>입사일</td><td>정보 미입력</td></tr>";
             } else {
                 htmlCode += "<tr><td>입사일</td><td>" + formattedDate + "</td></tr>";
             }
             if (result.entCaseNm === null || result.entCaseNm === undefined) {
                 htmlCode += "<tr><td>입사유형</td><td>정보 미입력</td></tr>";
             } else {
                 htmlCode += "<tr><td>입사유형</td><td>" + result.entCaseNm + "</td></tr>";
             }
             if (result.dtCodeNm === null || result.dtCodeNm === undefined) {
                 htmlCode += "<tr><td>조직/직책</td><td>정보 미입력</td></tr>";
             } else {
                 htmlCode += "<tr><td>조직/직책</td><td>" + result.deptVOList.dnm + "/" + result.dtCodeNm + "</td></tr>";
             }
             if (result.jcodeNm === null || result.jcodeNm === undefined) {
                 htmlCode += "<tr><td>직무</td><td>정보 미입력</td></tr>";
             } else {
                 htmlCode += "<tr><td>직무</td><td>" + result.jcodeNm + "</td></tr>";
             }
             if (result.ptnCodeNm === null || result.ptnCodeNm === undefined) {
                 htmlCode += "<tr><td>직위</td><td>정보 미입력</td></tr>";
             } else {
                 htmlCode += "<tr><td>직위</td><td>" + result.ptnCodeNm + "</td></tr>";
             }
             if (result.grdCodeNm === null || result.grdCodeNm === undefined) {
                 htmlCode += "<tr><td>직급</td><td>정보 미입력</td></tr>";
             } else {
                 htmlCode += "<tr><td>직급</td><td>" + result.grdCodeNm + "</td></tr>";
             }
			 htmlCode += "</table>";
 			 htmlCode2 += "<button type='button' id='open-modal' class='btn mb-2 btn-outline-info' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3' data-toggle='modal' data-target='#insaModal' data-whatever='@mdo'></span></button>";
			 
			 resultHt.html(htmlCode);
 			 resultHt2.html(htmlCode2);
		 }
		 });
	};
	
	//내정보 불러오기
	myInfo();
	
	//인사정보 클릭시
	$("#resultInfo1").on("click",function(){
		myInfo();
	});
	
	//개인정보 클릭시
	$("#resultInfo2").on("click",function(){
		$.ajax({
			url:"/common/selectEmp",
			type:"get",
			data: { empNo: loadedEmpNo }, // empNo 값을 전달
			dataType:"json",
			success:function(result){
			console.log("통신결과",result);

			// 주민등록번호
			const juminNo = result.regn;

			// 앞의 6자리 (YYMMDD) 추출
			const birthDatePart = juminNo.substring(0, 6);

			// 년(YY)과 월(MM), 일(DD)로 분리
			const year = birthDatePart.substring(0, 2);
			const month = birthDatePart.substring(2, 4);
			const day = birthDatePart.substring(4, 6);

			// 년(YY)을 4자리로 확장 (예: 91 -> 1991)
			const fullYear = (parseInt(year, 10) < 21 ? "20" : "19") + year;

			// 출력 형식 설정 (예: "1991년 6월 29일")
			const formattedBirthDate = fullYear + "년 " + month + "월 " + day + "일";

			console.log("생년월일:", formattedBirthDate);
			
			
			let htmlCode = "";
			let htmlCode2 ="";
			
			htmlCode += "<table width='70%' style='font-size: 15px; margin: 10px;'>";
			htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
			htmlCode += "<td style='padding-bottom: 20px;'>개인 정보</td>";
			htmlCode += "</tr>";
			if (result.empMail === null || result.empMail === undefined) {
				htmlCode += "<tr><td>이메일</td><td>정보 미입력</td></tr>";
			} else {
				htmlCode += "<tr><td>이메일</td><td>" + result.empMail + "</td></tr>";
			}
			if (result.empNm === null || result.empNm === undefined) {
				htmlCode += "<tr><td>이름</td><td>정보 미입력</td></tr>";
			} else {
				htmlCode += "<tr><td>이름</td><td>" + result.empNm + "</td></tr>";
			}
			if (formattedBirthDate === null || formattedBirthDate === undefined) {
				htmlCode += "<tr><td>생년월일</td><td>정보 미입력</td></tr>";
			} else {
				htmlCode += "<tr><td>생년월일</td><td>" + formattedBirthDate + "</td></tr>";
			}
			if (result.regn === null || result.regn === undefined) {
			    htmlCode += "<tr><td>주민등록번호</td><td>정보 미입력</td></tr>";
			} else {
			    let formattedRegn;
			    
			    // 주민등록번호가 "910629-1451010" 형식인 경우
			    if (result.regn.match(/^(\d{6}-\d{7})$/)) {
			        formattedRegn = result.regn;
			    } else {
			        // 주민등록번호가 "9106291451010" 형식인 경우 포맷 변경 (예: 9106291451010 -> 910629-1451010)
			        formattedRegn = result.regn.replace(/(\d{6})(\d{7})/, '$1-$2');
			    }
			    
			    htmlCode += "<tr><td>주민등록번호</td><td>" + formattedRegn + "</td></tr>";
			}
			if (result.cpNo === null || result.cpNo === undefined) {
			    htmlCode += "<tr><td>휴대전화번호</td><td>정보 미입력</td></tr>";
			} else {
			    let formattedPhoneNumber;
			    
			    // 전화번호가 "010-5599-6622" 형식인 경우
			    if (result.cpNo.match(/^(\d{3}-\d{4}-\d{4})$/)) {
			        formattedPhoneNumber = result.cpNo;
			    } else {
			        // 전화번호가 "01055996622" 형식인 경우 포맷 변경 (예: 01055996622 -> 010-5599-6622)
			        formattedPhoneNumber = result.cpNo.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
			    }
			    
			    htmlCode += "<tr><td>휴대전화번호</td><td>" + formattedPhoneNumber + "</td></tr>";
			}
			if (result.empAddr1 === null || result.empAddr1 === undefined) {
				htmlCode += "<tr><td>집주소</td><td>정보 미입력</td></tr>";
			} else {
				htmlCode += "<tr><td>집주소</td><td>" + "<br>" + "우편번호 : " + result.empAddr1 + "<br><br>" + "주소 : " + result.empAddr2 + " " + result.empAddr3 + "</td></tr>";
			}

			if (result.bankCode === null || result.bankCode === undefined) {
				htmlCode += "<tr><td>은행명</td><td>정보 미입력</td></tr>";
			} else {
				htmlCode += "<tr><td>은행명</td><td>" + result.bankCodeNm + "</td></tr>";
			}
			if (result.acctNo === null || result.acctNo === undefined) {
				htmlCode += "<tr><td>급여계좌</td><td>정보 미입력</td></tr>";
			} else {
				htmlCode += "<tr><td>급여계좌</td><td>" + result.acctNo + "</td></tr>";
			}

			htmlCode += "</table>";
			htmlCode2 += "<button type='button' id='open-modal' class='btn mb-2 btn-outline-info' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3' data-toggle='modal' data-target='#varyModal' data-whatever='@mdo'></span></button>";
			//htmlCode2 += "<button type='button' id='open-modal' class='btn btn-primary btn-icon-split btn-sm' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3'></span></button>";
			resultHt.html(htmlCode);
			resultHt2.html(htmlCode2);
			//resultHt2.html(htmlCode2);

			},
	        error: function () {
	            console.error("데이터를 가져오는 중에 오류가 발생했습니다.");
	            
	            let htmlCode = "";
	            let htmlCode2 = "";
	            
	            htmlCode += "<table width='70%' style='font-size: 15px; margin: 10px;'>";
				htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
				htmlCode += "<td style='padding-bottom: 20px;'>개인정보</td>";
				htmlCode += "</tr>";
				htmlCode += "<tr>";
				htmlCode += "<td>데이터 없음</td>";
				htmlCode += "</tr>";
				htmlCode += "</table>";
	            resultHt.html(htmlCode);
	            htmlCode2 += "<button type='button' id='open-modal' class='btn mb-2 btn-outline-info' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3' data-toggle='modal' data-target='#varyModal' data-whatever='@mdo'></span></button>";
				resultHt2.html(htmlCode2);
	        }
		});
	});
	
	//계약 정보 클릭시
	$("#resultInfo3").on("click",function(){
		 $.ajax({
			 url:"/common/myCnthx",
			 type:"get",
			 data: { empNo: loadedEmpNo }, // empNo 값을 전달
			 dataType:"json",
			 success:function(result){
	            console.log("myCnthx야 데이터 잘 받아온거니? : ",result);
				
				 
				// 예제로 사용한 타임스탬프 값
				 const timestamp1 = result.blctSdate;
				 const timestamp2 = result.blctEdate;
				 const timestamp3 = result.bwctSdate;
				 const timestamp4 = result.bwctEdate;

				 // 타임스탬프 값을 Date 객체로 변환
				 const date1 = new Date(Number(timestamp1));
				 const date2 = new Date(Number(timestamp2));
				 const date3 = new Date(Number(timestamp3));
				 const date4 = new Date(Number(timestamp4));

				 // 로컬 날짜 형식으로 변환
				 const formattedDate1 = date1.toLocaleDateString();
				 const formattedDate2 = date2.toLocaleDateString();
				 const formattedDate3 = date3.toLocaleDateString();
				 const formattedDate4 = date4.toLocaleDateString();
				 console.log("formattedDate1"+formattedDate1);
				 
				 console.log("통신결과",result);
				 let htmlCode = "";
				 let htmlCode2 = "";
				 
				 htmlCode += "<table width='70%' style='font-size: 15px; margin: 10px;'>";
				 htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
				 htmlCode += "<td style='padding-bottom: 20px;'>근로 계약</td>";
				 htmlCode += "</tr>";
				 if (result.ctrtCaseCodeNm === null || result.ctrtCaseCodeNm === undefined) {
	                 htmlCode += "<tr><td>계약 유형</td><td>정보 미입력</td></tr>";
	             } else {
	                 htmlCode += "<tr><td>계약 유형</td><td>" + result.ctrtCaseCodeNm + "</td></tr>";
	             }
				 if (formattedDate1 === null || formattedDate1 === undefined) {
	                 htmlCode += "<tr><td>근로계약 기간</td><td>정보 미입력</td></tr>";
	             } else {
	                 htmlCode += "<tr><td>근로계약 기간</td><td>" + formattedDate1+"~"+formattedDate2 + "</td></tr>";
	             }
				 htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
				 htmlCode += "<td style='padding-bottom: 20px; padding-top: 20px;'>임금계약</td>";
				 htmlCode += "</tr>";
				 htmlCode += "<tr><td>소득 구분</td><td>근로소득</td></tr>";
				 if (formattedDate3 === null || formattedDate3 === undefined) {
	                 htmlCode += "<tr><td>임금계약 기간</td><td>정보 미입력</td></tr>";
	             } else {
	                 htmlCode += "<tr><td>임금계약 기간</td><td>" + formattedDate3+"~"+formattedDate4 + "</td></tr>";
	             }
				 if (result.bcntAmt === null || result.bcntAmt === undefined) {
	                 htmlCode += "<tr><td>계약 금액</td><td>정보 미입력</td></tr>";
	             } else {
	                 htmlCode += "<tr><td>계약 금액</td><td>" + result.bcntAmt + "</td></tr>";
	             }
				 htmlCode += "</table>";
				 htmlCode2 += "<button type='button' id='open-modal' class='btn mb-2 btn-outline-info' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3' data-toggle='modal' data-target='#cnthxModal' data-whatever='@mdo'></span></button>";
				 resultHt2.html(htmlCode2);
				 resultHt.html(htmlCode);
			 },
	         error: function () {
	            console.error("데이터를 가져오는 중에 오류가 발생했습니다.");
	            let htmlCode = "";
	            let htmlCode2 = "";
	            
	            htmlCode += "<table width='70%' style='font-size: 15px; margin: 10px;'>";
				htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
				htmlCode += "<td style='padding-bottom: 20px;'>계약 정보</td>";
				htmlCode += "</tr>";
				htmlCode += "<tr>";
				htmlCode += "<td>데이터 없음</td>";
				htmlCode += "</tr>";
				htmlCode += "</table>";
	            resultHt.html(htmlCode);
	            htmlCode2 += "<button type='button' id='open-modal' class='btn mb-2 btn-outline-info' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3' data-toggle='modal' data-target='#cnthxModal' data-whatever='@mdo'></span></button>";
				resultHt2.html(htmlCode2);
	         }
		 });
	});
	
	//경력/학력 클릭시
	$("#resultInfo4").on("click",function(){
		 $.ajax({
			 url:"/common/mtAcca",
			 type:"get",
			 dataType:"json",
			 data: { empNo: loadedEmpNo }, // empNo 값을 전달
			 success:function(result){
				 
				 // 예제로 사용한 타임스탬프 값
				 const timestamp1 = result.vo.acEtdate;
				 const timestamp2 = result.vo.acEdate;
				 const timestamp3 = result.vo1.caEtdate;
				 const timestamp4 = result.vo1.caEdate;

				 // 타임스탬프 값을 Date 객체로 변환
				 const date1 = new Date(Number(timestamp1));
				 const date2 = new Date(Number(timestamp2));
				 const date3 = new Date(Number(timestamp3));
				 const date4 = new Date(Number(timestamp4));

				 // 로컬 날짜 형식으로 변환
				 const formattedDate1 = date1.toLocaleDateString();
				 const formattedDate2 = date2.toLocaleDateString();
				 const formattedDate3 = date3.toLocaleDateString();
				 const formattedDate4 = date4.toLocaleDateString();
				 console.log("formattedDate1",formattedDate1);
				 
				 
				 
				 console.log("통신결과",result);
	             let htmlCode = "";
	             let htmlCode2 = "";
		            
		            if(result === null){
						console.log("데이터 없다~~");
						htmlCode += "<table width='70%' style='font-size: 15px; margin: 10px;'>";
						htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
						htmlCode += "<td style='padding-bottom: 20px;'>경력/학력</td>";
						htmlCode += "</tr>";
						htmlCode += "</table>";
			            resultHt.html(htmlCode);
			            htmlCode2 += "<button type='button' id='open-modal' class='btn mb-2 btn-outline-info' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3' data-toggle='modal' data-target='#careerModal' data-whatever='@mdo'></span></button>";
						resultHt2.html(htmlCode2);
						
					}else if(result === undefined){
						console.log("데이터 없다~~");
						htmlCode += "<table width='70%' style='font-size: 15px; margin: 10px;'>";
						htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
						htmlCode += "<td style='padding-bottom: 20px;'>경력/학력</td>";
						htmlCode += "</tr>";
						htmlCode += "</table>";
			            resultHt.html(htmlCode);
			            htmlCode2 += "<button type='button' id='open-modal' class='btn mb-2 btn-outline-info' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3' data-toggle='modal' data-target='#careerModal' data-whatever='@mdo'></span></button>";
						resultHt2.html(htmlCode2);
						
					}
					else{
		                // 데이터가 있는 경우 테이블을 생성
					    htmlCode += "<table width='70%' style='font-size: 15px; margin: 10px;'>";
					    htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
		                htmlCode += "<td style='padding-bottom: 20px;'>학력정보</td>";
		                htmlCode += "</tr>";
		                if (result.vo.acNm === null || result.vo.acNm === undefined) {
			                htmlCode += "<tr><td>학교명</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>학교명</td><td>" + result.vo.acNm + "</td></tr>";
			            }
		                if (formattedDate1 === null || formattedDate1 === undefined) {
			                htmlCode += "<tr><td>입학일자</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>입학일자</td><td>" + formattedDate1 + "</td></tr>";
			            }
		                if (formattedDate2 === null || formattedDate2 === undefined) {
			                htmlCode += "<tr><td>졸업일자</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>졸업일자</td><td>" + formattedDate2 + "</td></tr>";
			            }
		                if (result.vo.gradClfNm === null || result.vo.gradClfNm === undefined) {
			                htmlCode += "<tr><td>졸업 여부</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>졸업 여부</td><td>" + result.vo.gradClfNm + "</td></tr>";
			            }
		                if (result.vo.maj === null || result.vo.maj === undefined) {
			                htmlCode += "<tr><td>전공</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>전공</td><td>" + result.vo.maj + "</td></tr>";
			            }
		                htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
		                htmlCode += "<td style='padding-top: 20px; padding-bottom: 20px;'>경력정보</td>";
		                htmlCode += "</tr>";
		                if (result.vo1.caNm === null || result.vo1.caNm === undefined) {
			                htmlCode += "<tr><td>회사명</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>회사명</td><td>" + result.vo1.caNm + "</td></tr>";
			            }
		                if (formattedDate3 === null || formattedDate3 === undefined) {
			                htmlCode += "<tr><td>입사일자</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>입사일자</td><td>" + formattedDate3+ "</td></tr>";
			            }
		                if (formattedDate4 === null || formattedDate4 === undefined) {
			                htmlCode += "<tr><td>퇴사일자</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>퇴사일자</td><td>" + formattedDate4 + "</td></tr>";
			            }
		                if (result.vo1.caCntcase === null || result.vo1.caCntcase === undefined) {
			                htmlCode += "<tr><td>계약유형</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>계약유형</td><td>" + result.vo1.caCntcase + "</td></tr>";
			            }
		                if (result.vo1.caDept === null || result.vo1.caDept === undefined) {
			                htmlCode += "<tr><td>부서</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>부서</td><td>" + result.vo1.caDept + "</td></tr>";
			            }
		                if (result.vo1.caDuty === null || result.vo1.caDuty === undefined) {
			                htmlCode += "<tr><td>직책</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>직책</td><td>" + result.vo1.caDuty + "</td></tr>";
			            }
		                if (result.vo1.caJob === null || result.vo1.caJob === undefined) {
			                htmlCode += "<tr><td>직무</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>직무</td><td>" + result.vo1.caJob + "</td></tr>";
			            }
		                if (result.vo1.caGrd === null || result.vo1.caGrd === undefined) {
			                htmlCode += "<tr><td>직위</td><td>정보 미입력</td></tr>";
			            } else {
			                htmlCode += "<tr><td>직위</td><td>" + result.vo1.caGrd + "</td></tr>";
			            }
		                htmlCode += "</table>";
			            resultHt.html(htmlCode);
			            htmlCode2 += "<button type='button' id='open-modal' class='btn mb-2 btn-outline-info' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3' data-toggle='modal' data-target='#careerModal' data-whatever='@mdo'></span></button>";
						resultHt2.html(htmlCode2);
		            }

		        },
		        error: function () {
		            console.error("데이터를 가져오는 중에 오류가 발생했습니다.");
		            
		            let htmlCode = "";
		            let htmlCode2 = "";
		            
		            htmlCode += "<table width='70%' style='font-size: 15px; margin: 10px;'>";
					htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
					htmlCode += "<td style='padding-bottom: 20px;'>경력/학력</td>";
					htmlCode += "</tr>";
					htmlCode += "<tr>";
					htmlCode += "<td>데이터 없음</td>";
					htmlCode += "</tr>";
					htmlCode += "</table>";
		            resultHt.html(htmlCode);
		            htmlCode2 += "<button type='button' id='open-modal' class='btn mb-2 btn-outline-info' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3' data-toggle='modal' data-target='#careerModal' data-whatever='@mdo'></span></button>";
					resultHt2.html(htmlCode2);
		        }
		    });
		});
	
	//문서
	$("#resultInfo5").on("click",function(){
		 $.ajax({
			 url:"/common/selectEmp",
			 type:"get",
			 dataType:"json",
			 data: { empNo: loadedEmpNo }, // empNo 값을 전달
			 success:function(result){
				 if(result === null){
					console.log("데이터 없다~~");
				 }
				 else{
					 console.log("통신결과",result);
					 let htmlCode = "";
					 let htmlCode2 = "";
					 htmlCode += "<table width='70%' style='font-size: 15px; margin: 10px;'>";
					 htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
					 htmlCode += "<td style='padding-bottom: 20px;'>내문서</td><td style='padding-bottom: 20px;'>파일</td><td style='padding-bottom: 20px;'>수정일</td>";
					 htmlCode += "</tr>";
					 htmlCode += "<tr><td>주민등록등본</td><td><a>파일 다운로드</a></td><td>22.11.23</td></tr>";
					 htmlCode += "<tr><td>가족관계증명서</td><td><a>파일 다운로드</a></td><td>22.11.23</td></tr>";
					 htmlCode += "</table>";
					 
					 resultHt.html(htmlCode);
					 htmlCode2 += "<button type='button' id='open-modal' class='btn mb-2 btn-outline-info' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3' data-toggle='modal' data-target='#DocModal' data-whatever='@mdo'></span></button>";
					 resultHt2.html(htmlCode2);
				 }
			 },
	         error: function () {
	            console.error("데이터를 가져오는 중에 오류가 발생했습니다.");
	            
	            let htmlCode = "";
	            let htmlCode2 = "";
	            
	            htmlCode += "<table width='70%' style='font-size: 15px; margin: 10px;'>";
				htmlCode += "<tr colspan='2' style='font-size: 20px; font-weight: bold;'>";
				htmlCode += "<td style='padding-bottom: 20px;'>문서</td>";
				htmlCode += "</tr>";
				htmlCode += "<tr>";
				htmlCode += "<td>데이터 없음</td>";
				htmlCode += "</tr>";
				htmlCode += "</table>";
	            resultHt.html(htmlCode);
	            htmlCode2 += "<button type='button' id='open-modal' class='btn mb-2 btn-outline-info' style='width: 35px; height: 35px; margin-left: 270px;'><span class='fe fe-24 fe-edit-3' data-toggle='modal' data-target='#DocModal' data-whatever='@mdo'></span></button>";
				resultHt2.html(htmlCode2);
	         }
		 });
	});
	
	//커스텀 정보
// 	$("#resultInfo6").on("click",function(){
// 		 $.ajax({
// 			 url:"/common/selectEmp",
// 			 type:"get",
// 			 data: { empNo: loadedEmpNo }, // empNo 값을 전달
// 			 dataType:"json",
// 			 success:function(result){
// 				 console.log("통신결과",result);
// 				 let htmlCode = "";
// 				 resultHt.html(htmlCode);
// 			 },
// 	         error: function () {
// 	            console.error("데이터를 가져오는 중에 오류가 발생했습니다.");
// 	         }
// 		 });
// 	});
	
	//파일미리보기
	$myFile.on("change",()=>{
		var formData = new FormData();
		formData.append("file",$myFile[0].files[0]);

		$.ajax({
              type : "post",
              url : "/common/preview",
              data : formData,    //JSON.stringify 하지 않음에 주의!
              contentType:false,  //defult값이 application/x-www-form-urlencoded
              processData:false,  //defult값이 application/x-www-form-urlencoded
              cache:false,        //요건 선택 권장!
              dataType : "text",
              beforeSend:function(xhr){
			  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			  },
              success : function(rslt){
            	    var newImg = $("#myImg")
            	        .attr("src", rslt)
            	        .css({
            	            width: "180px",
            	            height: "180px"
            	        });
            	    
              },
              error:function(xhr, status, error){
                  console.log("code: " + xhr.status)
                  console.log("message: " + xhr.responseText)
                  console.log("error: " + error);
              }
         });
	});
	
	//이미지 수정
	$update.on("click",()=>{
		var formData = new FormData();
		formData.append("file",$myFile[0].files[0])
		formData.append("empNo",loadedEmpNo)
		$.ajax({
			url:"/common/fileUpdate",
			type:"post",
			data:formData,
            contentType:false,  //defult값이 application/x-www-form-urlencoded
            processData:false,  //defult값이 application/x-www-form-urlencoded
            cache:false,        //요건 선택 권장!
			dataType:"text",
            beforeSend:function(xhr){
  			  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success : function(result){
				if(result!=null || result !=""){
					console.log(result)
					myimg.src = result;
					myprofileImg.src = result;
					swal("프로필사진이 수정되었습니다.", "", "success");
				}
			},
            error:function(xhr, status, error){
                console.log("code: " + xhr.status)
                console.log("message: " + xhr.responseText)
                console.log("error: " + error);
            }
		});
	})
	
	//직인 등록
	$tempFile.on("change",function(){
		var formData = new FormData();
		formData.append("file",$tempFile[0].files[0])
		formData.append("empNo",loadedEmpNo)
		console.log($tempFile[0].files[0],"test : " + loadedEmpNo )
		$.ajax({
			url:"/common/tempUpload",
			type:"post",
			data:formData,
            contentType:false,  //defult값이 application/x-www-form-urlencoded
            processData:false,  //defult값이 application/x-www-form-urlencoded
            cache:false,        //요건 선택 권장!
            dataType:"text",
            beforeSend:function(xhr){
    			  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
  			},
  			success : function(result){
  				if(result!=null || result !=""){
  					swal("직인등록 성공", "", "success");
  				}
  			},
            error:function(xhr, status, error){
                console.log("code: " + xhr.status)
                console.log("message: " + xhr.responseText)
                console.log("error: " + error);
            }
		});
	});
	
	  
})//function
</script>
<script>
$(function() {
	//모달창 업데이트 기능 구현
	//서버에서 발행된 헤더네임과 토큰갑 저장
	const header = '${_csrf.headerName}';
	const token =  '${_csrf.token}';
	//인사정보 모달창 업데이트
	$("#modal1").on("click",function(){
		let formData = new FormData();
		formData.append("empNo",$("input[name='empNum']").val());
		formData.append("entCaseCode",$("select[name='entCaseCode']").val());
		formData.append("entDate",$("input[name='entDate']").val());
		formData.append("stClfCd",$("select[name='stClfCd']").val());
		
		/* formData.append("jcode",$("select[name='jcode']").val());
		formData.append("ptnCode",$("select[name='ptnCode']").val());
		formData.append("grdCode",$("select[name='grdCode']").val());
		formData.append("dcode",$("select[name='dcode']").val());
		formData.append("dtcode",$("select[name='dtcode']").val()); */
		
	    $.ajax({
	    	
	      url: "/common/insaupdate", // 서버 컨트롤러의 URL
	      processData:false,  
	      contentType:false,  
	      data : formData,    
	      type: "post", 
	      dataType:"text",
	      beforeSend:function(xhr){
			xhr.setRequestHeader(header,token);
		  },
	      success: function(response) {
	        console.log("성공했엉!!!", response);
	        swal("수정이 완료되었습니다.", "", "success");
			// 모달을 닫는 버튼을 클릭하여 모달을 닫습니다
            $("#insaclose").click();
            
            // Ajax 요청 성공 시 페이지를 새로고침
            location.reload();
	      },
	      error: function() {
	        console.log("실패했엉!!!");
	        // 오류 처리 로직을 여기에 추가하세요.
	        swal("정보를 정확히 입력주세요!", "", "error");
	      }
	    });
		
	});
	
	$("#modal2").on("click",function(){
		let formData = new FormData();
		formData.append("empNo",$("input[name='empNum']").val());
		formData.append("empNm",$("input[name='empNm']").val());
		formData.append("regn",$("input[name='regn']").val());
		formData.append("empPass",$("input[name='empPass']").val());
		formData.append("empMail",$("input[name='empMail']").val());
		formData.append("cpNo",$("input[name='cpNo']").val());
		formData.append("empAddr1",$("input[name='empAddr1']").val());
		formData.append("empAddr2",$("input[name='empAddr2']").val());
		formData.append("empAddr3",$("input[name='empAddr3']").val());
		
	    $.ajax({
	    	
	      url: "/common/personupdate", // 서버 컨트롤러의 URL
	      processData:false,  
	      contentType:false,  
	      data : formData,    
	      type: "post", 
	      dataType:"text",
	      beforeSend:function(xhr){
			xhr.setRequestHeader(header,token);
		  },
	      success: function(response) {
	        console.log("성공했엉!!!", response);
	        swal("수정이 완료되었습니다.", "", "success");
			// 모달을 닫는 버튼을 클릭하여 모달을 닫습니다
            $("#personclose").click();
            
            // Ajax 요청 성공 시 페이지를 새로고침
            location.reload();
	      },
	      error: function() {
	        console.log("실패했엉!!!");
	        // 오류 처리 로직을 여기에 추가하세요.
	        swal("정보를 정확히 입력해주세요", "", "error");
	      }
	    });
		
	});
	$("#modal3").on("click",function(){
		let formData = new FormData();
		formData.append("empNo",$("input[name='empNum']").val());
		formData.append("ctrtCaseCode",$("select[name='ctrtCaseCode']").val());
		formData.append("blctSdate",$("input[name='blctSdate']").val());
		formData.append("blctEdate",$("input[name='blctEdate']").val());
		formData.append("bcntAmt",$("input[name='bcntAmt']").val());
		formData.append("bwctSdate",$("input[name='bwctSdate']").val());
		formData.append("bwctEdate",$("input[name='bwctEdate']").val());
		
	    $.ajax({
	    	
	      url: "/common/cnthxupdate", // 서버 컨트롤러의 URL
	      processData:false,  
	      contentType:false,  
	      data : formData,    
	      type: "post", 
	      dataType:"text",
	      beforeSend:function(xhr){
			xhr.setRequestHeader(header,token);
		  },
	      success: function(response) {
	        console.log("성공했엉!!!", response);
	        swal("수정이 완료되었습니다.", "", "success");
			// 모달을 닫는 버튼을 클릭하여 모달을 닫습니다
            $("#cnthxclose").click();
            
            // Ajax 요청 성공 시 페이지를 새로고침
            location.reload();
	      },
	      error: function() {
	        console.log("실패했엉!!!");
	        // 오류 처리 로직을 여기에 추가하세요.
	        swal("정보를 정확히 입력해주세요", "", "error");
	      }
	    });
		
	});
	
	$("#modal4").on("click",function(){
		let formData = new FormData();
		formData.append("empNo",$("input[name='empNum']").val());
		formData.append("acNm",$("input[name='acNm']").val());
		formData.append("acEtdate",$("input[name='acEtdate']").val());
		formData.append("acEdate",$("input[name='acEdate']").val());
		formData.append("gradClf",$("input[name='gradClf']").val());
		formData.append("maj",$("input[name='maj']").val());
		formData.append("caNm",$("input[name='caNm']").val());
		formData.append("caCntcase",$("input[name='caCntcase']").val());
		formData.append("caEtdate",$("input[name='caEtdate']").val());
		formData.append("caEdate",$("input[name='caEdate']").val());
		formData.append("caDept",$("input[name='caDept']").val());
		formData.append("caJob",$("input[name='caJob']").val());
		formData.append("caDuty",$("input[name='caDuty']").val());
		formData.append("caGrd",$("input[name='caGrd']").val());
		
	    $.ajax({
	    	
	      url: "/common/acca", // 서버 컨트롤러의 URL
	      processData:false,  
	      contentType:false,  
	      data : formData,    
	      type: "post", 
	      dataType:"text",
	      beforeSend:function(xhr){
			xhr.setRequestHeader(header,token);
		  },
	      success: function(response) {
	        console.log("성공했엉!!!", response);
	        swal("수정이 완료되었습니다.", "", "success");
			// 모달을 닫는 버튼을 클릭하여 모달을 닫습니다
            $("#accaclose").click();
            
            // Ajax 요청 성공 시 페이지를 새로고침
            location.reload();
	      },
	      error: function() {
	        console.log("실패했엉!!!");
	        // 오류 처리 로직을 여기에 추가하세요.
	        swal("정보를 정확히 입력해주세요", "", "error");
	      }
	    });
		
	});
	
	
});


</script> 


<script>
$(function() {
	$("#file").on("change", function() {
	    $("#update").css("display", "block");
	});
	
	
});

</script>
<script>
//핸드폰 번호 복사
function copyPhNo() {
    // 텍스트 입력란의 값을 가져옵니다.
    var text = document.getElementById("textToPhNoCopy");

    // 텍스트를 클립보드에 복사합니다.
    text.select();
    document.execCommand("copy");

    // 복사가 완료되면 메시지를 표시합니다.
    swal("텍스트 복사 복사", "", "success");
}

</script>
<script>
//전화번호 복사
    function copyPhNo(val) {
    var t = document.createElement("textarea");
    document.body.appendChild(t);
    t.value = val;
    t.select();
    document.execCommand('copy');
    document.body.removeChild(t);
    swal("전화번호 복사", "", "success");
    }
//이메일 주소 복사
    function copyEmail(val) {
    var t = document.createElement("textarea");
    document.body.appendChild(t);
    t.value = val;
    t.select();
    document.execCommand('copy');
    document.body.removeChild(t);
    swal("이메일 복사 복사", "", "success");
    }
</script>
<style>
div{
/* border: 1px solid red; */
}
a{text-decoration: none; color:black}
#menuBar{list-style: none;}
#menuBar li{display: inline; margin: 20px;}

.preImg {
    margin: 20px;
    margin-right: 40px;
}
.det {
	margin: 10px;
}
#myImg {
    height: 180px;
    width: 180px;
    border-radius: 40px;
    
}
#upd {
    height: 40px;
    width: 40px;
}
#overlay
{
    padding:10px;
    position: absolute;
    margin-left: 140px;
    margin-top: 140px;
    color: aliceblue;
    background-color: rgb(75, 75, 236);
    border-radius: 40px;
    cursor:pointer;
}
table {
    border-collapse: separate; /* 셀 간의 여백을 사용하도록 설정 */
}

tr{
	
}
td {
    padding: 7px; /* 셀 내용 주위의 여백을 설정 */
    line-height: 1; /* 줄 간격을 조절 */
}
//현학이 버튼 스타일
.mainBtn {
   background: linear-gradient(to right, #05CA1B, #11C2C0);
   border-radius: 10px;
   padding: 10px 20px;
    color: white;
    cursor: pointer;
    border: none;
}




//모달창 버튼




</style>



    <div>
        <h6>구성원/${vo.empNm}</h6>
    </div>

    <div>
        <div style="margin: 20px; position: relative; display: flex; align-items: stretch; width: 100%;">
            <div id="preImg" style="display: flex; justify-content: center;">
				    <c:choose>
				        <c:when test="${vo.fileList[0].svfiName }">
				        
				        <c:set var="oneBreak" value="false" />
						<c:forEach items="${authentication.authorities}" var="authority">
						    <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
						        <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 75 && oneBreak eq false}">
									<span id="overlay" class="fe fe-24 fe-camera" onclick="document.getElementById('file').click()"></span>
						            <c:set var="oneBreak" value="true" />
						        </c:if>
						    </c:forEach>
						</c:forEach>
				        	
				        	
				            <img id="myImg" src="/resources/images/insight-basic50x50.png" alt="프로필사진">
				        </c:when>
				        
				        <c:otherwise>
				        <c:set var="oneBreak" value="false" />
						<c:forEach items="${authentication.authorities}" var="authority">
						    <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
						        <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 75 && oneBreak eq false}">
									<span id="overlay" class="fe fe-24 fe-camera" onclick="document.getElementById('file').click()"></span>
						        </c:if>
						    </c:forEach>
						</c:forEach>
				            <img id="myImg" src="${vo.fileList[0].svfiName }" alt="프로필사진" onerror="this.src='/resources/images/insight-basic50x50.png'">
				        </c:otherwise>
				    </c:choose>
<%--                  <img id="myImg" src="${vo.fileList[0].svfiName }" alt="프로필사진">                --%>
				
                 <input type="file" name="file" id="file" style="display:none;"> 
            </div>
            
			
            <div class="det" style="margin-left: 50px;">
                <div id="nm" style="">
                    <h3>${vo.empNm}</h3>
                </div>
                <div id="if">
                    <p style="margin-bottom: 5px; margin-top: 10px;">직책 : ${vo.dtCodeNm}</p>
                    <p style="margin-bottom: 5px; margin-top: 5px;">직무 : ${vo.jcodeNm}</p>
                    <p style="margin-bottom: 5px; margin-top: 5px;">재직상태 : 
	                    <c:choose>
			              <c:when test="${vo.stClfCdNm eq '재직중'}">
			                <span class="badge badge-pill badge-primary" style="color: white;">재직중</span>
			              </c:when>
			              <c:when test="${vo.stClfCdNm eq '휴직중' }">
			                <span class="badge badge-pill badge-warning" style="color: white;">휴직중</span>
			              </c:when>
			            </c:choose>
                    </p>
                </div>
                <div id="butn" style="position: relative; display: flex; align-items: stretch; width: 100%; margin-top: 30px;">
                    <input class="btn mb-2 btn-outline-primary" style="margin-right: 5px; display: none;" id="update" type="button" value="이미지 수정완료">
                    <button class="btn mb-2 btn-outline-success" style="margin-right: 5px;" onclick="copyPhNo('${vo.cpNo}')"><span class="fe fe-24 fe-phone"></span></button> 
                    <button class="btn mb-2 btn-outline-success" style="margin-right: 5px;" onclick="copyEmail('${vo.empMail}')"><span class="fe fe-24 fe-mail"></span></button>
<%--                     <button class="btn btn-primary btn-icon-split btn-sm" style="margin-right: 5px;"><span>${vo.stClfCdNm}</span></button> --%>
				        <c:set var="oneBreak" value="false" />
						<c:forEach items="${authentication.authorities}" var="authority">
						    <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
						        <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 75 && oneBreak eq false}">
									<label class="btn mb-2 btn-outline-danger" for="tempFile" style="margin-left:5px; text-align: justify;">직인등록</label>
						        <c:set var="oneBreak" value="true" />
						        </c:if>
						    </c:forEach>
						</c:forEach>
                    
                    <input type="file" id="tempFile" name="tempFile" style="display:none;">
                </div>
            </div>
        </div>
    </div> 
	<nav id="menuBar">
	
		<ul class="nav nav-tabs mb-3" id="myTab" role="tablist" style="display: flex;">
						<li><a id="resultInfo1" href="#"><h3>인사 정보</h3></a></li>
						
			<c:set var="oneBreak" value="false" />
			<c:forEach items="${authentication.authorities}" var="authority">
			 	<c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
			        <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 71  && oneBreak eq false || loginNo == empNo && oneBreak eq false }">
						<li><a id="resultInfo2" href="#"><h3>개인 정보</h3></a></li>
			        <c:set var="oneBreak" value="true" />
			        </c:if>
			    </c:forEach>
			</c:forEach>
			<c:set var="oneBreak" value="false" />
			<c:forEach items="${authentication.authorities}" var="authority">
			    <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
			        <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 72  && oneBreak eq false || loginNo == empNo && oneBreak eq false }">
						<li><a id="resultInfo3" href="#"><h3>계약 정보</h3></a></li>
			        <c:set var="oneBreak" value="true" />
			        </c:if>
			    </c:forEach>
			</c:forEach>
			<c:set var="oneBreak" value="false" />
			<c:forEach items="${authentication.authorities}" var="authority">
			    <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
			        <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 73  && oneBreak eq false || loginNo == empNo && oneBreak eq false }">
						<li><a id="resultInfo4" href="#"><h3>경력/학력</h3></a></li>
			        <c:set var="oneBreak" value="true" />
			        </c:if>
			    </c:forEach>
			</c:forEach>
			<c:set var="oneBreak" value="false" />
			<c:forEach items="${authentication.authorities}" var="authority">
			    <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
			        <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 74  && oneBreak eq false || loginNo == empNo && oneBreak eq false }">
						<li><a id="resultInfo5" href="#"><h3>문서</h3></a></li>
			        <c:set var="oneBreak" value="true" />
			        </c:if>
			    </c:forEach>
			</c:forEach>
		
		
			
			
			
			
<!-- 			<li><a id="resultInfo6" href="#"><h3>커스텀 정보</h3></a></li> -->
		</ul>
	</nav>
	 <div class="card shadow">
       <div class="card-body">
		<div class="row" style="max-height: 450px; overflow-y: scroll;">
		  <div style="margin: 20px; position: relative; display: flex; align-items: stretch; width: 100%;">
	       <div id="result" class="col-8" ></div>
	       <div id="result2" >
	       	
	       </div>
	     </div>
	    </div>
	  </div>
	</div>   
	 
	<div class="card shadow">
		<!-- 인사정보 모달창-->           
		<div class="modal fade" id="insaModal" tabindex="-1" role="dialog" aria-labelledby="varyModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog" role="document">
			<div class="modal-content" style="width: 620px; position: relative;">
				<div class="modal-header">
				<h5 class="modal-title" id="varyModalLabel" style="margin-left: 10px;">인사/근무정보 수정</h5>
							
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				</div>
				<div class="modal-body">
				<form>
					<input type="hidden" class="form-control" name="empNum" value="${vo.empNo}"  />
					<div class="card-body">
					  <div class="row">
						<div class="form-group" style="margin-right: 10px;">
							<fmt:formatDate value="${vo.entDate}" pattern="yyyy-MM-dd" var="formattedDate" />
							<label for="recipient-name" class="col-form-label" >입사일:</label>
							<input type="date" id="simpleinput" class="form-control" name="entDate" value="${formattedDate}" />
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">입사유형:</label>
							<select class="form-control" id="example-select" name="entCaseCode" >
					            <option value="${vo.entCaseCode}">등록된 입사유형 : ${vo.entCaseNm}</option>
				                <c:forEach items="${cmCodelist}" var="code">
					               <c:if test="${code.cmGroup eq 'join'}">
					               	 <c:if test="${code.cmNm != '입사유형코드'}">
					               	 	<option value="${code.cmCode}">${code.cmNm}</option>
					               	 </c:if>
					               </c:if>
								</c:forEach>    
				            </select>
							
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">재직상태:</label>
							<select class="form-control" id="example-select1-2" name="stClfCd">
					            <option value="${vo.stClfCd}">등록된 재직상태 : ${vo.stClfCdNm}</option>
								<c:forEach items="${cmCodelist}" var="code">
					              <c:if test="${code.cmGroup eq 'tenure'}">
								  	<c:if test="${code.cmNm != '재직상태코드'}">
					               	 <option value="${code.cmCode}">${code.cmNm}</option>
					                </c:if>
					              </c:if>
								</c:forEach>        
				            </select>
						 </div>
					  </div>
					</div>
					<%-- <div id="person" style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 100%;">
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">조직:</label>
							<select class="form-control" id="example-select5" name="dcode"> 
								<option value="${vo.dcode}">등록된 조직 : ${vo.deptVOList.dnm}</option>
			                	<c:forEach items="${deptlist}" var="list">
			                			<option value="${list.dcode}">${list.dnm}</option>
			                	</c:forEach>			
			                 </select>
						 </div>
						 <div class="form-group" style="margin-right: 10px;">
							 <label for="recipient-name" class="col-form-label">직책:</label>
			                 <select class="form-control" id="example-select6" name="dtcode" >                 
							   <option value="${vo.dtcode}">등록된 직책 : ${vo.dtCodeNm}</option>
		                	   <c:forEach items="${cmCodelist}" var="code">
		                		 <c:if test="${code.cmGroup eq 'position'}">
		                		   <c:if test="${code.cmNm != '직책코드'}">
		                		 	 <option value="${code.cmCode}">${code.cmNm}</option>
		                		   </c:if>
		                		 </c:if>
		                	   </c:forEach>			
			                 </select>
						 </div>
						 <div class="form-group" style="margin-right: 10px;">
						 	 <label for="recipient-name" class="col-form-label">직무:</label>
							 <select class="form-control" id="example-select2" name="jcode">
							     <option value="${vo.jcode}">등록된 직무 : ${vo.jcodeNm}</option>
			                	 <c:forEach items="${cmCodelist}" var="code">
			                		 <c:if test="${code.cmGroup eq 'job'}">
			                		   <c:if test="${code.cmNm != '직무코드'}">
			                			 <option value="${code.cmCode}">${code.cmNm}</option>
			                		   </c:if>
			                		 </c:if>
			                	 </c:forEach>			
			                 </select>
						 </div>
					</div>
					<div style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 100%;">
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">직위:</label>
							<select class="form-control" id="example-select3" name="ptnCode">
							    <option value="${vo.ptnCode}">등록된 직위 : ${vo.ptnCodeNm}</option>
			                	<c:forEach items="${cmCodelist}" var="code">
			                		<c:if test="${code.cmGroup eq 'spot'}">
			                		  <c:if test="${code.cmNm != '직위코드'}">
			                			<option value="${code.cmCode}">${code.cmNm}</option>
			                		  </c:if>
			                		</c:if>
			                	</c:forEach>			
			                </select>
						</div>
						 <div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">직급</label>
							<select class="form-control" id="example-select4" name="grdCode">
							    <option value="${vo.grdCode}">등록된 직급 : ${vo.grdCodeNm}</option>
			                	<c:forEach items="${cmCodelist}" var="code">
			                		<c:if test="${code.cmGroup eq 'hobong'}">
			                		  <c:if test="${code.cmNm != '직급코드(호봉)'}">
			                			<option value="${code.cmCode}">${code.cmNm}</option>
			                		  </c:if>
			                		</c:if>
			                	</c:forEach>			
			                </select>
						</div>  
					</div>
					<div style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 100%;">
						<div class="form-group" style="margin-right: 10px;">
							<label>출근시간</label>
							<input type="text" class="form-control" id="recipient-name" value="${vo.whStime}">
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<label>퇴근 시간</label>
							<input type="text" class="form-control" id="recipient-name" value="${vo.whEtime}">
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<label>총 근무시간</label>
							<input type="text" class="form-control" id="recipient-name" value="${vo.whTltime}">
						</div>
					</div>--%>
					
				</form>
				</div>
				<div class="modal-footer">
				<button type="button" class="btn mb-2 btn-secondary" data-dismiss="modal" >닫기</button>
				<button type="button" class="btn mb-2 btn-primary" id="modal1">수정하기</button>
				</div>
			</div>
			</div>
		</div>

		<!-- 개인정보 모달창-->
		<div class="modal fade" id="varyModal" tabindex="-1" role="dialog" aria-labelledby="varyModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog" role="document">
			<div class="modal-content" style="width: 700px;">
				<div class="modal-header">
				<h5 class="modal-title" id="varyModalLabel" style="margin-left: 10px;">개인정보 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				</div>
				<div class="modal-body">
				<form>
					<div id="person" style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 800%;">
					<div class="form-group" style="margin-right: 10px;">
						<label for="recipient-name" class="col-form-label" >사번:</label>
						<input type="text" class="form-control" id="recipient-name" name="empNum" value="${vo.empNo}" readonly>
					</div>
					<div class="form-group" style="margin-right: 10px;">
						<label for="recipient-name" class="col-form-label">이름:</label>
						<input type="text" class="form-control" id="recipient-name" name="empNm" value="${vo.empNm}" readonly>
					</div>
					<div class="form-group" style="margin-right: 10px;">
						<label for="recipient-name" class="col-form-label">주민번호:</label>
						<input type="text" class="form-control" id="recipient-name" name="regn" value="${vo.regn}" readonly>
					</div>
					</div>
					<div style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 100%;">
					<div class="form-group" style="margin-right: 10px;">
						<label for="recipient-name" class="col-form-label">비번:</label>
						<input type="password" class="form-control" id="recipient-name" name="empPass" value="1234">
					</div>
<%-- 					${vo.empPass} --%>
					<div class="form-group" style="margin-right: 10px;">
						<label for="recipient-name" class="col-form-label">e-mail:</label>
						<input type="text" class="form-control" id="recipient-name" name="empMail" value="${vo.empMail}">
					</div>
					<div class="form-group" style="margin-right: 10px;">
						<label>휴대폰 번호:</label>
						<input type="text" class="form-control" id="recipient-name" name="cpNo" value="${vo.cpNo}">
					</div>
					</div>
					<div style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 100%;">
						
						<div class="form-group mb-3" style="margin-right: 20px;"> <!-- Add margin-right here -->
						  <label>주소</label>
				          <input type="text" name="empAddr1" class="form-control" id="sample6_postcode" name="empAddr1" placeholder="우편번호" value="${vo.empAddr1}">
							<input type="button"  onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
							<input type="text" name="empAddr2" class="form-control" id="sample6_address" name="empAddr2" placeholder="주소" value="${vo.empAddr2}">
							<input type="text" name="empAddr3" class="form-control" id="sample6_detailAddress" name="empAddr3" placeholder="상세주소" value="${vo.empAddr3}">
							<input type="text" class="form-control"  id="sample6_extraAddress" placeholder="참고항목">
						</div>
					</div>
					
				</form>
				</div>
				<div class="modal-footer">
				<button type="button" class="btn mb-2 btn-secondary" id="personclose" data-dismiss="modal" >닫기</button>
				<button type="button" class="btn mb-2 btn-primary" id="modal2">수정하기</button>
				</div>
			</div>
			</div>
		</div>
		
		<!-- 계약정보 모달창-->
		<div class="modal fade" id="cnthxModal" tabindex="-1" role="dialog" aria-labelledby="varyModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog" role="document">
			<div class="modal-content" style="width: 700px;">
				<div class="modal-header">
				<h5 class="modal-title" id="varyModalLabel" style="margin-left: 10px;">근로/임금계약 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				</div>
				<div class="modal-body">
				<form>
					<div id="person" style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 800%;">
					<div class="form-group" style="margin-right: 10px;">
						<label for="recipient-name" class="col-form-label" >계약유형:</label>
						<input type="hidden" class="form-control" id="recipient-name" name="empNum" value="${vo.empNo}">
						<select class="form-control" id="example-select4"  name="ctrtCaseCode">
						    <option value="${vo.ctrtCaseCode}">등록된 계약유형 : ${vo.ctrtCaseNm}</option>
		                	<c:forEach items="${cmCodelist}" var="code">
		                		<c:if test="${code.cmGroup eq 'contract'}">
		                		  <c:if test="${code.cmNm != '계약유형코드'}">
		                			<option value="${code.cmCode}">${code.cmNm}</option>
		                		  </c:if>
		                		</c:if>
		                	</c:forEach>			
		                </select>
						
					</div>
					<div class="form-group" style="margin-right: 10px;">
						<fmt:formatDate value="${cnthxVO.blctSdate}" pattern="yyyy-MM-dd" var="formattedDate1" />
						<label for="recipient-name" class="col-form-label">근로계약 시작일:</label>
						<input type="date" class="form-control" id="recipient-name" name="blctSdate" value="${formattedDate1}" >
					</div>
					<div class="form-group" style="margin-right: 10px;">
						<fmt:formatDate value="${cnthxVO.blctEdate}" pattern="yyyy-MM-dd" var="formattedDate2" />
						<label for="recipient-name" class="col-form-label">근로계약 종료일:</label>
						<input type="date" class="form-control" id="recipient-name" name="blctEdate" value="${formattedDate2}" >
					</div>
					</div>
					<div style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 100%;">
					<div class="form-group" style="margin-right: 10px;">
						<label for="recipient-name" class="col-form-label">계약금액:</label>
						<input type="text" class="form-control" id="recipient-name" name="bcntAmt" value="${cnthxVO.bcntAmt}">
					</div>
					<div class="form-group" style="margin-right: 10px;">
						<fmt:formatDate value="${cnthxVO.bwctSdate}" pattern="yyyy-MM-dd" var="formattedDate3" />
						<label for="recipient-name" class="col-form-label">임금계약 시작일:</label>
						<input type="date" class="form-control" id="recipient-name" name="bwctSdate" value="${formattedDate3}">
					</div>
					<div class="form-group" style="margin-right: 10px;">
						<fmt:formatDate value="${cnthxVO.bwctEdate}" pattern="yyyy-MM-dd" var="formattedDate4" />
						<label for="recipient-name" class="col-form-label">임금계약 종료일:</label>
						<input type="date" class="form-control" id="recipient-name" name="bwctEdate" value="${formattedDate4}">
					</div>
					</div>
					
				</form>
				</div>
				<div class="modal-footer">
				<button type="button" class="btn mb-2 btn-secondary" id="cnthxclose" data-dismiss="modal">닫기</button>
				<button type="button" class="btn mb-2 btn-primary"  id="modal3">수정하기</button>
				</div>
			</div>
			</div>
		</div>
		
		<!-- 커리어 모달창-->
		<div class="modal fade" id="careerModal" tabindex="-1" role="dialog" aria-labelledby="varyModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog" role="document">
			<div class="modal-content" style="width: 700px;">
				<div class="modal-header">
				<h5 class="modal-title" id="varyModalLabel" style="margin-left: 10px;">학력/경력 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				</div>
				<div class="modal-body">
				<form>
					<div id="person" style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 800%;">
						<div class="form-group" style="margin-right: 10px;">
							<input type="hidden" class="form-control" id="recipient-name" name="empNum" value="${vo.empNo}">
							<label for="recipient-name" class="col-form-label" >학교명:</label>
							<input type="text" class="form-control" id="recipient-name" name="acNm" value="${accaVO.acNm}">
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<fmt:formatDate value="${accaVO.acEtdate}" pattern="yyyy-MM-dd" var="formattedDate5" />
							<label for="recipient-name" class="col-form-label">입학일자:</label>
							<input type="date" class="form-control" id="recipient-name" name="acEtdate" value="${formattedDate5}">
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<fmt:formatDate value="${accaVO.acEdate}" pattern="yyyy-MM-dd" var="formattedDate6" />
							<label for="recipient-name" class="col-form-label">졸업일자:</label>
							<input type="date" class="form-control" id="recipient-name" name="acEdate" value="${formattedDate6}">
						</div>
					</div>
					<div style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 100%;">
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">졸업여부:</label>
							<select class="form-control" id="example-select4"  name="gradClf">
						    <option value="${accaVO.gradClf}">등록된 계약유형 : ${accaVO.gradClfNm}</option>
		                	<c:forEach items="${cmCodelist}" var="code">
		                		<c:if test="${code.cmGroup eq 'graduate'}">
		                		  <c:if test="${code.cmNm != '졸업구분코드'}">
		                			<option value="${code.cmCode}">${code.cmNm}</option>
		                		  </c:if>
		                		</c:if>
		                	</c:forEach>			
		                </select>
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">전공:</label>
							<input type="text" class="form-control" id="recipient-name" name="maj" value="${accaVO.maj}">
						</div>
					</div>
					
					<div id="person" style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 800%;">
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label" >회사명:</label>
							<input type="text" class="form-control" id="recipient-name" name="caNm" value="${careerVO.caNm}">
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<fmt:formatDate value="${careerVO.caEtdate}" pattern="yyyy-MM-dd" var="formattedDate5" />
							<label for="recipient-name" class="col-form-label">입사일자:</label>
							<input type="date" class="form-control" id="recipient-name" name="caEtdate" value="${formattedDate5}">
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<fmt:formatDate value="${careerVO.caEdate}" pattern="yyyy-MM-dd" var="formattedDate6" />
							<label for="recipient-name" class="col-form-label">퇴사일자:</label>
							<input type="date" class="form-control" id="recipient-name" name="caEdate" value="${formattedDate6}">
						</div>
					</div>
					<div style="margin: 10px; position: relative; display: flex; align-items: stretch; width: 100%;">
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">계약유형:</label>
							<input type="text" class="form-control" id="recipient-name" name="caCntcase" value="${careerVO.caCntcase}">
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">부서:</label>
							<input type="text" class="form-control" id="recipient-name" name="caDept" value="${careerVO.caDept}">
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">직책:</label>
							<input type="text" class="form-control" id="recipient-name" name="caDuty" value="${careerVO.caDuty}">
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">직무:</label>
							<input type="text" class="form-control" id="recipient-name" name="caJob" value="${careerVO.caJob}">
						</div>
						<div class="form-group" style="margin-right: 10px;">
							<label for="recipient-name" class="col-form-label">직위:</label>
							<input type="text" class="form-control" id="recipient-name" name="caGrd" value="${careerVO.caGrd}">
						</div>
					</div>
					
				</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn mb-2 btn-secondary" id="accaclose">닫기</button>
					<button type="button" class="btn mb-2 btn-primary"  id="modal4">수정하기</button>
				</div>
			</div>
			</div>
		</div>
		
	</div>
	



<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 주소 검색 함수
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>


