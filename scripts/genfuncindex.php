<?php 
/*
  +----------------------------------------------------------------------+
  | PHP Version 4                                                        |
  +----------------------------------------------------------------------+
  | Copyright (c) 1997-2011 The PHP Group                                |
  +----------------------------------------------------------------------+
  | This source file is subject to version 3.0 of the PHP license,       |
  | that is bundled with this package in the file LICENSE, and is        |
  | available through the world-wide-web at the following url:           |
  | http://www.php.net/license/3_0.txt.                                  |
  | If you did not receive a copy of the PHP license and are unable to   |
  | obtain it through the world-wide-web, please send a note to          |
  | license@php.net so we can mail you a copy immediately.               |
  +----------------------------------------------------------------------+
  | Authors:    Hartmut Holzgraefe <hholzgra@php.net>                    |
  +----------------------------------------------------------------------+
 
  $Id$
*/
echo "<" . "?xml version='1.0' encoding='iso-8859-1'?" . ">\n";
?>
<!-- DO NOT EDIT THIS FILE, IT WAS AUTO-GENERATED BY genfuncindex.php -->
<appendix xmlns="http://docbook.org/ns/docbook" xml:id="indexes">
 <title>&FunctionIndex;</title>
 <index xml:id="index.functions">
  <title>&FunctionIndex;</title>
<?php
$functions = file($_SERVER['argv'][1]);
usort($functions,"strcasecmp");
$functions = array_unique($functions);

$letter = ' ';
$letters = range('A', 'Z');
array_push($letters, '_');

foreach ( $functions as $funcentry ) {
    if (False !== strpos($funcentry, "#") || strlen(trim($funcentry)) === 0) {
        continue;
    }
    if (False !== strpos($funcentry, " - ")) {
        list($function,$description) = explode(" - ",$funcentry);
    } else {
        $function = $funcentry;
    }

    if (!preg_match("/::|->/", $function)) {
        $function = strtolower(trim($function));
    }

    $function = str_replace('>', '&#62;', $function);

    if (strtolower($function{0}) != $letter) {
        if ($letter != ' ') {
            echo "  </indexdiv>\n";
        }
        $letter = strtolower($function{0});
	echo "  <indexdiv>\n";
	echo "   <title id=\"index.functions.$letter\">".strtoupper($letter)."</title>\n";
    }
    echo "   <indexentry><primaryie><function>$function</function></primaryie></indexentry>\n";
}
?>
  </indexdiv>
 </index>
 <para></para>
</appendix>
