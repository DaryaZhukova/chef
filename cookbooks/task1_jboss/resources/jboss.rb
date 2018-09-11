resource_name :jboss

property :jbossappversion, String, default: ""
property :jbossapp, String, default: "sample"

action :install do

cookbook_file '/opt/jboss-5.1.0.GA/server/default/deploy/sample.war' do
 source "#{new_resource.jbossapp}-#{new_resource.jbossappversion}.war"
 action :create
end
end
