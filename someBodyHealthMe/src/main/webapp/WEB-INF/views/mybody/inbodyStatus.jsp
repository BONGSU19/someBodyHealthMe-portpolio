<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>인바디 상태</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <h2>월별 인바디 그래프</h2>

    <!-- Canvas for Chart.js -->
    <canvas id="inbodyChart" width="400" height="200"></canvas>

    <script>
        // 데이터를 JSP에서 받아오기 (EL 표현식)
        var months = [];
        var avgMuscleMass = [];
        var avgBodyFatPercentage = [];
        
        // EL로 전달된 데이터를 자바스크립트 배열로 변환
        <c:forEach var="data" items="${inbodyData}">
            months.push('${data.month}');
            avgMuscleMass.push(${data.avgMuscleMass});
            avgBodyFatPercentage.push(${data.avgBodyFatPercentage});
        </c:forEach>

        // Chart.js로 그래프 그리기
        var ctx = document.getElementById('inbodyChart').getContext('2d');
        var inbodyChart = new Chart(ctx, {
            type: 'line',  // 라인 차트
            data: {
                labels: months,  // x축: 월
                datasets: [{
                    label: '평균 근육량',
                    data: avgMuscleMass,  // y축: 평균 근육량
                    borderColor: 'rgba(75, 192, 192, 1)',  // 라인 색
                    fill: false  // 채우지 않음
                }, {
                    label: '평균 체지방률',
                    data: avgBodyFatPercentage,  // y축: 평균 체지방률
                    borderColor: 'rgba(255, 99, 132, 1)',  // 라인 색
                    fill: false  // 채우지 않음
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
