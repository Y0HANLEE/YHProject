<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<title>Console.log(YH)_로그인페이지</title>
<%@ include file="../includes/header.jsp"%>

<!-- 페이지 제목 -->
<div class="row">		
	<div class="col-lg-12" align="center" style="display:flex; justify-content: center; margin-top:3%; ">
		<h1 class="page-header col-lg-6" style="font-weight: bolder; font-style: italic;">function login(ID, PW)</h1>
	</div>
</div>
<!-- 본문-->
<div class="row" style="display:flex; align-items:center; justify-content: center; margin-top:10px;">
	<div class="col-lg-6" style="min-width: 436px;">
		<div class="panel panel-default">
			<div class="panel-heading" style="display:flex; align-items:center;">
				<div style="width: 20%">로그인</div>
				<div style="width: 80%"><h6 class="pull-right" style="color: red;"><c:out value="${error}"/></h6></div>
			</div>
			<div class="panel-body" style="padding: 15px 15px 0 15px;">				
				<!-- action:login 은 spring security 기본제공 / username, password도 spring security의 기본설정명 -->
				<form role="form" id="loginForm" method="post" action="/login">
					<fieldset>
						<div class="form-group">
							<div>
								<label>ID</label>								
							</div>
							<input class="form-control" type="text" name="username" placeholder="ID" autofocus>
						</div>
						<div class="form-group" style="margin-bottom: 5px;">
							<div>
								<label>Password</label>
								<abbr id="showPw" class="pull-right" title="마우스를 올리면 비밀번호가 보여요" style="display: flex; align-items: center; margin: 0 0 10px 10px;" ontoggle="Y"><i class="fa fa-search"></i>&nbsp;<span style="font-size:12px; margin: 0px">Show me the password</span></abbr>
							</div>
							<input class="form-control" type="password" name="password" placeholder="Password">
							<div style="display:flex; align-items:flex-end; justify-content:flex-end; height:30px;">
								<input type="checkbox" name="remember-me" class="checkbox">&nbsp;<label id="remember-me"> Remember me</label>
							</div>
						</div>						
						<a href="/" class="btn btn-lg btn-success btn-block" id="loginBtn">로그인</a>						
						<a href="/user/join" class="btn btn-lg btn-default btn-block">회원가입</a>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</fieldset>
				</form>		
			</div>
		</div>
	</div>
</div>
<div class="row" style="display:flex; align-items:center; justify-content: center;">
	<div class="col-lg-6" style="display:flex; justify-content: space-between; width:300px; align-items:center;">		
		<a id="searchIdBtn" class="text-primary"><i class="fa fa-key fa-fw"></i>아이디찾기</a>
		<a id="renewalPwBtn" class="text-primary"><i class="fa fa-lock fa-fw"></i>비밀번호초기화</a>	
	</div>	
</div>
<div class="row">
	<div class="col-lg-12" align="center" style="color: gray; font-size: 14px; top:108px;">${footer}</div>
</div>
<!-- findId Modal -->
<div class="modal fade" id="idModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="padding:15px 0 5px 15px;"> 
				<h3 class="modal-title" style="margin-bottom:4px; font-weight:bolder;">아이디 찾기</h3> 
				<p style="font-size:14px; margin-left:0px;">회원님의 이름과 가입시 입력했던 이메일주소를 입력해주세요</p>
			</div>
			<form id="findIdForm" method="post" action="/user/findId">
				<div class="modal-body" id="id_modal_body">
					<div class="form-group">
						<label>Name</label>
						 <input class="form-control" id="name" name="name" placeholder="NAME"> 
					</div>
					<div class="form-group">
						<label>Email</label>
						<input class="form-control" id="email1" name="email" placeholder="EMAIL">
					</div>		
				</div>
				<div class="modal-footer" id="id_modal_footer">
					<div class="form-group" style="display:flex; justify-content:flex-end;">
						<button type="button" id="findIdBtn" class="btn btn-info">아이디찾기</button>
						<button type="button" class="btn btn-default closeBtn">닫기</button>
					</div>					
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</div>
	</div>
</div>	
<!-- renewalPw Modal -->
<div class="modal fade" id="pwModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="padding:15px 0 5px 15px;"> 
				<h3 class="modal-title" style="margin-bottom:4px; font-weight:bolder;">임시비밀번호 발급</h3> 
				<p id="pw_modal_title" style="font-size:14px; margin-left:0px;">회원님의 아이디와 가입시 입력했던 이메일주소를 입력해주세요</p>
			</div>
			<form id="renewalPwForm" method="post" action="/user/renewalPw">
				<div id="pw_modal_body" class="modal-body">
					<div class="form-group">
						<label>ID</label>
						<input class="form-control" id="userid" name="userid" placeholder="ID">
					</div>
					<div class="form-group">
						<label>Email</label>
						<input class="form-control" id="email2" name="email" placeholder="EMAIL">
					</div>		
				</div>
				<div class="modal-footer">
					<div class="form-group" style="display:flex; justify-content:flex-end;">
						<button type="button" id="sendMailBtn" class="btn btn-info">메일보내기</button>
						<button type="button" id="copyBtn" class="btn btn-info">복사하기</button>
						<button type="button" class="btn btn-default closeBtn">닫기</button>
					</div>					
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</div>
	</div>
