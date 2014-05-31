#wsn-reporting-api-v2

Version 2 of the Reporting API for MDDA Wireless Sensor Network.

A PHP application built on top of the Fat Free Framework web application micro-framework. The application stores sensor readings from deployed "Data Collection Units" in a Wireless Sensor Network.

* Listens for incoming HTTP POST requests via the /reading method and stores them in a MySQL database if valid.

## Background

This software was developed as part of the [Smart IP](http://www.smart-ip.eu/) project to support the trial of an on-street Wireless Sensor Network in parts of Manchester, UK.

## Requirements

* PHP 5.3+
* Apache HTTP Server v2.2+
* mod_rewrite module enabled in Apache
* MySQL Database Server v5+

## Installation

Clone / download the files to your web server.

Create an Apache virtual host and point the public directory to the /public directory of this application.

Set up a MySQL database and ensure the database name, user and password are matched to those in the /config/db.cfg file.

The db.sql file contains example data you can use to set up the database.

## License

Note: This license statement applies to everything except the /lib directory which contains a copy of the Fat Free Framework. See: [http://fatfreeframework.com/home](http://fatfreeframework.com/home)

This program is free software: you can redistribute it and/or modify it under the terms of the version 3 GNU General Public License as published by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).

Thanks for reading!