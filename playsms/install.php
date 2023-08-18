<?php

function dbIsUp() {
    try {
        $dsn = "mysql:host={$_ENV['DBHOST']};dbname={$_ENV['DBNAME']}";
        echo "Connecting to MySQL...\n";
        new PDO($dsn, $_ENV['DBUSER'], $_ENV['DBPASS']);
    } catch(Exception $e) {
        echo $e->getMessage()."\n";
        return false;
    }
    return true;
}
while(!dbIsUp()) {
    sleep(1);
}

echo "Setup database...\n";
$dbh= new PDO("mysql:host={$_ENV['DBHOST']};dbname={$_ENV['DBNAME']}", $_ENV['DBUSER'], $_ENV['DBPASS']);
$dbh->exec(file_get_contents($_ENV['PATHSRC'] . '/db/playsms.sql'));
$dbh->exec("SET AUTOCOMMIT = 1;UPDATE playsms_tblUser SET password='" . password_hash($_ENV['ADMINPASSWORD'], PASSWORD_BCRYPT) . "',salt='' WHERE uid=1;");
echo "Setup database finished...\n";