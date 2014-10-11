var svg_w = 1000;
var svg_h = 500;
var vbox_x = 0;
var vbox_y = 0;
var vbox_default_width = vbox_width = 1000;
var vbox_default_height = vbox_height = 500;
var svg = d3.select("body")
	.append("svg")
	.attr("width", svg_w)
	.attr("height", svg_h)
	.attr("viewBox", "" + vbox_x + " " + vbox_y + " " + vbox_width + " " + vbox_height);

// READ JSON FILES
$.getJSON("data/molecule.json", function(json){
	var data = json.results.bindings;
	$.getJSON("data/reaction.json", function(json){
		data = data.concat(json.results.bindings);
		draw(data);
	});
});
function draw(data) {
	
	var data_rectangle = filter_data(data, "protein")
		.concat(filter_data(data, "complex"));
	draw_rectangle(data_rectangle);

	var data_ellipse = filter_data(data, "simple_molecule");
	draw_ellipse(data_ellipse);
	
	var data_path = filter_data(data, "reaction");
	draw_path(data_path);
	
	draw_text(data);
	
	add_zoom();
}
function draw_rectangle(data) {
	svg.selectAll("rect")
	.data(data)
	.enter()
	.append("rect")
	.attr("id", function(d) { return d.metaid.value; })
	.attr("width", function(d) { return d.bounds_w.value; })
	.attr("height", function(d) { return d.bounds_h.value; })
	.attr("rx", "5")
	.attr("ry", "5")
	.attr("class", function(d) { return d.type.value; })
	.attr("x", function(d) { return d.bounds_x.value; })
	.attr("y", function(d) { return d.bounds_y.value; });
}
function draw_ellipse(data) {
	var ellipses = svg.selectAll("ellipse")
	.data(data)
	.enter()
	.append("ellipse")
	.attr("id", function(d) { return d.metaid.value; })
	.attr("rx", function(d) { return Number(d.bounds_w.value) / 2; })
	.attr("ry", function(d) { return Number(d.bounds_h.value) / 2; })
	.attr("class", function(d) { return d.type.value; })
	.attr("cx", function(d) { return Number(d.bounds_x.value) + Number(d.bounds_w.value) / 2; })
	.attr("cy", function(d) { return Number(d.bounds_y.value) + Number(d.bounds_h.value) / 2; });
	return ellipses;
}
function add_zoom() {
	zoom = d3.behavior.zoom().on("zoom", function(d) {
	    var befere_vbox_width, before_vbox_height, d_x, d_y;
	    befere_vbox_width = vbox_width;
	    before_vbox_height = vbox_height;
	    vbox_width = vbox_default_width * d3.event.scale;
	    vbox_height = vbox_default_height * d3.event.scale;
	    d_x = (befere_vbox_width - vbox_width) / 2;
	    d_y = (before_vbox_height - vbox_height) / 2;
	    vbox_x += d_x;
	    vbox_y += d_y;
	    return svg.attr("viewBox", "" + vbox_x + " " + vbox_y + " " + vbox_width + " " + vbox_height);
	});
	svg.call(zoom);
}
function filter_data(array, str) {
	function f(d) {
		if (d.type.value == str) {
			return( true );
		}
	}
	return array.filter(f);
}

// PATH RELATED FUNCTIONS

