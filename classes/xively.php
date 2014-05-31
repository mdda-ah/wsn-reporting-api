<?php

class xively {

	function __construct($f3,$db) {
		$f3->set(
			'xively_metadata',
			$db->exec(
				'select feed_id, channel_id, api_key from xively where id = (select xively_id from sensors where device_id=:device_id and sensor_type_id=:sensor_type_id)',
				array (
					':device_id' => $f3->get('wsn_reading.device_id'),
					':sensor_type_id' => $f3->get('wsn_reading.sensor_id')
				)
			)
		);
		if ($f3->get('xively_metadata')) {
			$this->create_json($f3);
			$this->push_json_to_xively($f3);
		}
	}

	function create_json($f3) {
		$datetime = date(DATE_W3C, strtotime($f3->get('wsn_reading.datetime')));

		$array_for_json = array(
			'version'	=>	'1.0.0',
			'datastreams' => array(
				0 => array(
					'id'	=> $f3->get('xively_metadata.0.channel_id'),
					'datapoints'	=>	array(
						0 => array(
							'at'	=>	$datetime, 'value'	=>	$f3->get('wsn_reading.value')
						)
					),
					'current_value'	=>	$f3->get('wsn_reading.value')
				)
			)
		);

		$f3->set('xively_json',	json_encode($array_for_json, JSON_NUMERIC_CHECK));
	}

	function push_json_to_xively($f3) {
		$web = \Web::instance();

		$url = sprintf(
			'%s/%s/feeds/%s.json',
			$f3->get('wsn_xively_api_endpoint'),
			$f3->get('wsn_xively_api_version'),
			$f3->get('xively_metadata.0.feed_id')
		);

		$options = array(
	    'method'  => 'PUT',
	    'content' => $f3->get('xively_json'),
	    'header' => array(
	    	'Content-Type: application/json',
	    	'X-ApiKey: ' . $f3->get('xively_metadata.0.api_key')
	    )
		);

		$result = $web->request($url, $options);
	}

}

?>