resource_name :nginx 

property :url, String, default: node['nginxurl']
property :version, String, default: "1.10.0"
property :jbossip, String, default: "127.0.0.1"
property :jbossport, String, default: "8080"
property :jbossapp, String, default: ""
property :nginxport, String, default: "80"
property :secret, String, default: "none"

action :install do

remote_file "/opt/nginx-#{new_resource.version}.rpm" do
  source new_resource.url
end

package "/opt/nginx-#{new_resource.version}.rpm" do
  action :install
end

service 'nginx' do
  supports :restart => true
  action [ :enable, :start ]
end

template '/etc/nginx/conf.d/server.conf' do
  source 'server.erb'
  variables(
    jbossip: new_resource.jbossip,
    jbossport: new_resource.jbossport,
    jbossapp: new_resource.jbossapp,
    nginxport: new_resource.nginxport)
  notifies :restart, 'service[nginx]'
end

template '/usr/share/nginx/html/secret.html' do
  source 'secret.erb'
  variables(
    secret: new_resource.secret 
           )
  sensitive true
  notifies :restart, 'service[nginx]'
end
end
