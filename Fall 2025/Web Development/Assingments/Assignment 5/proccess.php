<?php
// Use whichever method was used (GET or POST)
$data = $_REQUEST;
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Form Results</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 2rem;
    }
    table {
      border-collapse: collapse;
      width: 70%;
      margin-top: 20px;
    }
    table, th, td {
      border: 1px solid #333;
    }
    th, td {
      padding: 8px;
      text-align: left;
    }
    th {
      background: #f2f2f2;
    }
  </style>
</head>
<body>
  <h1>Form Submission Results</h1>

  <table>
    <tr>
      <th>Field</th>
      <th>Value</th>
    </tr>
    <?php
      foreach ($data as $key => $value) {
        echo "<tr>";
        echo "<td>" . htmlspecialchars($key) . "</td>";
        echo "<td>";
        if (is_array($value)) {
          // Handle multiple selections
          echo implode(", ", array_map("htmlspecialchars", $value));
        } else {
          echo htmlspecialchars($value);
        }
        echo "</td>";
        echo "</tr>";
      }
    ?>
  </table>
</body>
</html>
