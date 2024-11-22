<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminpageForm.css" type="text/css">
    <script>
        function confirmDeactivation() {
            if (confirm('정말 탈퇴하시겠습니까?')) {
                location.href = '${pageContext.request.contextPath}/member/deactivateUser.do';
            }
        }
        function deletePhoto() {
            if (confirm('사진을 삭제하시겠습니까?')) {
                location.href = '${pageContext.request.contextPath}/member/deletePhoto.do';
            }
        }
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/mypageheader.jsp" />

    <div class="mypage-container">
        <!-- 왼쪽 섹션 -->
        <aside class="profile-sidebar">
            <div class="profile-photo">
                <img src="<c:choose>
                    <c:when test='${empty member.photo}'>
                        ${pageContext.request.contextPath}/images/default_user.png
                    </c:when>
                    <c:otherwise>
                        ${pageContext.request.contextPath}/upload/${member.photo}
                    </c:otherwise>
                </c:choose>" alt="프로필 사진">
                <div class="photo-buttons">
                    <form action="${pageContext.request.contextPath}/member/uploadPhoto.do" method="post" enctype="multipart/form-data" style="display: flex; align-items: center; gap: 10px;">
                        <label for="photo" class="styled-file-label">파일 선택</label>
                        <input type="file" id="photo" name="photo" accept="image/*" class="styled-file-input" required>
                        <button type="submit" class="btn photo-edit-btn">수정</button>
                        <button type="button" class="btn photo-delete-btn" onclick="deletePhoto()">삭제</button>
                    </form>
                </div>
                <div class="name-email">
                    <p>${member.name}</p>
                    <p>${member.email}</p>
                </div>
            </div>
            <div class="profile-info-buttons">
                <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/member/logout.do'">로그아웃</button>
                <button class="deactivate-btn" onclick="confirmDeactivation()">회원탈퇴</button>
            </div>
            <div class="profile-main-box">
                <div class="profile-header">
                    <h3>내 프로필</h3>
                    <button onclick="location.href='${pageContext.request.contextPath}/member/editProfileForm.do'" class="btn edit-profile-btn">정보수정</button>
                </div>
                <ul class="profile-details-box">
                    <li>닉네임: ${member.nick_name}</li>
                    <li>전화번호: ${member.phone}</li>
                </ul>
            </div>
            <div class="menu-section">
                <h3>관리자 페이지 테스트 1번</h3>
                <ul>
                    <li><a href="#">관리자 페이지 테스트 1-1번</a></li>
                    <li><a href="#">관리자 페이지 테스트 1-2번</a></li>
                </ul>
                <h3>관리자 페이지 테스트 2번</h3>
                <ul>
                    <li><a href="#">관리자 페이지 테스트 2-1번</a></li>
                    <li><a href="#">관리자 페이지 테스트 2-2번</a></li>
                </ul>
            </div>
        </aside>
        <main class="content-section">
            <div class="my-posts">
                <h3>내가 쓴 글 <button class="more-btn">더보기</button></h3>
                <table>
                    <thead>
                        <tr>
                            <th>제목</th>
                            <th>작성시간</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="2">데이터 없음</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="my-comments">
                <h3>출입 내역 <button class="more-btn">더보기</button></h3>
                <table>
                    <thead>
                        <tr>
                            <th>제목</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="2">데이터 없음</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>
