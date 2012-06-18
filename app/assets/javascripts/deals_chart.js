var chart;
$(document).ready(function() {

	$.getJSON('/deals/graph.json', function(data){
		var created = data.graph.created;
		var won = data.graph.won;
		var lost = data.graph.lost;
		var categories = Object.keys(created); // months

	chart = new Highcharts.Chart({
		chart: {
			renderTo: 'detail',
			type: 'line',
			marginRight: 130,
			marginBottom: 25,
			backgroundColor: "#2C2C2C"
		},
		title: {
			text: 'Rendimiento de Deals últimos 12 meses',
			x: -20 //center
		},
	
		xAxis: {
			categories: categories
		},
		yAxis: {
			title: {
				text: 'Pesos'
			},
			plotLines: [{
				value: 0,
				width: 1,
				color: '#808080'
			}]
		},
		tooltip: {
			formatter: function() {
					return '<b>'+ this.series.name +'</b><br/>'+
					this.x +': '+ "$ " + $.format.number(this.y);
			}
		},
		legend: {
			layout: 'vertical',
			align: 'right',
			verticalAlign: 'top',
			x: -10,
			y: 100,
			borderWidth: 0
		},
		series: [{
			name: 'Creados',
			data: get_totals(categories, created)
		}, {
			name: 'Perdidos',
			data: get_totals(categories, lost)
		}, {
			name: 'Ganados',
			data: get_totals(categories, won)
		}]
	});
		});
});

function get_totals(categories,object){
	var array = [];
	categories.forEach(function(item){
		if (typeof object[item] === "undefined"){
			array.push(0);
		} else {
			array.push(object[item].total)
		}
	});
	return array;
}