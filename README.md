# switch-sink

An audio Sink switcher, based on [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/).
Allows you to change the default output sound device, and to route the audio of any program currently running into it.

## What is a sink?

A sink is an output device. It is an active unit that consumes samples.

The typical sink represents an output sound device, e.g. headphones connected to a sound card line output or on a Bluetooth headset. PulseAudio automatically creates a sink for every detected output device.

## How-To

1. List the available sinks to switch to:
```shell
$ ./switch-sink.sh -l
Available system Sinks:
ID      NAME
3       alsa_output.usb-Generic_USB_Audio-00.analog-stereo      module-alsa-card.c      s16le 2ch 44100Hz       SUSPENDED
33      alsa_output.pci-0000_2d_00.1.hdmi-stereo        module-alsa-card.c      s16le 2ch 44100Hz       SUSPENDED
34      alsa_output.usb-Focusrite_Scarlett_2i2_USB_Y8Y7A7Z126CB3C-00.analog-stereo      module-alsa-card.c      s32le 2ch 44100Hz       SUSPENDED
35      alsa_output.usb-PreSonus_Revelator_IO_24_AB7C21322604-00.analog-surround-21     module-alsa-card.c      s32le 3ch 44100Hz       SUSPENDED
```

2. Switch to the desired sink by its name:
```shell
$ ./switch-sink.sh alsa_output.usb-Focusrite_Scarlett_2i2_USB_Y8Y7A7Z126CB3C-00.analog-stereo
Set default sink: alsa_output.usb-Focusrite_Scarlett_2i2_USB_Y8Y7A7Z126CB3C-00.analog-stereo
```

3. Or by its ID:
```shell
$ ./switch-sink.sh 34
Set default sink: 34
```
