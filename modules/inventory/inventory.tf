
locals {
  inventory = <<INVENTORY
---
${var.instance_ip}

[all:vars]
db_username=${var.rds_user}
db_pass=${var.rds_pass}
db_endpoint=${var.rds_address}
www_directory=/var/www/wordpress
db_name=wordpress
owner_user: www-data
owner_group: www-data

INVENTORY
}
locals {
  wpconfig = <<WPCONFIG
---
<?php
define('DB_NAME', 'wordpress');
define('DB_USER', '${var.rds_user}');
define('DB_PASSWORD', '${var.rds_pass}');
define('DB_HOST', '${var.rds_address}');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
define('AUTH_KEY',         ' ');
define('SECURE_AUTH_KEY',  ' ');
define('LOGGED_IN_KEY',    ' ');
define('NONCE_KEY',        ' ');
define('AUTH_SALT',        ' ');
define('SECURE_AUTH_SALT', ' ');
define('LOGGED_IN_SALT',   ' ');
define('NONCE_SALT',       ' ');
$table_prefix  = 'wp_';
define('WP_DEBUG', false);
if ( !defined('ABSPATH') )
        define('ABSPATH', dirname(__FILE__) . '/');
require_once(ABSPATH . 'wp-settings.php');

WPCONFIG
}

resource "local_file" "inventory" {
    content     = local.inventory
    filename = "${path.root}/ansible/inventory"
}

resource "local_file" "wordpress_config" {
    content     = local.wpconfig
    filename = "${path.root}/ansible/wp-config.php"
}
