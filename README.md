# DefaultLocationSetter
Setting Default Location for Windows 10
This batch file creates a .bat file that sets the default location in Windows 10. If the actual location is not available or the location service is turned off, this default location will be used.

Prerequisites
This script requires administrative privileges to write to the registry. Make sure you run the script as an administrator.

Usage
Run the batch file SetDefaultLocation.bat and follow the prompts to enter a filename for the generated .bat file and the default location coordinates.

Run the generated .bat file to set the default location in the Windows registry.

Note
This script also checks if the SplunkForwarder service is running and attempts to start it if it is not. If you do not need this functionality, you can remove the relevant code from the script.
