#
# Cookbook:: task1_apache
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
package %w(httpd php) do
  action :install
end
service 'httpd' do
  supports :restart => true
  action [ :enable, :start ]
end


cookbook_file "/var/www/html/phpinfo.php" do
  source "phpinfo.php"
  notifies :restart, 'service[httpd]', :immediately
end

