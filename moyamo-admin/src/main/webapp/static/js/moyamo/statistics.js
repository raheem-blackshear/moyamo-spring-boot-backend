var numberFormat = function(number) {
    if(number) {
        return (number + '').replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
    } else {
        return 0;
    }
}




var joinTable = $('.zero-configuration').DataTable({
    searching: false,
    paging: false,
    info: false,
    "scrollY": "295px",
    "scrollCollapse": true,
    'autoWidth': false,
    columns: [
        { data: "dt"
            , render: function (data, type, row, meta){
                return moment(data).format('YYYY-MM-DD');
            }
        },
        { data: "joinCount"
            , render: function (data, type, row, meta){
                return numberFormat(row.androidJoinCount + row.iosJoinCount + row.etcJoinCount);
            }
        },
        { data: "leaveCount"
            , render: function (data, type, row, meta){
                return numberFormat(data);
            }},
        { data: "cumJoinCount"
            , render: function (data, type, row, meta){
                return numberFormat(row.cumAndroidJoinCount + row.cumIosJoinCount + row.cumEtcJoinCount);
            }
        },
        { data: "iosJoinCount"
            , render: function (data, type, row, meta){
                return numberFormat(data);
            }
        },
        { data: "androidJoinCount"
            , render: function (data, type, row, meta){
                return numberFormat(data);
            }
        },
        { data: "etcJoinCount"
            , render: function (data, type, row, meta){
                return numberFormat(data);
            }
        }

    ]
});