</div>	
<!-- 본문 -->	
<script type="text/javascript">
$(document).ready(function(){
	/* 로그인 */
	$("#loginBtn").on("click", function(e){
		e.preventDefault();
		$("#loginForm").submit();
	});
	
	//remember-me글씨 클릭이벤트
	$("#remember-me").on("click", function(e){
		e.preventDefault();
		var check = $("input[name='remember-me']");
		
		if(check.prop("checked")){ //prop:property(속성) checked가 true/false를 변화시킴
			check.prop("checked", false); // 만일 체크되어있으면 해제
		} else {
			check.prop("checked", true);  // 아니면 체크
		}
	});
			
	// id, pw칸 엔터 > Login
	var idInput = $('input[name="usename"]');
	var pwInput = $('input[name="password"]');
    var loginBtn = $('.btn-success');

    idInput.on('keypress', function(e) {
        if (e.key === 'Enter') {
            loginBtn.click();
        }
    });
    
    pwInput.on('keypress', function(e) {
        if (e.key === 'Enter') {
            loginBtn.click();
        }
    });    
   
	//비번 보이기/숨기기    
    var pwInput = $('input[name="password"]');    
	/*//클릭
    $("#showPw").on("click", function() {
		if ($("#showPw").data("ontoggle") == "Y") {
			$("#showPw").data("ontoggle", "N");
			pwInput.attr("type", "text");
		} else {
			$("#showPw").data("ontoggle", "Y");
			pwInput.attr("type", "password");
		}
    });*/
    
    $("#showPw").on("mouseover", function() {
		$("#showPw").data("ontoggle", "N");
		pwInput.attr("type", "text");		
    });
    
    $("#showPw").on("mouseout", function() {
		$("#showPw").data("ontoggle", "Y");
		pwInput.attr("type", "password");		
    });
    
	/* 아이디찾기 */
	$("#searchIdBtn").on("click", function(e){
		e.preventDefault();	    
	    $("#idModal").modal("show");	
	});
	
	// 이벤트 위임
    $("#idModal").on("click", "#findIdBtn", function() {	    	
		var inputName = $("#name").val();
    	var inputEmail = $("#email1").val();    			
    	var reg_email = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$/;
	    
	  	if(inputName == ""){
			alert("회원님의 이름을 입력해주세요");				
			$("#name").focus();
			return false;
		}
	  
	  	if(inputEmail == ""){
			alert("Email을 입력해주세요");
			$("#email").focus();
			return false;
		} else if(!reg_email.test(inputEmail)){
			alert("이메일 형식을 지켜주세요");				
    		$("input[name='email']").val("");
    		inputEmail="";
			$("#email").focus();
			return false;	
		}
							
		$.ajax({				
			url: "/main/findId",
			type: "post",
			dataType: "text",
			data: {"name":inputName, "email":inputEmail},
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			},
			success: function(result){
					// 문제) 한사람에 아이디가 여럿인 경우 오류발생 > String→List<String>으로 타입변환 > xml형태로 출력됨. > xml처리					
				    var parser = new DOMParser(); // xml파싱 > html변환
				    var xmlDoc = parser.parseFromString(result, "text/xml");
				    var items = xmlDoc.getElementsByTagName("item"); // tagName 'item'만 선택
	
				    var ids = []; // id배열생성
				    for (var i = 0; i < items.length; i++) {
				        var id = items[i].textContent; // 텍스트만 추출(html태그 포함x)
				        ids.push(id); // 배열에 넣는다.(순수 아이디 배열)
				    }					  
			    	if (result.length === 0) {			    		
				        $("input[name='name'], input[name='email']").val("");
			    		$("#id_modal_body").html("<p>일치하는 아이디가 없습니다.</p>");
			    		$("#idModal").modal('show');
				        inputName.focus();
				        return;				        
				    } else {
				        var idList = "";
				        ids.forEach(function(id) {
				            idList += "<p>회원님의 아이디는 <b>" + replaceStar(id) + "</b>입니다.</p>";				            
				        });
				        $("#id_modal_body").html(idList);
				        $("#idModal").modal('show');
				        $("input[name='name'], input[name='email']").val("");
				    }
			},
			error: function(){	    	
				var btn = '<div class="form-group" style="display:flex; justify-content:flex-end;">';
				btn += '<button type="button" id="backBtn" class="btn btn-info">다시찾기</button>';
				btn += '<button type="button" class="btn btn-default closeBtn">닫기</button></div>';
			
				$("input[name='name'], input[name='email']").val("");
	    		$("#id_modal_body").html("<p>일치하는 아이디가 없습니다.</p>");
	    		$("#id_modal_footer").html(btn);
	    		$("#idModal").modal('show');
		        return;
			}
		});
    });
	
	//아이디 *표
	function replaceStar(str) {    
	    var change = [2,3]; // 바꿀 글자의 위치
	    
	    for(var i=0; i<change.length; i++) { // 바꿀 글자의 개수(change length)만큼 for문 반복
	        var index = change[i]; 
	        if (index>=0 && index<str.length) { //바꿀 글자의 위치는 0보다 크고, 문자열의 길이보다 작을때만 해당            
	            str = str.substring(0, index) + "*" + str.substring(index + 1); // 첫글자~바꿀위치 전까지 추출 + * + 그다음글자~끝 > 조합
	        }
	    }
	    return str;
	}
		
	/* 비밀번호 초기화 */
	$("#renewalPwBtn").on("click", function(e){
		e.preventDefault();			
		$("#copyBtn").hide();
	    $("#pwModal").modal("show");
	});
	
	// 이벤트위임
    $("#pwModal").on("click", "#sendMailBtn", function() {
    	var inputId = $("#userid").val();
    	var inputEmail = $("#email2").val();
	    var reg_id = /^[a-zA-Z][0-9a-zA-Z].{4,6}$/;
	    var reg_email = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$/;
	    
	    
		if(inputId == ""){				
			alert("ID를 입력해주세요");
			$("#userid").focus();
			return;
		} else if(!reg_id.test(inputId)){
			console.log("check id");
			alert("아이디는 영문자 6~8자리로 작성해주세요");
			$("input[name='userid']").val("");
			$("#userid").focus();
			return;
		}
		
		if(inputEmail == ""){
			alert("Email을 입력해주세요");
			$("#email").focus();
			return;
		} else if(!reg_email.test(inputEmail)){
			alert("이메일 형식을 지켜주세요");
			$("input[name='email']").val("");
			$("#email").focus();
			return;	
		}
		
		$.ajax({
			url:"/main/renewalPw",
			type:"post",
			data:{"userid":inputId, "email":inputEmail},										
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(result){
				/*local:이메일전송 문제없음
				if(result === "success"){	
					alert(inputId+"님의 이메일("+inputEmail+")로 임시비밀번호가 발송되었습니다.");					
					$("input[name='userid']").val("");
					$("input[name='email']").val("");					
					setTimeout(function() { $("#pwModal").modal("hide"); }, 200);		
				}*/  				
				/*AWS:포트를 설정해도 이메일 전송이 제대로 안됨. > 메일서버 사용시 AWS SES고려*/
			    var pstr = "회원님의 임시 비밀번호는 <span id='ranPw' style='font-weight: bolder;'/>"+result+"</span> 입니다.";
				$("#pw_modal_body").html(pstr);
				$("#pw_modal_title").html("아래 임시비밀번호로 다시 로그인을 시도해주세요")
				$("#sendMailBtn").hide();
				$("#copyBtn").show();
		        $("#pwModal").modal('show');
			},
			error:function(request, status, error){
				alert("일치하는 회원이 없습니다.");
				$("input[name='userid']").val("");
				$("input[name='email']").val("");
				$("#userid").focus();
				return false;
			} 
		});	    	
    });
	
	/* AWS용
    $("#pwModal").on("click", "#copyBtn", function() {    	
        alert("임시 비밀번호가 복사되었습니다.");
        var ranPw = $("#ranPw").text();        
        var tempInput = $("<input>");
        
        // 임시 비밀번호를 클립보드로 복사
        $("body").append(tempInput);
        tempInput.val(ranPw).select();
        tempInput.focus(); 
        document.execCommand("copy");
        tempInput.remove();
    });*/

	
	var originIdModal = $("#idModal").html();
	var originPwModal = $("#pwModal").html();
	
	// 모달창 닫기 버튼	
	$("#idModal, #pwModal").on("click", ".closeBtn", function(e) {
	    e.preventDefault();
	    $("input[name='userid']").val("");
	    $("input[name='name']").val("");
	    $("input[name='email']").val("");
	    $("#idModal").html(originIdModal);
	    $("#pwModal").html(originPwModal);
	    setTimeout(function() { $("#idModal, #pwModal").modal("hide"); }, 100);
	});
	
	// 다시찾기 버튼	
	$("#idModal, #pwModal").on("click", "#backBtn", function(e) {
	    e.preventDefault();
	    $("input[name='userid']").val("");
	    $("input[name='name']").val("");
	    $("input[name='email']").val("");
	    $("#idModal").html(originIdModal);	    
	    $("#pwModal").html(originPwModal);
	    
	    return false;
	});
	
	// 모달 외부 클릭 시 모달을 숨기는 이벤트 위임
	$("#idModal, #pwModal").on("click", function(e) {
	    // 클릭된 요소가 모달 내부가 아닌지 확인 후 이벤트 처리
	    if ($(e.target).hasClass("modal")) {
	    	e.preventDefault();
		    $("input[name='userid']").val("");
		    $("input[name='name']").val("");
		    $("input[name='email']").val("");	
		    $("#idModal").html(originIdModal);
		    $("#pwModal").html(originPwModal);
	    }
	});	
});
</script>

<%@ include file="../includes/footer.jsp"%>