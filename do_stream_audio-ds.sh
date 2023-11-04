#!/bin/bash
#MICROSOURCE=1
#HEADPHONES=0

function On () {
  # This puts the microphone into the Combined_Output
  pactl load-module module-null-sink sink_name=Combined_Output sink_properties=device.description=Combined_Output
  pactl load-module module-null-sink sink_name=Recorded_Sink sink_properties=device.description=Recorded_Sink
  pactl load-module module-loopback source=@DEFAULT_SOURCE@ sink=Combined_Output
  pactl load-module module-loopback source=Recorded_Sink.monitor sink=Combined_Output
  pactl load-module module-loopback source=Recorded_Sink.monitor sink=@DEFAULT_SINK@
  pactl load-module module-remap-source master=Combined_Output.monitor source_properties=device.description=Combined_for_ds
}

function Off () {
  # This unloads the module-loopback and restores audio
  pactl unload-module module-loopback
  pactl unload-module module-null-sink
  #pactl unload-module module-remap-source
}

if [ "$1" == "On" ] ; then
  On

elif [ "$1" == "Off" ] ; then 
  Off 
 
elif [ "$1" == "Toggle" ] ; then
  pactl list modules |grep module-null-sink >/dev/null
  GREPEXIT=$?
  if [ $GREPEXIT -ne 0 ] ; then
     echo "Toggle from Off"
     On
  else
     echo "Toggle from On"
     Off
  fi 
  
else
  echo "Please specify: "
  echo "`basename $0`: On|Off|Toggle"

fi
