<?php
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;

$app = AppFactory::create();
$app->addBodyParsingMiddleware();
$app->addRoutingMiddleware();
$app->addErrorMiddleware(true, true, true);

$app->get('/', function (Request $request, Response $response, $args) {
    $response->getBody()->write("Hello world!");
    return $response;
});

$app->get('/api/users', function(Request $request, Response $response, $args) {
   $sql = "select * from patients";
   try{
$db = new db();
$pdo = $db->connect();
$stmt = $pdo->query($sql);
$user=$stmt->fetchAll(PDO::FETCH_OBJ);
   }
   catch(\PDOException $e){
   	echo '{"msg":{"resp":'.$e->getMessage().'}}';

   }
   $response->getBody()->write((string)json_encode($user));
    return $response;
});

$app->post('/api/users', function(Request $request, Response $response, $args) {
  
   try{
   	$params = $request->getParsedBody();
   	$name = $params['name'];
   	$first_name = $params['first_name'];//$request->getParam('first_name');
   	$last_name = $params['last_name'];//$request->getParam('last_name');
   	$email = $request->getParsedBody()['email'];//$request->getParam('email');
   	$password = $request->getParsedBody()['password'];//$request->getParam('password');
   	 $sql = "INSERT INTO `patients`(`name`, `first_name`, `last_name`, `email`, `password`)
			values('$name','$first_name','$last_name','$email','$password')";
$db = new db();
$pdo = $db->connect();
$stmt = $pdo->query($sql);

   }
   catch(\PDOException $e){
   	echo '{"msg":{"resp":'.$e->getMessage().'}}';

   }
   $response->getBody()->write((string)json_encode($stmt));
    return $response;
});

$app->run();