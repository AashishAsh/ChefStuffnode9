include_recipe 'java'

#tmp_path = Chef::Config[:file_cache_path]
user node['tomcat8']['tomcat_user'] do    
     comment 'Apache Tomcat'
     uid '91'
#     gid '91'
     home node['tomcat8']['tomcat_user']
     shell '/sbin/nologin'
end

## other way to create user
#execute 'execute_create_user' do
#  command 'useradd tomcat -d /opt/greensky -c "apache tomcat" -u 91 -m -s /sbin/nologin'
#  only_if 'test -z $(ls /opt/ | grep greensky)'
#end
#
group node['tomcat8']['tomcat_user'] do
 action :create
 members node['tomcat8']['tomcat_user']
 gid '91'
end

#chmod 
directory node['tomcat8']['install_location'] do
  owner node['tomcat8']['tomcat_user']
  group node['tomcat8']['tomcat_user']
  mode '0755'
end

#create a tomcat8 directory , no need mention action due to default is to create
%w[ /var/log/tomcat8 /var/run/tomcat].each do |path|
directory path do
  owner node['tomcat8']['tomcat_user']
  group node['tomcat8']['tomcat_user']
end
end

#create a softlink to the init script , no need to mention link_type by default it is symbolic(softlink)
link '/etc/init.d/tomcat8' do
  to '/opt/greensky/tomcat8/init.d/tomcat8'
  link_type :symbolic
end

#create tomcat install dir
execute 'extract_some_tar' do
# ====doubt==> command 'wget default['tomcat8']['download_url']'
  command <<-EOH
     wget http://gs-scm-00.greensky.local/artifactory/ext-release-local/com/greensky/devops/tomcat8/8.0.28/greensky-tomcat8.tar.gz && tar xzvf greensky-tomcat8.tar.gz && rm -f greensky-tomcat8.tar.gz
  EOH
  cwd '/opt/greensky'
  not_if { File.exists?("/opt/greensky/tomcat8") }
end
 

# Create the directory Components
directory '/opt/greensky/components' do 
  owner node['tomcat8']['tomcat_user']
  group node['tomcat8']['tomcat_user']
  mode '0755'
end

#Install server.xml from template
template "/opt/greensky/tomcat8/bin/setenv.sh" do
  source 'setenv.sh.erb'
  owner node['tomcat8']['tomcat_user']
  mode '0644'
end

#Install server.xml from template
template "/etc/sysconfig/network-scripts/ifcfg-eth0" do
  source 'ifcfg-eth0.erb'
  owner node['tomcat8']['tomcat_user']
  mode '0644'
end

#Install server.xml from template
template "/etc/hosts" do
  source 'hosts.erb'
  owner node['tomcat8']['tomcat_user']
  mode '0644'
end

#Install server.xml from template
template "/etc/sysconfig/network" do
  source 'network.erb'
  owner node['tomcat8']['tomcat_user']
  mode '0644'
end

#Install server.xml from template
template "/etc/resolv.conf" do
  source 'resolv.conf.erb'
  owner node['tomcat8']['tomcat_user']
  mode '0644'
end
#Extract the tomcat archive to the install location
#bash 'Extract tomcat archive' do
#  user node['tomcat8']['tomcat_user']
#  cwd node['tomcat8']['install_location']
#  code <<-EOH
#    tar -zxvf #{tmp_path}/tomcat8.tar.gz --strip 1
#  EOH
#  action :run
#end

#Install init script
#template "/etc/init.d/tomcat8" do
#  source 'tomcat8.erb'
#  owner 'root'
#  mode '0755'
#end

#Start and enable tomcat service if requested
service 'tomcat8' do
  action [:enable, :start]
  only_if { node['tomcat8']['autostart'] }
end
