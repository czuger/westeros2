/**
 * Created by ced on 23/07/15.
 */

var houses_colors = {};
houses_colors[1] = 'white';
houses_colors[2] = 'red';
houses_colors[3] = 'blue';
houses_colors[4] = 'black';
houses_colors[5] = 'cyan';
houses_colors[6] = 'green';
houses_colors[7] = 'yellow';
houses_colors[8] = 'orange';

houses_background = {};
houses_background[1] = 'grey ';
houses_background[2] = 'LightGray ';
houses_background[3] = 'LightGray ';
houses_background[4] = 'LightGray ';
houses_background[5] = 'grey ';
houses_background[6] = 'LightGray ';
houses_background[7] = 'grey ';
houses_background[8] = 'grey ';

function qr_to_xy( q, r ){

	var ray = get_hex_ray();
	var max_q = get_max_q();

	var x = ray * 3.0/2.0 * q;
	var y = ( Math.round( ( ray * Math.sqrt(3.0) ) ) * (r + (q/2.0)) );

	// Rotation 90 degrés
	var alpha = Math.PI/2.0
	var x2 = (Math.cos( alpha )*x) + (Math.sin( alpha )*y);
	var y2 = (Math.cos( alpha )*y) - (Math.sin( alpha )*x);

	// Translation vers le bas
	var height = Math.sqrt(3.0)/2.0 * ray
	y2 += (ray+(ray/2)) * max_q

	x2 -= ray
	y2 -= (ray/2)+1

	return [ Math.round(x2)+1, Math.round(y2)+1 ];
}

function get_hex_ray(){
	return parseFloat( document.getElementById("hexagon_ray").value );
}

function get_max_q(){
	return parseInt( document.getElementById("max_q").value );
}