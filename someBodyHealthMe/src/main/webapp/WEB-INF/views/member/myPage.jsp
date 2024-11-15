<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User MyPage</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script>
    $(document).ready(function() {
        // 사진 등록/수정/삭제 관련 이벤트
        $('#photo_btn').click(function() {
            $('#photo_options').toggle();
        });

        $('#photo_upload').change(function() {
            const photo = this.files[0];
            if (!photo) {
                alert('사진을 선택하세요.');
                return;
            }
            if (photo.size > 1024 * 1024) {
                alert('사진 크기는 1MB 이하만 가능합니다.');
                $(this).val('');
                return;
            }
            const reader = new FileReader();
            reader.readAsDataURL(photo);
            reader.onload = function() {
                $('#user_photo').attr('src', reader.result);
            };
        });

        $('#delete_photo').click(function() {
            if (confirm('사진을 삭제하시겠습니까?')) {
                $('#user_photo').attr('src', '${pageContext.request.contextPath}/images/default_user.png');
                $('#photo_upload').val('');
            }
        });

        // 프로필 수정 이벤트
        $('#edit_profile_btn').click(function() {
            location.href = 'editProfileForm.do';
        });

        // 로그아웃 이벤트
        $('#logout_btn').click(function() {
            location.href = 'logout.do';
        });

        // 회원 탈퇴 이벤트
        $('#delete_account_btn').click(function() {
            if (confirm('정말 회원 탈퇴를 진행하시겠습니까?')) {
                location.href = 'deleteAccountForm.do';
            }
        });
    });
</script>
</head>
<body>
<!-- 헤더 영역 -->
<jsp:include page="/WEB-INF/views/common/mypageheader.jsp"/>

<div class="mypage-container">
    <div class="profile-section">
        <!-- 프로필 사진 -->
        <img id="user_photo" src="<c:choose>
            <c:when test="${empty member.photo}">
                ${pageContext.request.contextPath}/images/default_user.png
            </c:when>
            <c:otherwise>
                ${pageContext.request.contextPath}/upload/${member.photo}
            </c:otherwise>
        </c:choose>" alt="Profile Photo">
        <div id="photo_options" style="display: none;">
        	    <input type="file" id="photo_upload" accept="image/*">
            <button id="delete_photo">사진 삭제</button>
        </div>
        <button id="photo_btn">사진 수정</button>
        <!-- 이름 -->
        <h2>${member.name}</h2>
    </div>
    <!-- 로그아웃 및 회원 탈퇴 버튼 -->
    <div class="button-group">
        <button id="logout_btn">로그아웃</button>
        <button id="delete_account_btn">회원 탈퇴</button>
    </div>
    <!-- 프로필 정보 -->
    <div class="profile-info">
        <ul>
            <li><strong>닉네임:</strong> ${member.nick_name}</li>
            <li><strong>전화번호:</strong> ${member.phone}</li>
            <li><strong>이메일:</strong> ${member.email}</li>
            <li><strong>회원가입일자:</strong> ${member.registration_date}</li>
        </ul>
        <button id="edit_profile_btn">정보 수정</button>
    </div>
</div>
</body>
</html>