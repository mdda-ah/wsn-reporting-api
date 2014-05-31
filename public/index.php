<?php

/*
Include Fat Free Framework
*/
$f3 = require('../lib/base.php');

/*
Include configuration files
Setup
Routes and maps
Database - optional
Xively - optional
Debug flag - on development copy only
*/
$f3->config('../config/setup.cfg');

$f3->config('../config/routesmaps.cfg');

if (file_exists('../config/debug.cfg')) {
	$f3->config('../config/debug.cfg');
}

if (file_exists('../config/xively.cfg')) {
	$f3->config('../config/xively.cfg');
}

if (file_exists('../config/db.cfg')) {
	$f3->config('../config/db.cfg');
}

/*
Run Fat Free Framework
*/
$f3->run();

?>