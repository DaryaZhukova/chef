package "unzip" do
 action :install
end

cookbook_file '/opt/jdk-6u45-linux-amd64.rpm' do
  source 'jdk-6u45-linux-amd64.rpm'
  action :create
end

rpm_package '/opt/jdk-6u45-linux-amd64.rpm' do
  action :install
end

remote_file '/opt/jboss.zip' do
 source node['jbossurl']
 notifies :run, 'execute[unzip]', :immediately 
end

execute 'unzip' do
 not_if { ::File.exists?('/opt/jboss-5.1.0.GA/')}
 command 'unzip /opt/jboss.zip -d /opt'
 action :nothing
end

template '/etc/systemd/system/jboss.service' do
  source 'service.erb'
  variables(
    jbossip: node["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first
           )
end

service 'jboss' do
 action [ :enable, :start ]
end

jboss 'deploy' do
  jbossapp node['jbossapp']
  jbossappversion node['jbossappversion']
  action :install
end

