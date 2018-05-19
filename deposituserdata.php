<?php

$userFirstName = $_POST["fname"];
$userLastName = $_POST["lname"];
$userEmail = $_POST["email"];
$userPhone = $_POST["phone"];
$userCurrentLocationLat = $_POST["userCurrentLocationLat"];
$userCurrentLocationLong = $_POST["userCurrentLocationLong"];


//just some DB setup:
$servername = "localhost";
$username = "INSERT ME WHEN IN THE SERVER FILE";
$password = "INSERT ME WHEN IN THE SERVER FILE";
$dbname = "HawaiianWeather";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "INSERT INTO Users (firstname, lastname, email)
VALUES ('John', 'Doe', 'john@example.com')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();

?>