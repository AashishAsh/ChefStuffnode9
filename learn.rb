
package 'apache' do
   package_name 'httpd'
end

%w{vim tree emacs}.each do |pkg|
package pkg do
 action :install
end
end 



service 'httpd' do
 action [:enable, :start]
end

file '/var/www/index.html' do
 content 'hello mani pramod pavan aashish '
 action :delete
end

file '/var/www/html/index.html' do
 content 'hello mani pramod pavan aashish '
 mode '0755'
 owner 'root'
 group 'apache'
end

execute 'nothing' do
 command 'ls -a'
end

execute 'git' do
 command 'git clone gitlink'
end

execute 'only-if-example' do
 command 'echo "aashish has changed the changes using only_if in chef">> /etc/hosts' 
 only_if 'test -z $(grep "aashish has changed the changes using only_if in chef" /etc/hosts)'
end 
