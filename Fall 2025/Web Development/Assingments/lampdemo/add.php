 <?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Collect input
    $firstname = htmlspecialchars($_POST['first']);
    $lastname  = htmlspecialchars($_POST['last']);
    $country   = htmlspecialchars($_POST['country']);
    $age       = intval($_POST['age']);
    $email     = htmlspecialchars($_POST['email']);

    echo "<p>Adding <strong>$firstname $lastname</strong> from $country.</p>";

    // DB credentials
    $servername = "localhost";
    $username   = "user33"; 
    $password   = "33ross"; 
    $dbname     = "db33"; 

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Insert user
        $stmt = $conn->prepare("INSERT INTO randuser (first, last, country, age, email) VALUES (:first, :last, :country, :age, :email)");
        $stmt->bindParam(':first', $firstname);
        $stmt->bindParam(':last', $lastname);
        $stmt->bindParam(':country', $country);
        $stmt->bindParam(':age', $age);
        $stmt->bindParam(':email', $email);
        $stmt->execute();

        echo "<p>New record created successfully!</p>";

        // Display all users
        $sql = "SELECT first, last, country, age, email FROM randuser";
        $result = $conn->query($sql);

        echo "<table border='1'>";
        echo "<thead><tr><th>First</th><th>Last</th><th>Country</th><th>Age</th><th>Email</th></tr></thead><tbody>";
        while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            echo "<tr>
                    <td>".htmlspecialchars($row['first'])."</td>
                    <td>".htmlspecialchars($row['last'])."</td>
                    <td>".htmlspecialchars($row['country'])."</td>
                    <td>".htmlspecialchars($row['age'])."</td>
                    <td>".htmlspecialchars($row['email'])."</td>
                  </tr>";
        }
        echo "</tbody></table>";

    } catch (PDOException $e) {
        echo "<p>Error: " . $e->getMessage() . "</p>";
    }
    $conn = null;
} else {
    echo "<p>No data submitted.</p>";
}
?>
