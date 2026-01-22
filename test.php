
<?php

require_once __DIR__ . '/config/database.php';

$db = Database::getInstance()->getConnection();

if ($db) {
    echo "✅ الاتصال بقاعدة البيانات ناجح";
} else {
    echo "❌ فشل الاتصال بقاعدة البيانات";
}
?>