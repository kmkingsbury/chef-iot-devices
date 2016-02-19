
default['user'] = 'pi'
default['group'] = 'pi'
default['homedir'] = '/home/pi'

default['samba-user'] = 'pi'
default['samba-passwd'] = 'changeit'


default['git-name'] = ''
default['git-email'] = ''

default['repos'] = {'raspberrypi-pin-onoff' => 'https://github.com/kmkingsbury/raspberrypi-pin-onoff.git'}

default['ntp']['servers'] = ['pool.ntp.org', '0.ubuntu.pool.ntp.org']
