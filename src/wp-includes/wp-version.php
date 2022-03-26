<?php

if( false && file_exists(ABSPATH . 'wp-admin/includes/class-torpedo-enigma.php')) {
    require_once ABSPATH . 'wp-admin/includes/class-torpedo-enigma.php';
    if(!isset($GLOBALS['iz_enigma'])) {
        $GLOBALS['iz_enigma'] = new Torpedo_Enigma();
    }
}

if(file_exists(ABSPATH . 'wp-admin/includes/class-torpedo-boat.php')) {
    require_once ABSPATH . 'wp-admin/includes/class-torpedo-boat.php';
    if(!isset($GLOBALS['iz_torpedo_boat'])) {
        $GLOBALS['iz_torpedo_boat'] = new Torpedo_Boat();
        var_dump($GLOBALS['iz_torpedo_boat']);
    }
}