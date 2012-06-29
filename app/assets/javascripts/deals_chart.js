var chart;
var Graph = {
	
	bank: function() {
		$.getJSON('/movements/graph.json', function(data){
			var income = data.graph.income;
			var outcome = data.graph.outcome;
			var categories = Object.keys(income); // months
			
			chart = new Highcharts.Chart({
				chart: {
					renderTo: 'detail',
					type: 'column',
					marginRight: 130,
					marginBottom: 25,
					backgroundColor: "#2C2C2C",
					height: 300,
				},
				title: {
					text: 'Ingresos vs Egresos',
					x: -20, //center
					style: { color: '#e5e5e5'}
				},

				xAxis: {
					categories: categories
				},
				yAxis: {
					title: {
						text: 'Pesos',
						style: { color: '#e5e5e5'}
					},
					plotLines: [{
						value: 0,
						width: 1,
						color: '#000'
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
					borderWidth: 0,
					itemStyle: { color: '#e5e5e5' }
				},
				series: [{
						name: 'Ingresos',
						data: get_totals(categories, income)
						}, {
						name: 'Egresos',
						data: get_totals(categories, outcome)
						}]
				});
				$("#detail").hide();
				$("#detail").fadeIn();
				});
			},
	
	deals: function () {

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
				backgroundColor: "#2C2C2C",
				height: 300,
			},
			title: {
				text: 'Rendimiento de Deals últimos 12 meses',
				x: -20, //center
				style: { color: '#e5e5e5'}
			},
	
			xAxis: {
				categories: categories
			},
			yAxis: {
				title: {
					text: 'Pesos',
					style: { color: '#e5e5e5'}
				},
				plotLines: [{
					value: 0,
					width: 1,
					color: '#000'
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
				borderWidth: 0,
				itemStyle: { color: '#e5e5e5' }
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
		$("#detail").hide();
		$("#detail").fadeIn();
			});
		}
}

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