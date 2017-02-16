#
# Cookbook Name:: webserver
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
package 'httpd' 

service 'httpd' do
 action [:enable, :start]
end
file '/var/www/html/index.html' do
 content '<html>
 <body>
<h1> SRE CHALLENGE</h1>
</body>
</html>'
end

