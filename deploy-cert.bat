@echo off
REM small script to use racadm to upload a key and cert to the idrac of a Dell server. Tested on R620 and R630
REM The cert needs to have both the private key (generally a .key file) and the public cert (a .crt file)
REM Once uploaded the idrac reboots and hopefully no more cert errors.
REM Any problems or questions - contact@gdwnet.com or twitter: @garyw_
REM www.gdwnet.com
REM Hope you find it useful

echo iDRAC cert deployment script. This script WILL reboot the idrac.

pause

if [%1] == [] goto end_error
if [%2] == [] goto end_error
if [%3] == [] goto end_error
if [%4] == [] goto end_error

echo Working on Server: %1
echo Part 1 - Deploy Key
racadm -r %1 -u root -p %2 sslkeyupload -t 1 -f %3
echo part 2 - Deploy cert
racadm -r %1 -u root -p %2 sslcertupload -t 1 -f %4
racadm -r %1 -u root -p %2 racreset

exit /B

:end_error
echo Something went wrong, one of the args was blank.
Echo deploy-cert.bat [Server name] [iDRAC password for ROOT] [Cert Key] [Cert CRT file]



