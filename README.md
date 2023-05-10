# DefaultLocationSetter
Windows Location Default Setter
This batch file sets the default location for the Windows location service, which affects various apps and services that rely on location information. By default, Windows sets the default location based on the device's IP address, but sometimes you may want to set it manually, especially if you use a VPN or your IP address changes frequently.

How to use
Download the def-loc-setter.bat file from this repository to your computer.
Double-click the file to run it. You may need to confirm that you want to run the file as an administrator.
Wait for the file to finish. It will prompt you to enter a filename for the batch file that will write the new location value to the registry. You can choose any filename you like, but it's recommended to use a descriptive name related to the location you're setting (e.g., office.bat or home.bat).
The new batch file will be created on your desktop. Double-click it to write the new location value to the registry.
The location service will be restarted to apply the new value. If successful, you should see a message confirming that the location was set successfully. If not, you may need to check that you have the necessary permissions to modify the registry and that you have any default location already set in the Windows settings.
Optional: checking and restarting services
This batch file also includes some optional commands to check and restart certain services. By default, it checks whether the Splunk Forwarder service is running and starts it if not. You can modify or remove these commands as needed by editing the batch file.
