$(document).ready(function() {
	$.format.locale({number: {groupingSeparator: '.', format: '#,###'}})
	$("#date").html($.format.date(new Date(), 'dd MMMM, yyyy'));
	set_deals_totals();
	set_bank_totals();
	set_invoices_totals();
	
	
	    var chart;
	        chart = new Highcharts.Chart({
	            chart: {
	                renderTo: 'detail',
	                type: 'column',
					backgroundColor: 'rgba(15, 15, 15, 0.93)'
	            },
	            title: {
	                text: 'Stacked column chart'
	            },
	            xAxis: {
	                categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas']
	            },
	            yAxis: {
	                min: 0,
	                title: {
	                    text: 'Total fruit consumption'
	                },
	                stackLabels: {
	                    enabled: true,
	                    style: {
	                        fontWeight: 'bold',
	                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
	                    }
	                }
	            },
	            legend: {
	                align: 'right',
	                x: -100,
	                verticalAlign: 'top',
	                y: 20,
	                floating: true,
	                backgroundColor: 'rgba(15, 15, 15, 0.93)',
	                borderColor: '#CCC',
	                borderWidth: 1,
	                shadow: true
	            },
	            tooltip: {
	                formatter: function() {
	                    return '<b>'+ this.x +'</b><br/>'+
	                        this.series.name +': '+ this.y +'<br/>'+
	                        'Total: '+ this.point.stackTotal;
	                }
	            },
	            plotOptions: {
	                column: {
	                    stacking: 'normal',
	                    dataLabels: {
	                        enabled: true,
	                        color: 'rgba(15, 15, 15, 0.93)'
	                    }
	                }
	            },
	            series: [{
	                name: 'John',
	                data: [5, 3, 4, 7, 2]
	            }, {
	                name: 'Jane',
	                data: [2, 2, 3, 2, 1]
	            }, {
	                name: 'Joe',
	                data: [3, 4, 4, 2, 5]
	            }]
	        });
	
});

function set_deals_totals() {
	$.getJSON('/deals/total.json', function(data){
		main_total = data.total.pending.CLP + (data.total.pending.USD * 500);
		red_total = data.total.lost.CLP + (data.total.lost.USD * 500);
		green_total = data.total.won.CLP + (data.total.won.USD * 500);
		
		$("#deals .main-total h1").text("$ " + $.format.number(main_total));
		$("#deals .sub-totals .green-total").text("$ " + $.format.number(green_total));
		$("#deals .sub-totals .red-total").text("$ " + $.format.number(red_total));
	});
}

function set_bank_totals() {
	$.getJSON('/movements/total.json', function(data){
		main_total = data.total.balance
		red_total = data.total.outcome * -1
		green_total = data.total.income
		
		$("#bank .main-total h1").text("$ " + $.format.number(main_total));
		$("#bank .sub-totals .green-total").text("$ " + $.format.number(green_total));
		$("#bank .sub-totals .red-total").text("$ " + $.format.number(red_total));
	});
}

function set_invoices_totals() {
	$.getJSON('/invoices/total.json', function(data){
		main_total = data.total.due + data.total.active
		red_total = data.total.due
		green_total = data.total.active
		
		$("#invoices .main-total h1").text("$ " + $.format.number(main_total));
		$("#invoices .sub-totals .green-total").text("$ " + $.format.number(green_total));
		$("#invoices .sub-totals .red-total").text("$ " + $.format.number(red_total));
	});
}


