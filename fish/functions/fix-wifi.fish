function fix-wifi
 echo 1 | sudo tee /sys/bus/pci/devices/0000:01:00.0/remove && echo 1 | sudo tee /sys/bus/pci/rescan; 
end
