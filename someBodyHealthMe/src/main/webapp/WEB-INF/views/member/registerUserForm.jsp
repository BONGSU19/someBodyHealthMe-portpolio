<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        /* 회원가입 폼 스타일 */
        #register_form ul li label {
            font-size: 12px !important; /* 레이블의 글자 크기 줄임 */
        }

        #register_form input[type="text"],
        #register_form input[type="password"],
        #register_form input[type="email"],
        #register_form input[type="radio"],
        #register_form input[type="button"] {
            font-size: 12px !important; /* 입력 필드의 글자 크기 줄임 */
        }

        /* 회원가입 버튼, 홈으로 버튼의 글자 크기 줄이기 */
        #register_form .align-center input[type="submit"],
        #register_form .align-center input[type="button"] {
            font-size: 12px !important; /* 버튼 글자 크기 줄임 */
        }
    </style>
    <meta charset="UTF-8">
    <title>회원 가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
        $(function(){
            // 유효성 체크
            $('#register_form').submit(function(){
                const items = document.querySelectorAll('.input-check');
                for(let i = 0; i < items.length; i++){
                    if(items[i].id !== "admin_code" && items[i].value.trim() == '') { // admin_code는 선택 사항
                        const label = document.querySelector('label[for="'+items[i].id+'"]');
                        alert(label.textContent + ' 필수 입력');
                        items[i].value = '';
                        items[i].focus();
                        return false;
                    }
                }
            });
        });
    </script>
</head>
<body>
<div class="page-main">
    <div class="content-main">
        <h2>회원 가입</h2>
        <form id="register_form" action="registerUser.do" method="post">
            <ul>
                <li>
                    <label for="login_id">아이디</label>
                    <input type="text" name="login_id" id="login_id" maxlength="30" autocomplete="off" class="input-check">
                </li>
                <li>
                    <label for="nick_name">닉네임</label>
                    <input type="text" name="nick_name" id="nick_name" maxlength="30" class="input-check">
                </li>
                <li>
                    <label for="password">비밀번호</label>
                    <input type="password" name="password" id="password" maxlength="50" class="input-check">
                </li>
                <li>
                    <label for="email">이메일</label>
                    <input type="email" name="email" id="email" maxlength="20" class="input-check">
                </li>
                <li>
                    <label for="name">이름</label>
                    <input type="text" name="name" id="name" maxlength="50" class="input-check">
                </li>
                <li>
                    <label for="birth_date">생년월일</label>
                    <input type="text" name="birth_date" id="birth_date" maxlength="8" class="input-check" placeholder="YYYYMMDD">
                </li>
                <li>
                    <label for="phone">휴대전화번호</label>
                    <input type="text" name="phone" id="phone" maxlength="5" class="input-check">
                </li>
                <li>
                    <label for="admin_code">관리자 코드 (선택)</label>
                    <input type="text" name="admin_code" id="admin_code" placeholder="관리자일 경우만 입력">
                </li>
                <li>
                    <label for="center_num">센터 선택</label>
                    <input type="radio" name="center_num" value="1"> 강남점
                    <input type="radio" name="center_num" value="2"> 강북점
                </li>
            </ul>
            <div class="align-center">
                <input type="submit" value="회원가입 완료">
                <input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
            </div>
        </form>
    </div>
</div>
</body>
</html>