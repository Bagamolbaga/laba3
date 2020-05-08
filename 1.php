<?php
  require_once 'connection.php';

  $str = "Здравствуйте, вы выбрали эти фильтры:<br>";
  $socket = $_POST['socket'];
  $memory_type = $_POST['memory-type'];


  function addFilterCondition($where, $add, $key) {
      $where .= "(";
      for ($i = 0; $i < count($add); $i++) {
        $where .= $key . ' = "' . $add[$i] . '" ';
        if ($i + 1 < count($add)) {
          $where .= ' OR ';
        }
      }
      $where .= ")";
      return $where;
  }

  function addFilterConditionAnd($where, $add) {
      $where .= "AND ";
      $where .= "(";
      for ($i = 0; $i < count($add); $i++) {
        $where .= 'memory_type = "' . $add[$i] . '" ';
        if ($i + 1 < count($add)) {
          $where .= ' OR ';
        }
      }
      $where .= ")";
      return $where;
  }

  $query = 'SELECT * FROM motherboard WHERE ';
  $where = "";

  if (isset($socket) || isset($memory_type)) {
    if (isset($socket) && isset($memory_type)) {
      if (isset($socket)) {
        $query .= addFilterCondition($where, $socket, 'socket');
      }

      if (isset($memory_type)) {
        $query .= addFilterConditionAnd($where, $memory_type);
      }
    } else {
      if (isset($socket)) {
        $query .= addFilterCondition($where, $socket, 'socket');
      }
      if (isset($memory_type)) {
        $query .= addFilterCondition($where, $memory_type, 'memory_type');
      }
    }
  }

  $result = mysqli_query($mysql, $query);

  while ($row = mysqli_fetch_array($result)) {
    echo "<br>";
    for ($i = 0; $i < count($row); $i++) {
      echo $row[$i] . " ";
    }
    echo "<br>";
  }
