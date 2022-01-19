#!/bin/bash
#cd /projects/vendors/fastplaz/
#git pull origin development

echo Update done
echo
echo Running Apache ..
echo
echo try from your browser
echo http://localhost:8080
echo
echo ECHO Example 
echo http://localhost:8080/echo/?val1=value1
echo
echo Try with any parameters using GET or POST method
echo
echo 
echo press Ctrl+C to exit
/usr/sbin/apache2ctl -D FOREGROUND



