nginx 'download' do
  version node['nginxversion']
  url node['nginxurl']
  jbossip search(:node, 'roles:jboss')[0]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first
  jbossport node['jbossport']
  jbossapp node['jbossapp']
  nginxport node['nginxport']
  secret search(:nginx_conf, "id:secret")[0]["lab"]["secret"]
  action :install

end
