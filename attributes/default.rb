
default['iot-device']['user'] = 'pi'
default['iot-device']['group'] = 'pi'
default['iot-device']['homedir'] = '/home/pi'

default['iot-device']['enable-samba'] = true
default['iot-device']['samba-user'] = 'pi'
default['iot-device']['samba-passwd'] = 'changeit'


default['iot-device']['git-name'] = ''
default['iot-device']['git-email'] = ''

default['iot-device']['repos'] = {'raspberrypi-pin-onoff' => 'https://github.com/kmkingsbury/raspberrypi-pin-onoff.git'}

default['iot-device']['enable-ntp'] = true
default['ntp']['servers'] = ['pool.ntp.org', '0.ubuntu.pool.ntp.org']
