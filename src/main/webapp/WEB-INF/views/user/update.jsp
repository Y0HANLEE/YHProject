<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>	
<title>회원정보수정</title>
<%@ include file="../includes/header.jsp"%>

<!-- 본문-->
<div class="row">
	<div id="userCol12" class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading"><i class="fa fa-user fa-fw"></i><strong><c:out value="${user.name}"/></strong><c:choose><c:when test="${auth.auth == '1'}">(관리자)</c:when><c:when test="${auth.auth == '2'}">(운영자)</c:when><c:when test="${auth.auth == '3'}">(일반회원)</c:when></c:choose>님의 회원정보 수정페이지</div>
			<div class="panel-body">			
				<div id="userCol6left" class="col-lg-6" align="center">
					<label id="update_ProfileLabel" for="singleFile">프로필사진</label><br>		
					<div id="update_ProfileFrame" class="uploadProfile">
   						<!-- profile image -->    					
   					</div>	
   					<form id="profileInfoForm" method="post" action="/user/update">
						<input type="hidden" name="profileImg.uploadPath" value="${user.profileImg.uploadPath}">
						<input type="hidden" name="profileImg.uuid" value="${user.profileImg.uuid}">
						<input type="hidden" name="profileImg.fileName" value="${user.profileImg.fileName}">
						<input type="hidden" name="profileImg.fileType" value="true"> 
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>					
					<form id="profileForm" action="/uploadSingle" method="post" enctype="multipart/form-data">										
						<div id="profileZone" class="form-group">
							<input id="singleFile" class="form-control" name="singleFile" type="file"> <!-- 파일 선택 -->
							<button id="findImgBtn" class="btn btn-default">찾아보기</button>
							<button id="resetImgBtn" class="btn btn-default">원래대로</button>
							<button id="removeImgBtn" class="btn btn-default">사진삭제</button>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						</div>
					</form>					
				</div>
				<div class="col-lg-6">			
				<form method="post" action="/user/update" id="updateForm">					
					<div class="form-group">						
						<p><label for="userid">아이디</label></p>
						<input class="form-control" name="userid" id="userid" value="${user.userid}" readonly>							
					</div>							
					<div class="form-group">
						<label for="name">이름</label>
						<input class="form-control" name="name" value="${user.name}" readonly>						
					</div>
					<div class="form-group">
						<label for="gender">성별</label>
						<input class="form-control" name="gender" value="${user.gender=='M'?'남자':'여자'}" readonly>
					</div>
					<div class="form-group">
						<label for="phone">전화번호</label>
						<input class="form-control" name="phone" value="${user.phone}">
					</div>
					<div class="form-group">
						<label for="email">이메일</label>
						<input class="form-control" type="email" name="email" value="${user.email}">
					</div>
					<div class="form-group">
							<label for="address">주소</label>
						<div id="addressZone">
							<input id="zonecode" class="form-control" name="zonecode" placeholder="우편번호" value="${user.zonecode}" readonly>&nbsp;&nbsp;
							<button id="searchAddressBtn" class="btn btn-default">주소찾기</button>						
						</div>
						<input id="address_kakao" class="form-control" name="address" value="${user.address}" readonly>
						<input class="form-control" name="addressDetail" placeholder="상세주소" value="${user.addressDetail}" >
					</div>
					<div class="form-group">
						<label for="birth">생년월일</label>
						<input class="form-control" name="birth" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${user.birth}'/>" readonly>
					</div>					
					<div id="buttonZone" class="form-group">
						<button id="updateBtn" class="btn btn-lg btn-info btn-lg">수정완료</button>
						<button id="passBtn" class="btn btn-lg btn-default btn-lg">비밀번호변경</button>						
						<button id="backBtn" class="btn btn-lg btn-default btn-lg" onclick="history.back()">뒤로가기</button>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				</div>
			</div>
		</div>
	</div>
