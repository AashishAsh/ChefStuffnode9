execute 'extract_create_user' do
     command 'useradd tomcat -d /opt/greensky -c "Apache Tomcat" -u 91 -m -s /sbin/nologin'
     only_if 'test -z $(ls /opt/ | grep greensky)'
end
#user 'tomcat' do
#     comment 'Apache Tomcat'
#     uid '91'
#     gid 'tomcat'
#     home '/home/tomcat'
#     shell '/sbin/nologin'
#end
group 'tomcat' do
     action :create
     gid '91'
     members 'tomcat'
end
directory "/home/tomcat" do
    owner 'tomcat'
    group 'tomcat'
    mode '0755'
end
%w[ /var/log/tomcat /var/run/tomcat8 ].each do |path|
directory path do
    owner 'tomcat'
    group 'tomcat'
    mode '0755'
end
end
link  '/etc/init.d/tomcat8' do
 to '/home/tomcat/tomcat8/init.d/tomcat8'
 link_type :symbolic
end
execute 'extract_some_tar' do
# ====doubt==> command 'wget default['tomcat8']['download_url']'
  command 'tar xzvf ash.tar.gz'
  command 'rm -f ash.tar.gz'
  cwd '/home/tomcat'
 # not_if { File.exists?("/home/tomcat/ash.tar.gz") }
end

