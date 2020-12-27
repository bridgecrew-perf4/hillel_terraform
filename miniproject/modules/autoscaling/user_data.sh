#!/bin/bash
yum update
yum -y install httpd

systemctl start httpd

echo "<h1>$(curl -s http://169.254.169.254/latest/meta-data/instance-id)</h1>" >> /var/www/html/index.html
echo "<h2>$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)</h2>" >> /var/www/html/index.html