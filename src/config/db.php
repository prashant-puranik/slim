<?php

class db{

	public function connect()
	{
		$host="localhost";
		$user="root";
		$password="";
		$dbname = "freestate";

		$pdo = new PDO("mysql:host=$host;dbname=$dbname",$user,$password);
		$pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
		$pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE,PDO::FETCH_ASSOC);

		return $pdo;
	}
}
