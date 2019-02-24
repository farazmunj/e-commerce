<?php
// this file will act as mail conroller for this project..
// check if user has created vendor folder and installed app using composer
// don't need composer unittest and autoloader psr-4 autoloader workign fine.
// if (! file_exists("./vendor")) {
// die("Please install app using composer and put packages in ./vendor folder");
// }
// if (! file_exists("./vendor/autoload.php")) {
// die("App not installed using composer, ./vendor/autoload.php missing. please try 'php composer.phar install'");
// }
// require_once './vendor/autoload.php';
if (! file_exists("./bootstrap.php")) {
    die("./bootstrap.php missing make sure its in root folder of APP");
}

require_once './bootstrap.php';

if (! file_exists("data/user_input.csv")) {
    die("Input file missing, pleae put your file in './data/user_input.csv ");
}

if (empty($argv[1])) {
    die("provide a year to calculate cake day schedule e.g. php index.php 2017");
}

if (strlen($argv[1]) != 4 || ! is_numeric($argv[1])) {
    die("Please enter date in 4 digit format e.g. 2017");
}

CakeDay\Birthday::$testYear = (int) $argv[1];

$csvHandler = new CakeDay\CSVHandler("data/user_input.csv", "data/user_output.csv");
$dateHandler = new CakeDay\UKDateHandeler();

$cakeDayCalculator = new CakeDay\CakeDayCalculator($dateHandler, $csvHandler);
$cakeDayCalculator->exec();
echo PHP_EOL;
echo "Result are stored in file: ./data/user_output.csv";
echo PHP_EOL;