var drawStatistics = function(list) {

    joinTable.clear().draw();
    joinTable.rows.add(list); // Add new data
    joinTable.columns.adjust().draw(); // Redraw the DataTable

    $("#contents-chart").attr('height', '500');
    $("#join-chart").attr('height', '500');

    var joinCtx = $("#join-chart");
    if(joinCtx.canvas)
        joinCtx.canvas.height = '';

    // Chart Options
    var joinChartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
            position: 'bottom',
        },
        hover: {
            mode: 'label'
        },
        scales: {
            xAxes: [{
                display: true,
                gridLines: {
                    color: "#f3f3f3",
                    drawTicks: false,
                },
                scaleLabel: {
                    display: true,
                    labelString: '날짜'
                }
            }],
            yAxes: [{
                display: true,
                gridLines: {
                    color: "#f3f3f3",
                    drawTicks: false,
                },
                scaleLabel: {
                    display: true,
                    labelString: '가입수'
                },
                ticks: {
                    beginAtZero: true,
                    precision: 0
                }
            }]
        },
        title: {
            display: true,
            text: '매체별 가입수'
        }
    };

    // Chart Data
    var joinChartData = {
        labels: list.map(row => moment(row.dt).format('YYYY-MM-DD')),
        datasets: [{
            label: "카카오",
            data: list.map(row => row.kakaoJoinCount),
            fill: false,
            // borderDash: [5, 5],
            // pointRadius: 15,
            pointHoverRadius: 5,
            backgroundColor: "#FFF",
            borderColor: "#F4D03F",
            pointBorderColor: "#F4D03F",
            pointBackgroundColor: "#FFF",
        }, {
            label: "네이버",
            data: list.map(row => row.naverJoinCount),
            fill: false,
            pointHoverRadius: 5,
            // borderDash: [5, 5],
            // pointRadius: [2, 4, 6, 18, 0, 12, 20],
            backgroundColor: "#FFF",
            borderColor: "#27AE60",
            pointBorderColor: "#27AE60",
            pointBackgroundColor: "#FFF",
        }, {
            label: "페이스북",
            data: list.map(row => row.facebookJoinCount),
            fill: false,
            pointHoverRadius: 5,
            backgroundColor: "#FFF",
            borderColor: "#2E86C1",
            pointBorderColor: "#2E86C1",
            pointBackgroundColor: "#FFF",
            pointRadius: 5,
        }, {
            label: "이메일",
            data: list.map(row => row.emailJoinCount),
            fill: false,
            pointHoverRadius: 5,
            backgroundColor: "#FFF",
            borderColor: "#2E4053",
            pointBorderColor: "#2E4053",
            pointBackgroundColor: "#FFF",
            pointRadius: 5,
        }, {
            label: "애플",
            data: list.map(row => row.appleJoinCount),
            fill: false,
            pointHoverRadius: 5,
            backgroundColor: "#FFF",
            borderColor: "#E74C3C",
            pointBorderColor: "#E74C3C",
            pointBackgroundColor: "#FFF",
            pointRadius: 5,
        }]
    };

    var joinChartConfig = {
        type: 'line',

        // Chart Options
        options : joinChartOptions,
        data : joinChartData
    };

    // Create the chart
    var joinLineChart = new Chart(joinCtx, joinChartConfig);

    var kakaoJoinTotalCount = list.map(row => row.kakaoJoinCount).reduce((a, b) => a + b, 0);
    var naverJoinTotalCount = list.map(row => row.naverJoinCount).reduce((a, b) => a + b, 0);
    var facebookJoinTotalCount = list.map(row => row.facebookJoinCount).reduce((a, b) => a + b, 0);
    var emailJoinTotalCount = list.map(row => row.emailJoinCount).reduce((a, b) => a + b, 0);
    var appleJoinTotalCount = list.map(row => row.appleJoinCount).reduce((a, b) => a + b, 0);

    $('#kakaoJoinTotalCount').text(numberFormat(kakaoJoinTotalCount));
    $('#naverJoinTotalCount').text(numberFormat(naverJoinTotalCount));
    $('#facebookJoinTotalCount').text(numberFormat(facebookJoinTotalCount));
    $('#emailJoinTotalCount').text(numberFormat(emailJoinTotalCount));
    $('#appleJoinTotalCount').text(numberFormat(appleJoinTotalCount));

    var joinTotalCount = kakaoJoinTotalCount + naverJoinTotalCount + facebookJoinTotalCount + emailJoinTotalCount + appleJoinTotalCount;

    $('#joinTotalCount').text(numberFormat(joinTotalCount));

    //컨텐츠 통계
    var contentsCtx = $("#contents-chart");

    // Chart Options
    var contentsChartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
            position: 'bottom',
        },
        hover: {
            mode: 'label'
        },
        scales: {
            xAxes: [{
                display: true,
                gridLines: {
                    color: "#f3f3f3",
                    drawTicks: false,
                },
                scaleLabel: {
                    display: true,
                    labelString: '날짜'
                }
            }],
            yAxes: [{
                display: true,
                gridLines: {
                    color: "#f3f3f3",
                    drawTicks: false,
                },
                scaleLabel: {
                    display: true,
                    labelString: '등록수'
                },
                ticks: {
                    beginAtZero: true,
                    precision: 0
                }
            }]
        },
        title: {
            display: true,
            text: '컨텐츠 통계'
        }
    };

    // Chart Data
    var contentsChartData = {
        labels: list.map(row => moment(row.dt).format('YYYY-MM-DD')),
        datasets: [{
            label: "이름이모야?",
            data: list.map(row => row.questionCount),
            fill: false,
            // borderDash: [5, 5],
            // pointRadius: 15,
            pointHoverRadius: 5,
            backgroundColor: "#FFF",
            borderColor: "#F4D03F",
            pointBorderColor: "#F4D03F",
            pointBackgroundColor: "#FFF",
        }, {
            label: "식물클리닉",
            data: list.map(row => row.clinicCount),
            fill: false,
            pointHoverRadius: 5,
            // borderDash: [5, 5],
            // pointRadius: [2, 4, 6, 18, 0, 12, 20],
            backgroundColor: "#FFF",
            borderColor: "#27AE60",
            pointBorderColor: "#27AE60",
            pointBackgroundColor: "#FFF",
        }, {
            label: "매거진",
            data: list.map(row => row.magazineCount),
            fill: false,
            pointHoverRadius: 5,
            backgroundColor: "#FFF",
            borderColor: "#2E86C1",
            pointBorderColor: "#2E86C1",
            pointBackgroundColor: "#FFF",
            pointRadius: 5,
        }, {
            label: "자랑하기",
            data: list.map(row => row.boastCount),
            fill: false,
            pointHoverRadius: 5,
            backgroundColor: "#FFF",
            borderColor: "#2E4053",
            pointBorderColor: "#2E4053",
            pointBackgroundColor: "#FFF",
            pointRadius: 5,
        }, {
            label: "자유수다",
            data: list.map(row => row.freeCount),
            fill: false,
            pointHoverRadius: 5,
            backgroundColor: "#FFF",
            borderColor: "#E74C3C",
            pointBorderColor: "#E74C3C",
            pointBackgroundColor: "#FFF",
            pointRadius: 5,
        }]
    };

    var conetentsChartConfig = {
        type: 'line',

        // Chart Options
        options : contentsChartOptions,
        data : contentsChartData
    };

    // Create the chart
    var contentsLineChart = new Chart(contentsCtx, conetentsChartConfig);

    var questionTotalCount = list.map(row => row.questionCount).reduce((a, b) => a + b, 0);
    var clinicTotalCount = list.map(row => row.clinicCount).reduce((a, b) => a + b, 0);
    var magazineTotalCount = list.map(row => row.magazineCount).reduce((a, b) => a + b, 0);
    var freeTotalCount = list.map(row => row.freeCount).reduce((a, b) => a + b, 0);
    var boastTotalCount = list.map(row => row.boastCount).reduce((a, b) => a + b, 0);


    $('#questionTotalCount').text(numberFormat(questionTotalCount));
    $('#clinicTotalCount').text(numberFormat(clinicTotalCount));
    $('#magazineTotalCount').text(numberFormat(magazineTotalCount));
    $('#freeTotalCount').text(numberFormat(freeTotalCount));
    $('#boastTotalCount').text(numberFormat(boastTotalCount));
    $('#contentsTotalCount').text(numberFormat(questionTotalCount + clinicTotalCount + magazineTotalCount + freeTotalCount + boastTotalCount));

}

var callStatistics = function(from, to) {
    $.ajax(
        {
            method: 'GET',
            url: '/rest/statistics',
            data : {
                from : from,
                to : to
            }
            , success: function(response) {
                console.log('success', response);
                drawStatistics(response.detail);
            }, error : function(response) {
                console.log('error', response);
            }
        }
    );
}
