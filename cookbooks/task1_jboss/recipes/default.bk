cookbook_file '/opt/jdk-6u45-linux-amd64.rpm' do
  source 'jdk-6u45-linux-amd64.rpm'
  action :create
end

rpm_package '/opt/jdk-6u45-linux-amd64.rpm' do
  action :install
end

cookbook_file '/opt/jboss-eap-5.1.2.zip' do
  source 'jboss-eap-5.1.2.zip'
  action :create
end

cookbook_file '/etc/systemd/system/jboss.service' do
  source 'jboss.service'
  action :create
end

execute 'extract_zip' do
  command 'unzip /opt/jboss-eap-5.1.2.zip -d /opt/'
  action :run
end

service 'jboss' do
  action [ :enable, :start ]
end


cookbook_file '/opt/jboss-eap-5.1/jboss-as/server/default/deploy/sample.war' do
  source 'sample.war'
  action :create
end


