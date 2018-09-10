package 'nginx' do
  action :install
end


service 'nginx' do
  supports :restart => true
  action [ :enable, :start ]
end 

template '/etc/nginx/conf.d/server.conf' do
  source 'server.erb'
  variables(
    jbossip: search(:node, 'roles:jboss')[0]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first,
    jbossport: node['jbossport'],
    jbossapp: node['jbossapp'],
    nginxport: node['nginxport'])
  notifies :restart, 'service[nginx]'
end

template '/usr/share/nginx/html/secret.html' do
  source 'secret.erb'
  variables(
    secret: search(:nginx_conf, "id:secret")[0]["lab"]["secret"]
           )
  sensitive true
  notifies :restart, 'service[nginx]'
end

