<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>BBS</title>
</head>
<body>

<?php
header("HTTP/1.1 301 Moved Permanently"); #リダイレクト
header("Location: http://adachin.server-on.net/aspace/bbs.php");
if ($_REQUEST['name'] == '' or $_POST['message'] == '') { #名前かメッセージが空白ならば、errorと表示する
    exit('error');
}
$con = mysql_connect('127.0.0.1', 'root', '1234');
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
$name = $_REQUEST['name']; #MySQLにデータを登録
$message = $_REQUEST['message'];
$created = date('Y-m-d H:i:s');
$result = mysql_query("INSERT INTO messages(name, message, created) VALUES('$name', '$message', '$created')", $con);
if (!$result) {
 exit('データを登録できませんでした。');
}
$con = mysql_close($con);
if (!$con) {
exit('データベースとの接続を閉じられませんでした。');
}
?>

<p>投稿しました。</p>
<ul>
 <li><a href="index.php">一覧へ戻る</a></li>
</ul>
</body>
</html>
