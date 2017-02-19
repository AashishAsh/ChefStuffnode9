# this is the process of adding the repository

file '/etc/yum.repos.d/nginx.repo' do
content '
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1'
end

# this is process of installing Nginx server

package 'nginx' do
  action :install
end

# this is process of adding the default.conf file to server machine

template '/etc/nginx/conf.d/default.conf' do
  source 'default.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# this is for starting the nginx server

service 'nginx' do
  supports :status => true, :reload => true, :reload => true
  action [:reload, :enable]
end

# this is for opening port range 20000 64000

execute 'increase_port_range' do
  command 'sudo sysctl -w net.ipv4.ip_local_port_range="20000 64000"'
  action :run
end

