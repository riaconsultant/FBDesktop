<?php
//Byte receiver 


$fp = fopen( '../uploads/file.png', 'w' );
fwrite( $fp, $GLOBALS['HTTP_RAW_POST_DATA' ] );
fclose( $fp );

?>