function draw_path(data) {
	define_arrowhead();
	var line = d3.svg.line()
		//.interpolate('basis')
		.x(function(d) {return d.x;})
		.y(function(d) {return d.y;});
	path = svg.selectAll("path")
		.data(data)
		.enter()
		.append("path")
		.attr("class", "path")
		.attr("d", function(d) { return line(position_array(d.br_metaid.value, d.br_position.value, d.bp_metaid.value, d.bp_position.value)); })
		.attr("marker-end", "url(#arrowhead)");
}
function define_arrowhead() {
	var marker = svg.append("defs").append("marker")
	.attr({
	  'id': "arrowhead",
	  'refX': 10,
	  'refY': 5,
	  'markerWidth': 10,
	  'markerHeight': 10,
	  'markerUnits': "strokeWidth",
	  'orient': "auto",
	});
	marker.append("polygon")
	.attr({
	  points: "0,0 0,5 0,10 10,5"
	});
}
function position(metaid, direction) {
	var x, y;
	var rect = d3.select("rect#" + metaid);
	if (direction == "N") {
		x = Number(rect.attr("x")) + Number(rect.attr("width")) / 2;
		y = Number(rect.attr("y"));
	} else if (direction == "E") {
		x = Number(rect.attr("x")) + Number(rect.attr("width"));
		y = Number(rect.attr("y")) + Number(rect.attr("height")) / 2;
	} else if (direction == "S") {
		x = Number(rect.attr("x")) + Number(rect.attr("width")) / 2;
		y = Number(rect.attr("y")) + Number(rect.attr("height"));
	} else if (direction == "W") {
		x = Number(rect.attr("x"));
		y = Number(rect.attr("y")) + Number(rect.attr("height")) / 2;
	}
	return {x:x, y:y};
}
function position_array(br_metaid, br_direction, bp_metaid, bp_direction) {
	br_position = position(br_metaid, br_direction);
	bp_position = position(bp_metaid, bp_direction);
	if (br_direction == "E" && bp_direction == "N") {
		return [br_position, {x:bp_position.x, y:br_position.y}, bp_position];
	} else if (br_direction == "W" && bp_direction == "S") {
		return [br_position, {x:bp_position.x, y:br_position.y}, bp_position];
	} else if (br_direction == "N" && bp_direction == "S") {
		return [br_position, {x:br_position.x, y:(br_position.y + bp_position.y) / 2}, {x:bp_position.x, y:(br_position.y + bp_position.y) / 2}, bp_position];
	} else {
		return [br_position, bp_position];
	}
}

// TEXT RELATED FUNCTIONS

function draw_text(data) {
	svg.selectAll("text")
		.data(data)
	    .enter()
	    .append("text")
	    .text(function(d) { return position_text(d).t; })
	    .attr("class", "reaction")
	    .attr("x", function(d) { return position_text(d).x; }) // THIS IS CENTER!
	    .attr("y", function(d) { return position_text(d).y; })
	    .attr("text-anchor", function(d) { return position_text(d).a; });
}
function position_text(d) {
	if (d.type.value == "protein" || d.type.value == "complex" ||d.type.value == "simple_molecule") {
		return position_text_molecule(d);
	}
	if (d.type.value == "reaction") {
		return position_text_reaction(d);
	}
}	
function position_text_molecule(d) {
	var t, x, y, a;
	t = d.label.value;
	x = Number(d.bounds_x.value) + Number(d.bounds_w.value) / 2;
	y = Number(d.bounds_y.value) + Number(d.bounds_h.value) - 5;
	a = "middle";
	return {t:t, x:x, y:y, a:a};
}
function position_text_reaction(d) {
	var t, x, y, a;
	t = d.metaid.value
	var metaid = d.br_metaid.value;
	var direction = d.br_position.value;
	var rect = d3.select("rect#" + metaid);
	var rect_x = Number(rect.attr("x"));
	var rect_y = Number(rect.attr("y"));
	var rect_w = Number(rect.attr("width"));
	var rect_h = Number(rect.attr("height"));
	if (direction == "N") {
		x = rect_x + rect_w / 2 + 5;
		y = rect_y - 5;
		a = "start";
	} else if (direction == "E") {
		x = rect_x + rect_w + 5;
		y = rect_y + rect_h / 2 - 5;
		a = "start";
	} else if (direction == "S") {
		x = rect_x + rect_w / 2;
		y = rect_y + rect_h;
		a = "start";
	} else if (direction == "W") {
		x = rect_x - 5;
		y = rect_y + rect_h / 2 - 5;
		a = "end";
	}
	return {t:t, x:x, y:y, a:a};
}