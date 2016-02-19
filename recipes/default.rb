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

# Setup Git
template "#{node['iot-device']['homedir']}/.gitconfig" do
  source 'gitconfig.erb'
  owner node['iot-device']['user']
  group node['iot-device']['group']
  mode '0644'
  variables({
     'gitname' => node['iot-device']['git-name'],
     'gitemail' => node['iot-device']['git-email']
  })
end

directory '/code' do
  owner node['iot-device']['user']
  group node['iot-device']['group']
  mode '0755'
  action :create
end

# Get our Git Repos
node['iot-device']['repos'].each_pair do |name, url|
  git "/code/#{name}" do
    repository url
    revision 'master'
    action :sync
  end
end

# Setup Samba for simple sharing
if node['iot-device']['enable-samba'] == true
  package 'samba'

  template '/etc/samba/smb.conf' do
    source 'samba.erb'
    owner node['iot-device']['user']
    group node['iot-device']['group']
    mode '0644'
    variables({
       'smbuser' => node['iot-device']['samba-user']
    })
    notifies :reload, 'service[samba]', :immediately
  end

  samba_user node['iot-device']['samba-user'] do
    password node['iot-device']['samba-passwd']
    action [:create, :enable]
  end

  service 'samba' do
  #  pattern 'smbd'
    action [:enable, :start]
  end
end

# include the recipe
if node['iot-device']['enable-ntp'] == true
  include_recipe 'ntp'
end
