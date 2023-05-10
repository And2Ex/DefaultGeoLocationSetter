# DefaultLocationSetter
About the program
This program creates a batch file to quickly change the default location on your Windows computer. The default location is used when the actual location is unavailable or when the location service is turned off.

How to use the program
Run the program.
The program will set default coordinates in settings and prompt you to press Enter to continue.
The program will retrieve the current default location from the registry.
Enter a filename for the batch file that will be created.
The program will write the command to write the default location to the new batch file.
The program will restart the location service and check if the SplunkForwarder service is running.
The batch file will be saved to your desktop.
Note: You can remove the code related to checking the SplunkForwarder service if it is not applicable to your use case.