</div>	
<!-- Modal -->
<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"> 
				<h4 class="modal-title">알림</h4> 
			</div>
			<div class="modal-body">
				<!--checkBlank()-->
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>
<div id="updatePwModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"> 
				<h3 class="modal-title">비밀번호변경</h3> 
			</div>
			<form id="updatePwForm" method="post" action="/user/updatePw">
			<div class="modal-body">
		    	<div class="form-group">
			        <label for="oldPw">기존 비밀번호</label>
			        <input id="oldPw" class="form-control" name="oldPw" type="password">
		    	</div>        
		    	<div class="form-group">
			        <label for="newPw">새 비밀번호</label>
			        <input id="newPw" class="form-control" name="newPw" type="password">
		        </div>
		        <div class="form-group">
			        <label for="pwconfirm">새 비밀번호 확인</label>
			        <input id="pwconfirm" class="form-control" name="pwconfirm" type="password">
		        </div>			       			        
		    </div>
			<div class="modal-footer" align="center">
				<button id="upPwBtn" class="btn btn-lg btn-success btn-lg">수정</button>
				<button id="closeBtn" class="btn btn-lg btn-default btn-lg">취소</button>			       	
			</div>
	        <input type="hidden" id="pwUpUserid" name="userid" value="${user.userid}">
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		    </form>
		</div>
	</div>
