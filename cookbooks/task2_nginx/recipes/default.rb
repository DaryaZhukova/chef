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
    nodejboss: search(:node, 'roles:jboss')[0]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first,
    jbossip: node["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first,
    jbossport: "8080",
    jbossapp: "sample")
end

