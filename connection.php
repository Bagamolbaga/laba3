<?php
  $db_host = 'localhost';
  $db_user = 'admin';
  $db_password = 'admin1';
  $db_name = 'system_unit';


  $mysql = mysqli_connect($db_host, $db_user, $db_password, $db_name) or die('Error connect to DataBase');
