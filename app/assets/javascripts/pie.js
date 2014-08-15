$(function() {
  $('#pie').highcharts({
    chart: {
      plotBackgroundColor: null,
      plotBorderWidth: 1,//null,
      plotShadow: false
    },
    title: {
      text: 'Ditt flöde'
    },
    tooltip: {
      pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          format: '<b>{point.name}</b>: {point.percentage:.1f} %',
          style: {
            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
          }
        }
      }
    },
    series: [{
      type: 'pie',
      name: 'Antal bilder',
      data: pieData
    }]
  });
});