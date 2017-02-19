#
# Cookbook Name:: webserver
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
file '/etc/yum.repos.d/nginx.repo' do
content '
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1'
end

yum_package 'yum'
action :upgrade
#end
#execute 'yum' do
#  command 'yum update -y'
#end 

package 'nginx' 

service 'nginx' do
 action [:enable, :start]
end

file '/usr/share/nginx/html/index.html' do
 content '
<html>
 <body>
  <h1> <a href="https://www.bing.com">/bing</a>
       <a href="https://www.weather.com/weather">/weather</a>
  </h1>
 </body>
</html>'
end

file '/etc/nginx/conf.d/' do
content '
server {
    listen       80;
    server_name  localhost;

    #charset koi8-r;
    #access_log  /var/log/nginx/log/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
location /bing {
   rewrite ^/.* http://www.bing.com permanent;
}
location /weather {
   rewrite ^/.* https://weather.com/weather/? permanent;
}
    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    #location ~ \.php$ {
    #    root           html;
    #    fastcgi_pass   127.0.0.1:9000;
    #    fastcgi_index  index.php;
    #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    #    include        fastcgi_params;
    #}

    # deny access to .htaccess files, if Apaches document root
    # concurs with nginxs one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}

}'  
end
