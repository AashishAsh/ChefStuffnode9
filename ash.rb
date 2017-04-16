execute 'extract_create_user' do
     command 'useradd tomcat -d /opt/greensky -c "Apache Tomcat" -u 91 -m -s /sbin/nologin'
     only_if 'test -z $(ls /opt/ | grep greensky)'
end

