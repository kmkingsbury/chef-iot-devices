#
# Cookbook Name:: iot-devices
# Recipe:: default
#
# Copyright (c) 2016 Kevin Kingsbury, All Rights Reserved.

# Raspberry Pi has Chef 11 which doesn't like the array of packages
package 'tmux'
package 'vim'
package 'tightvncserver'
package 'gnuplot-x11'
package 'curl'
package 'samba'

# Setup Git
template "#{node['homedir']}/.gitconfig" do
  source 'gitconfig.erb'
  owner node['user']
  group node['group']
  mode '0644'
  variables({
     'gitname' => node['git-name'],
     'gitemail' => node['git-email']
  })
end

directory '/code' do
  owner node['user']
  group node['group']
  mode '0755'
  action :create
end

# Get our Git Repos
node['repos'].each_pair do |name, url|
  git "/code/#{name}" do
    repository url
    revision 'master'
    action :sync
  end
end

# Setup Samba for simple sharing
template '/etc/samba/smb.conf' do
  source 'samba.erb'
  owner node['user']
  group node['group']
  mode '0644'
  variables({
     'smbuser' => node['samba-user']
  })
  notifies :reload, 'service[samba]', :immediately
end

samba_user node['samba-user'] do
  password node['samba-passwd']
  action [:create, :enable]
end

service 'samba' do
#  pattern 'smbd'
  action [:enable, :start]
end

# include the recipe
include_recipe 'ntp'