</div>
<!-- KAKAO주소 -->
<script>
window.onload = function(){
    document.getElementById("searchAddressBtn").addEventListener("click", function(e){
    	e.preventDefault();
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
            	document.getElementById("zonecode").value = data.zonecode; // 우편번호 넣기
                document.getElementById("address_kakao").value = data.address; // 주소 넣기
                $("input[name='addressDetail']").focus(); //상세입력 포커싱
            }        
        }).open();
    
        new daum.Postcode({
            onclose: function(state) {if(state === 'FORCE_CLOSE'){} else if(state === 'COMPLETE_CLOSE'){}}
        });
    });
}
</script>
<!-- 본문 -->
<script type="text/javascript">
$(document).ready(function(){
	/*페이지 로드시 모달창*/
	var result = '<c:out value="${result}"/>';	
	checkModal(result);
	
	// 회원정보 수정완료 알림
	function checkModal(result) {
		if(result === "" || history.state){ 
			return;
		}				
		$(".modal-title").html("Success");
		$(".modal-body").html(result);
		$(".modal-footer").html('<button class="btn btn-default" data-dismiss="modal">Close</button>');
		$("#myModal").modal("show");
		setTimeout(function() { $("#myModal").modal("hide"); }, 800);		
	}
	
	/* 뒤로가기 문제해결 */
	history.replaceState({},null,null);	
	
	/* 수정완료버튼 */
	$("#updateBtn").on("click", function(e){
		e.preventDefault();
		checkInfo();// 수정 정보 유효성 검사 실행
	});
		
	/* 비밀번호 변경 버튼 */
	$("#passBtn").on("click", function(e){
		e.preventDefault();
		$("#updatePwModal").modal("show");
	});
		
	// 비밀번호 변경 모달 - 변경 버튼
	$("#updatePwModal").on("click", "#upPwBtn", function(e){
    	e.preventDefault();
		console.log("-------------------");			
		
		var userid = $("#pwUpUserid").val();	
		
		var oldPw = $("#oldPw").val();
		var newPw = $("#newPw").val();		
		var pwconfirm = $("#pwconfirm").val();
		var reg_pw = /(?=.*[0-9])(?=.*[a-zA-Z])(?=.*?[!@#$%^&*]).{6,12}/;	
		
		if(oldPw === ""){
			alert("비밀번호를 입력해주세요.");
			$("input[name='oldPw']").focus();
			return
		} // 비밀번호 초기화시 특수문자 포함x >> 정규표현식 검증x
		
		if(newPw === ""){
			alert("새 비밀번호를 입력해주세요.");
			$("input[name='newPw']").focus();
			return
		}else if(!reg_pw.test(newPw)){
			alert("비밀번호는 숫자,영문자,특수문자(!,@,#,$,%,^,&,*)를 포함한 6~12자로 작성해주세요");
			$("input[name='newPw']").focus();
	        return;
    	}
		
		if(pwconfirm === "") {
			alert("새 비밀번호 확인란을 입력해주세요.");
			$("input[name='pwconfirm']").focus();
			return;
		} else if(!reg_pw.test(pwconfirm)){
			alert("비밀번호는 숫자,영문자,특수문자(!,@,#,$,%,^,&,*)를 포함한 6~12자로 작성해주세요");
			$("input[name='pwconfirm']").focus();
	        return;
    	}
		
		$.ajax({
			url:"/user/checkUser",
			type:"POST",
			data:JSON.stringify({"userid":userid, "userpw":oldPw}),
			dataType:"json",
			contentType:"application/json; charset=UTF-8",										
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(data){
				if(data === 1){										
					if (newPw === pwconfirm) {	
						alert("success");
						$("#updatePwForm").submit();						
				    } else {
				    	alert("비밀번호 불일치");			    		
				        $("input[name='pwconfirm']").val("");		 	        
				        $("input[name='pwconfirm']").focus();
				        return;
			    	}	
				} else {
					alert("본인의 비밀번호를 올바르게 입력해주세요.");
					$("input[name='oldPw']").val("");
					$("input[name='oldPw']").focus();
					return;
				}				
			},
			error:function(request, status, error){
				alert("오류가 발생했습니다. 다시 시도해주십시오.");
			   	return;
			}
		});		
	});					
	
	// 비밀번호 변경 모달 - 취소 버튼	
	$("#updatePwModal").on("click", "#closeBtn", function(e) {
	    e.preventDefault();
	    $("input[name='oldPw']").val("");
	    $("input[name='newPw']").val("");
	    $("input[name='pwconfirm']").val("");
	    setTimeout(function() { $("#updatePwModal").modal("hide"); }, 100);
	});
	
	/* 모달창 보이기 */
	function modal(element){
		$("#myModal").modal("show");
		setTimeout(function() { $("#myModal").modal("hide"); }, 800);
		setTimeout(function() { $(element).focus(); }, 900);
	}
	
	/* 유효성검사 후 제출 */			
	function checkInfo() {		
		//입력칸
		var phone=$("input[name='phone']").val();
		var email=$("input[name='email']").val();
		var phone=$("input[name='address']").val();
		var address=$("input[name='address']").val();	
		
		// 입력규칙	
		var reg_email = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$/;
		var reg_phone = /^\d{2,3}-\d{3,4}-\d{4}$/;		
		
		//이메일
		if (email === "") {				
			$(".modal-body").html("<p>이메일을 입력해주세요</p>");
			modal("input[name='email']"); 
		    return;				
		} else if(!reg_email.test(email)){
			$(".modal-body").html("<p>이메일 형식에 맞게 입력해주세요</p>");
			modal("input[name='email']"); 	        
		   	return;
		}
		
		/*//전화번호		
		if(!reg_phone.test(phone)){
			$(".modal-body").html("<div align='center' style='font-size:16px; margin:15px'>전화번호 형식에 맞게 입력해주세요<br>ex)xxx-xxxx-xxxx</div>");
			modal("input[name='phone']"); 	        
		   	return;
		}*/
		
		
		/* 필요시 사용
		//전화번호
		if (phone === "") {				
			$(".modal-body").html("<p>전화번호를 입력해주세요</p>");
			modal("input[name='phone']");
		    return;				
		} else if(!reg_phone.test(phone)){
			$(".modal-body").html("<div align="center"><p>전화번호 형식에 맞게 입력해주세요</p><br><p>ex)xxx-xxxx-xxxx</p></div>");
			modal("input[name='phone']"); 	        
		   	return;
		}
		
		//주소
		if (address === "") {				
			$(".modal-body").html("<p>주소를 입력해주세요</p>");
			modal("input[name='address']"); 
		    return;				
		}*/		
		console.log($("input[name='profileImg.uuid']").val());
		
		//2단계 : 프로필사진 서버삭제
	    if($("input[name='profileImg.uuid']").val() == "ed87212c-4e79-4813-be6c-8c73ac58ac33"){
	    	console.log("삭제");
    		var fileName = $("#removeImgBtn").data("file");	    		
	    	if(fileName != null || fileName != ""){	    	
		    	$.ajax({ // 새로 업로드된 사진 삭제
		 	        type: 'POST',
		 	        url: '/deleteFile',
		 	        data: {fileName:fileName, type: "image"}, 
		 	        beforeSend:function(xhr){
		 	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
		 	        },
		 	        success: function(result){
		 	            console.log('2.파일 삭제 성공');		 	            	    		
		 	        },
		 	        error: function(xhr, status, error) {
		 	            console.error('파일 삭제 실패:', error);
		 	        }
		 	    });
	    	} else { // 기존파일 삭제
		    	$.ajax({
			        type: 'POST',
			        url: '/deleteFile',
			        data: {fileName:deleteClone, type: "image"}, 
			        beforeSend:function(xhr){
			            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			        },
			        success: function(result){
			            console.log('2.파일 삭제 성공');			            	    		
			        },
			        error: function(xhr, status, error) {
			            console.error('파일 삭제 실패:', error);
			        }
			    });
	    	}
	    }
		
		//$("#updateForm").submit();
	}

	/* 프로필사진 업로드 */
	// 업로드 상세처리(확장자, 크기 등) 
	var regex = new RegExp("(.*?)\.(jpg|jpeg|png|gif)$"); // 업로드 가능 확장자
	var maxSize = 5242880; // 5MB	
	
	function checkFile(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(!regex.test(fileName)){
			alert("해당 확장자는 업로드 할 수 없습니다.");
			return false;
		}		
		return true; 
	}
	
	/* 클론 생성 : 초기화면상태 */
	var	uploadProfile = $(".uploadProfile");		
	var profileInfoForm = $("#profileInfoForm"),
		prevUploadPath = $("input[name='profileImg.uploadPath']").clone().val(),
		prevUuid = $("input[name='profileImg.uuid']").clone().val(),
		prevFileName = $("input[name='profileImg.fileName']").clone().val(),
		prevFileType = $("input[name='profileImg.fileType']").clone().val();
	var fileClone = encodeURIComponent(prevUploadPath+"/"+prevUuid+"_"+prevFileName),
		deleteClone = encodeURIComponent(prevUploadPath+"/s_"+prevUuid+"_"+prevFileName);
			
	/* 프로필사진 조회 */
	(function(){
		var userid = '<c:out value="${user.userid}"/>';
		$.getJSON("/user/getProfileImg", {userid:userid}, function(result){
			var fileCallPath = encodeURIComponent(result.uploadPath+"/"+result.uuid+"_"+result.fileName);			
            $(".uploadProfile").attr({"data-path":result.uploadPath, "data-uuid":result.uuid, "data-filename":result.fileName, "data-type":result.fileType, "data-file":fileCallPath});
            $(".uploadProfile").html('<img id="profile_big" src="/display?fileName='+fileCallPath+'">');
		});
	})();
	
	// 찾아보기 버튼 클릭 이벤트 처리 
	$("#findImgBtn").click(function(e){
		e.preventDefault();	    
	    $("input[type='file']").click();// 파일 선택 input 클릭	    
	});
	
	// 파일업로드 : 상태가 변하면 전송 
	$("input[type='file']").change(function(){
        var formData = new FormData();
        var inputFile = $("input[name='singleFile']");
        var file = inputFile[0].files[0];
        var fileName = file.name;
        var fileSize = file.size;
        formData.append('singleFile', file);
                
        // 파일 검증
        if(!checkFile(fileName, fileSize)) {            
            uploadProfile.html("<img id='profile_big' src='/display?fileName="+fileClone+"'>");
            return;
        }
       
     	// 파일을 서버로 전송
        $.ajax({
            url: '/uploadSingle',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			},
            success: function(result) {        
            	console.log(result);
	            // XML을 jQuery 객체로 변환
                var Img = $(result);
                // XML에서 필요한 데이터를 가져옴
                var uploadPath = Img.find('uploadPath').text();
                var uuid = Img.find('uuid').text();
                var fileName = Img.find('fileName').text();
                var fileType = (Img.find('img').text() === "true") ? true : false;
                // 화면출력
                var reader = new FileReader();                                
                reader.onload = function(){
					var fileCallPath = encodeURIComponent(uploadPath+"/"+uuid+"_"+fileName);
					var DeleteFilePath = encodeURIComponent(uploadPath+"/s_"+uuid+"_"+fileName); // 기존의 /deleteFile는 썸네일을 지우는 용도, 파일명 쪼개서 "s_"를 붙이는거보단 지우는게 쉽다.
				
					var ImgTag = '<img id="profile_big" src="/display?fileName='+fileCallPath+'">';
                    $(".uploadProfile").attr({"data-path":uploadPath, "data-uuid":uuid, "data-filename":fileName, "data-type":fileType, "data-file":fileCallPath});
                    $(".uploadProfile").html(ImgTag);
                    $("#resetImgBtn").attr({"data-file": DeleteFilePath, "data-type": fileType});
                    $("#removeImgBtn").attr({"data-file": DeleteFilePath, "data-type": fileType});
                	        		
            		// hidden input에 이미지 정보 설정
            		$("input[name='profileImg.uploadPath']").val(uploadProfile.data("path"));
            		$("input[name='profileImg.uuid']").val(uploadProfile.data("uuid"));
            		$("input[name='profileImg.fileName']").val(uploadProfile.data("filename"));            		           		
                }
                reader.readAsDataURL(file);
            },
            error: function(xhr, status, error) {
                console.error('프로필 사진 업로드 실패:', error);                
            }
        });
    });	
	
	// 원래 프로필사진으로 - 업로드파일삭제
	$("#resetImgBtn").on("click", function(e){
	    e.preventDefault();	    
	    
	    var fileName = $(this).data("file");// 서버로 파일 삭제 요청 보내기	   
	    
	    if(fileName == null || fileName == ""){
	    	return false;
	    }
	    
	    $.ajax({
	        type: 'POST',
	        url: '/deleteFile',
	        data: {fileName: fileName, type: "image"}, 
	        beforeSend:function(xhr){
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
	        },
	        success: function(result){
	            console.log('사진 리셋 성공');
	            uploadProfile.empty();
	            uploadProfile.attr({
	                "data-path": prevUploadPath,
	                "data-uuid": prevUuid,
	                "data-filename": prevFileName,
	                "data-type": prevFileType,
	                "data-file": fileClone
	            });	            	            
	            uploadProfile.html("<img id='profile_big' src='/display?fileName="+fileClone+"'>"); //프로필사진 초기화
	            	            
	    		//profileInfoForm.html({inputUploadPath, inputUuid, inputFileName, inputFileType}); //프로필전송폼 초기화
	    		$("input[name='profileImg.uploadPath']").val(prevUploadPath);
        		$("input[name='profileImg.uuid']").val(prevUuid);
        		$("input[name='profileImg.fileName']").val(prevFileName);
	        },
	        error: function(xhr, status, error) {
	            console.error('사진 리셋 실패:', error);
	        }
	    });
	});	
	 
	// 프로필 사진삭제 : 기본 프로필사진으로 - 업로드파일삭제
	$("#removeImgBtn").on("click", function(e){
		e.preventDefault();
		// 1.화면만 바꾼다. 1-1.새로업로드 후 삭제:기존&새로운 사진까지 삭제. 1-2.기존사진만 삭제  2.만일 input uuid변동이 없다면 서버에서도 삭제      
    	console.log('1.파일 삭제 준비! : 화면_기본프로필로 변경');
		$(".uploadProfile").html('<img src="/resources/img/Default-Profile.png" style="width:400px; height:400px;">');
		$("input[name='profileImg.uploadPath']").val("2024\\04\\27");	            
		$("input[name='profileImg.uuid']").val("ed87212c-4e79-4813-be6c-8c73ac58ac33");
		$("input[name='profileImg.fileName']").val("Default-Profile.png");
	});
	
	// 프로필사진 클릭시 이벤트 처리 
	$(".uploadProfile").on("click", function(e){				
		var img = $(this);
		var path = encodeURIComponent(img.data("path")+"/"+img.data("uuid")+"_"+img.data("filename"));//li태그에 저장되어있는 정보들 >> 경로/uuid_파일명
		showImage(path.replace(new RegExp(/\\/g),"/")); // 이미지파일 : showImage함수 실행
	});
	
	// 원본사진 확대보기 on
	function showImage(fileCallPath){			
		$(".picWrap").css("display","flex").show(); // none > flex 설정 변경
		$(".pic").html("<img src='/display?fileName="+fileCallPath+"'>").animate({width:'100%', height:'100%'}, 0);//pic의 html속성은 controller의 display메서드, animate는 크기변경(배경창 100%*100%) 0.3초 후 실행 
	}
	
	// 원본사진 확대보기 off 
	$(".picWrap").on("click", function(e){
		$(".pic").animate({width:'0%', height:'0%'}, 0); // (0%*0%) 로 0.3초 후 크기변경
		setTimeout(() => {$(this).hide();}, 0);	// chrome의 ES6화살표함수
		//IE : setTimeout(function(){$('.picWrap').hide();}, 300);
	});
	
});	
</script>

<%@ include file="../includes/footer.jsp"%><%@ include file="../includes/footer.jsp"%>
