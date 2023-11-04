# README for do_stream_audio-ds.sh

This script can mix microphone and software audio to get a pulseaudio device to feed Discord, so you can stream both voice and software audio (for instance, games) to the Web.

It assumes you have your input and output devices as **default ones**.

### Prerequisites

  * A working pulseaudio setup with module-loopback and module-null-sink
  * bash shell
  * Pulseaudio volume control (pavucontrol), if you know your way around pulseaudio you can use a different software
  * You don't use module-loopback and module-null-sink (they will be unloaded whe you turn off the configuration with the Off option)

### SETUP

 * Download `do_stream_audio-ds.sh` and make it executable, if you want you can put it in your ~/bin directory for ease of access, or you can have it whereever you want and launch it with the full path.
 * Configure beforehand your device setup (usually, plug in the headphones, the microphone and select them as default devices)
 * Test your setup, sometimes it does not work as expected in Discord, this is not my script fault ;)

### USAGE

#### 1. Enable the configuration

```bash
$ ./do_stream_audio-ds.sh
Please specify: 
do_stream_audio-ds.sh: On|Off|Toggle
```

You can invoke `do_stream_audio-ds.sh` with On, Off or Toggle arguments. Yes, the capitalization is on purpose so I do not make mistakes :P

Toggle checks if the module-null-sink is loaded, if it is, it unloads the modules and reset the pulsaudio configuration (just if you choose Off), if it isn't loads the configuration like if you choose On.

#### 2. Setting up the application

After enabling the pulseaudio configuration, use Pulse Audio volume control to make your sound producing application use the “Recorded_Sink” destination (you can find the option in a drop down menu in the Playback tab which is the first)

**Notice**: The “Recorded_Sink” device is setup by the script so if there are errors, you won't get the device in Pulseaudio, also if you have only a single device you don't see any pull down menu to choose the audio destination in Pulse Audio Volume Control.

#### 3. Setting up Discord

In discord “Voice and Video” choose “Combined_Output” as your microphone device. Now the application audio **and** your microphone are mixed into the device and Discord shoud pick them up.

**Notice**: I recommend turning off voice activation of Discord and keep the newly created “microphone” always on to avoid silencing the audio if the software produces a low-volume audio.

### TIPS

  * You can assign a hotkey in your desktop environment to execute `do_stream_audio-ds.sh Toggle` do turn the setup on or off.