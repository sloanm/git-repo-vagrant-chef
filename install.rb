
package 'nginx' do
  action :install
end
package 'mysql-server' do 
  action :install 
end
package  'mysql-client' do 
  action :install 
end
package 'libmysqlclient-dev' do
  action :install 
end 	
package 'rake' do
  action :install 
end
bash 'install_rvm' do
 user 'root'
 cwd '/tmp'
 code <<-EOH
 gem install bundler
 curl -sSL https://get.rvm.io | bash -s stable --rails
 source /usr/local/rvm/scripts/rvm
 bundle install
 rvm get stable --auto-dotfiles
 EOH
end
bash 'install_bundler' do
 user 'root'
 cwd '/tmp'
 code <<-EOH
 gem install bundler
 source /usr/local/rvm/scripts/rvm
 EOH
end

bash 'install_nodejs' do
 user 'root'
 cwd '/tmp'
 code <<-EOH
 curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
 EOH
end
package 'nodejs' do
  action :install
end
bash "append_to_config" do
  user "root"
  code <<-EOF
     cat /vagrant/env-vars >> /etc/environment 
     source /etc/environment
     npm update
  EOF
  not_if "grep -q CRYPTO_RAGE /etc/environment"
end
