<html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> #文字コードUTF8
 <title>BBS</title>
 </head>
 <body>
 <form action="regist.php" method="post"> #データの送信先
 お名前：<br />
 <input type="text" name="name" size="30" value="" /><br />
 内容：<br />
 <textarea name="message" cols="30" rows="5">

 <br />
 <input type="submit" value="つぶやく />
 </form> #ここまでが投稿フォームを表示するHTML
<?php
$con = mysql_connect('127.0.0.1', 'root', '1234'); #Mysqlのログインパスワードを記入
 if (!$con) {
exit('データベースに接続できませんでした。');
 }
$result = mysql_select_db('phpdb', $con);
 if (!$result) {
  exit('データベースを選択できませんでした。');
 }
$result = mysql_query('SET NAMES utf8', $con);
 if (!$result) {
  exit('文字コードを指定できませんでした。');
 }
$result = mysql_query('SELECT * FROM messages ORDER BY no DESC', $con);
 while ($data = mysql_fetch_array($result)) {
  echo "<p>\n";
  echo '[No.' . $data['no'] . '] ' . htmlspecialchars($data['name'], ENT_QUOTES) . ' ' . $data['created'] . "
\n";
  echo "<br />\n";
  echo nl2br(htmlspecialchars($data['message'], ENT_QUOTES));
  echo "</p>\n";
 }

$con = mysql_close($con);
 if (!$con) {
  exit('データベースとの接続を閉じられませんでした。');
 }

?>
 </body>
 </html>
