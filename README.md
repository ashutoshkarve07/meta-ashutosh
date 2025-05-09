# meta-ashutosh



if your web-ui is not working clone this and flow few commands when you login through ssh in raspberry pi 4

After Raspberry pi login
Boot and initial login
systemctl status bmcweb
Troubleshooting
touch /var/log/redfish
systemctl restart bmcweb
netstat -tlnp | grep 443

