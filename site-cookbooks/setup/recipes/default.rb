#
# Cookbook Name:: setup
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nvm"
include_recipe "sendmail"

bash "install npm packages" do
  cwd "/home/vagrant"
  user "root"
  code <<-EOH
    su vagrant
    . /home/vagrant/.nvm/nvm.sh
    nvm use v0.12.7
    npm update -g
    npm install -g gulp bower
  EOH
  action :nothing                                                                    # nvm.shの実行終了したら走らせるためnothingを指定
  subscribes :run, "bash[nvm.sh]", :delayed
end

package "ruby-devel"

bash 'install bundler' do
  user "root"
  code <<-EOH
    gem install bundler
  EOH
end

bash 'install compass' do
  user "root"
  cwd "/home/vagrant/fuelphp/foundation"
  code <<-EOH
    bundler install
  EOH
end
