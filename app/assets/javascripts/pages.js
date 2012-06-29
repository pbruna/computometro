$(window).load(function() {
	$.format.locale({number: {groupingSeparator: '.', format: '#,###'}})
	$("#date").html($.format.date(new Date(), 'dd MMMM, yyyy'));
	get_bank_totals();
	get_deals_totals();
	get_invoices_totals();
	$(".box .view-more").click(function(){
			var box_id = grand_grand_parent_id($(this));
			show_graph(box_id)
	});
	
});

function show_graph(graph) {
	if (Graph.hasOwnProperty(graph)){
		Graph[graph]();
	} else {
		alert("No implementado")
	}
	
	
}

function grand_grand_parent_id(el) {
	return el.parent().parent().parent().parent().attr("id")
}


function show_data(field){
	$("#" + field + " .waiting").hide();
	$("#" + field + " .info-box").fadeIn();
}

function set_totals(field, totals){
	$("#" + field + " .main-total h1").text("$ " + $.format.number(totals[0]));
	$("#" + field + " .sub-totals .green-total").append(" $ " + $.format.number(totals[1]));
	$("#" + field + " .sub-totals .red-total").append(" $ " + $.format.number(totals[2]));
}

function get_deals_totals() {
	var totals = [];
	$.getJSON('/deals/total.json', function(data){
		main_total = data.total.pending.CLP + (data.total.pending.USD * 500);
		red_total = data.total.lost.CLP + (data.total.lost.USD * 500);
		green_total = data.total.won.CLP + (data.total.won.USD * 500);
		totals = [main_total, green_total, red_total];
		set_totals("deals", totals);
		show_data("deals");
	});
	
}

function get_bank_totals() {
	var totals = [];
	$.getJSON('/movements/total.json', function(data){
		green_total = data.total.balance
		red_total = data.total.fondos_mutuos
		main_total = red_total + green_total
		totals = [main_total, green_total, red_total]
		set_totals("bank", totals);
		show_data("bank");
	});
}

function get_invoices_totals() {
	var totals = [];
	$.getJSON('/invoices/total.json', function(data){
		main_total = data.total.due + data.total.active
		red_total = data.total.due
		green_total = data.total.active
		totals = [main_total, green_total, red_total]
		set_totals("invoices", totals);
		show_data("invoices");
	});
}


