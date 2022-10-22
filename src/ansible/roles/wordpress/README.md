# WordPress Install Role

## Variables

| Variable | Value | Description |
| :--- | :--- | :--- |
| `db_user` | `wordpress` | DB user |
| `db_pass` | `` | DB user password |
| `db_name` | `wordpress` | Wordpress DB name |
| `db_host` | `db01` | Wordpress DB hostname |
| `owner` | `www-data` | Owner root |
| `group` | `www-data` | Group root |
| `doc_root` | `/var/www/{{ virtual_domain }}` | Path to site containing directory |
| `php_modules` | `shell` | Additional PHP modules |
| `wp_cli_phar_url` | `https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar` | WP-CLI phar download link |
| `wp_cli_bin_path` | `/usr/bin/{{ wp_cli_bin_command }}` | WP cli bin path |
| `wp_cli_bin_command` | `wp` | Execution of WP-CLI command |
