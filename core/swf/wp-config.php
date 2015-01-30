<?php
/**
 * La configuration de base de votre installation WordPress.
 *
 * Ce fichier contient les réglages de configuration suivants : réglages MySQL,
 * préfixe de table, clefs secrètes, langue utilisée, et ABSPATH.
 * Vous pouvez en savoir plus à leur sujet en allant sur 
 * {@link http://codex.wordpress.org/Editing_wp-config.php Modifier
 * wp-config.php} (en anglais). C'est votre hébergeur qui doit vous donner vos
 * codes MySQL.
 *
 * Ce fichier est utilisé par le script de création de wp-config.php pendant
 * le processus d'installation. Vous n'avez pas à utiliser le site web, vous
 * pouvez simplement renommer ce fichier en "wp-config.php" et remplir les
 * valeurs.
 *
 * @package WordPress
 */

// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //
/** Nom de la base de données de WordPress. */
define('DB_NAME', 'meteoserbwp');

/** Utilisateur de la base de données MySQL. */
define('DB_USER', 'meteoserbwp');

/** Mot de passe de la base de données MySQL. */
define('DB_PASSWORD', 'h60qiCgG');

/** Adresse de l'hébergement MySQL. */
define('DB_HOST', 'mysql5-10.pro');

/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define('DB_CHARSET', 'utf8');

/** Type de collation de la base de données. 
  * N'y touchez que si vous savez ce que vous faites. 
  */
define('DB_COLLATE', '');

/**#@+
 * Clefs uniques d'authentification et salage.
 *
 * Remplacez les valeurs par défaut par des phrases uniques !
 * Vous pouvez générer des phrases aléatoires en utilisant 
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ le service de clefs secrètes de WordPress.org}.
 * Vous pouvez modifier ces phrases à n'importe quel moment, afin d'invalider tous les cookies existants.
 * Cela forcera également tous les utilisateurs à se reconnecter.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'DR+kay(TfPYLSotU+!g0G;7^+UcEbZ^|*:Ygk^KRJR<sG}hsNVy:+`,}O?3 mA%2'); 
define('SECURE_AUTH_KEY',  'GbIoQw<A~l|{Ch$d|P;S+-l1TR)<@Lf+e?,h-u;*IZZm%xg)_g]JnkH6N|D63v:J'); 
define('LOGGED_IN_KEY',    '+o8/_k4pG?Dp|V|y2=5-*|(!109yS;C+SP$r6=f[X+>4*:OpW{]enp*6*Rjal$=?'); 
define('NONCE_KEY',        '{8oN}a Vau|W|VvDFV ik-r7_2qZz-t op3[rVb;0hD*LCuB[GVdf{rKl;[Mqz!6'); 
define('AUTH_SALT',        'u= wFm@e&F?N`v,dR~Cg:]/+m`(Ta6tcZ/OzDo$NCq7r^Wy}LZcW:)-!yo>A.WMP'); 
define('SECURE_AUTH_SALT', 'C)q,[Kv@HKy4mcCp-Sk;7^_4xreo*LM;*)K_wnSz+EU|Y`Zf.>k#CQkWr-#m3?> '); 
define('LOGGED_IN_SALT',   'T_i8f6}1`0d58jNJ,y=7+VGqmd>oEI)4R_*Pim;Zj:>P{-(U @#bG6.]EQXhF4zF'); 
define('NONCE_SALT',       'S |Op|nAlEylJM4jv7/T~Ur7.Z5 Gr_h+|8sZx-Phe{R 8ieT&gg/8B02Tu4x1E['); 
/**#@-*/

/**
 * Préfixe de base de données pour les tables de WordPress.
 *
 * Vous pouvez installer plusieurs WordPress sur une seule base de données
 * si vous leur donnez chacune un préfixe unique. 
 * N'utilisez que des chiffres, des lettres non-accentuées, et des caractères soulignés!
 */
$table_prefix  = 'wp_meteo';

/**
 * Langue de localisation de WordPress, par défaut en Anglais.
 *
 * Modifiez cette valeur pour localiser WordPress. Un fichier MO correspondant
 * au langage choisi doit être installé dans le dossier wp-content/languages.
 * Par exemple, pour mettre en place une traduction française, mettez le fichier
 * fr_FR.mo dans wp-content/languages, et réglez l'option ci-dessous à "fr_FR".
 */
define ('WPLANG', 'fr_FR');

/** 
 * Pour les développeurs : le mode deboguage de WordPress.
 * 
 * En passant la valeur suivante à "true", vous activez l'affichage des
 * notifications d'erreurs pendant votre essais.
 * Il est fortemment recommandé que les développeurs d'extensions et
 * de thèmes se servent de WP_DEBUG dans leur environnement de 
 * développement.
 */ 
define('WP_DEBUG', false); 
define( 'MULTISITE', true );
define( 'SUBDOMAIN_INSTALL', false );
$base = '/parkwp/';
define( 'DOMAIN_CURRENT_SITE', 'www.meteo-serv1.com' );
define( 'PATH_CURRENT_SITE', '/parkwp/' );
define( 'SITE_ID_CURRENT_SITE', 1 );
define( 'BLOG_ID_CURRENT_SITE', 1 );/* C'est tout, ne touchez pas à ce qui suit ! Bon blogging ! */
/** Chemin absolu vers le dossier de WordPress. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');
define ('WP_ALLOW_MULTISITE', true  ) ;
/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once(ABSPATH . 'wp-settings.php');