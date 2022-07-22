<?php
error_reporting(0);
require "../../inc/bootstrap.php";

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri = explode('/', $uri);

if ($uri[6] == 'listEdit') {
    $name       = $_GET['name'];
    $ap_paterno = $_GET['ap_paterno'];
    $a_materno  = $_GET['a_materno'];
    $curp       = $_GET['curp'];
    $rfc        = $_GET['rfc'];
} else {
    $pro = json_decode($_GET['id']);
}
//var_dump($uri);

//Validamos que en la url vengan los datos para consultar la API
if ((isset($uri[5]) && $uri[5] != 'user') || !isset($uri[6])) {
    header("HTTP/1.1 404 Not Found");
    exit();
}

//mandamoslosdatosalcontroladorpararealizarlaconsultayregresarunjsonparallenarlainformación
require PROJECT_ROOT_PATH . "/Controller/Api/UserController.php";

$objFeedController = new UserController();
$strMethodName     = $uri[6];
$objFeedController->{$strMethodName}();
