<?php

use function PHPSTORM_META\sql_injection_subst;

$db =mysqli_connect('localhost', 'root', '','project');
if(!$db) {
    echo "Database connection failed"; 
}
?>