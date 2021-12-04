import frida
import sys

try:
    session = frida.get_usb_device().attach("Springboard")
except frida.ProcessNotFoundError:
    print("Failed to attach to the target process. Did you launch the app?")
    sys.exit(0)

script = session.create_script("""

    var version = ObjC.classes.UIDevice.currentDevice().systemVersion().toString();
    ObjC.schedule(ObjC.mainQueue, function() {
        ObjC.classes.SBUIController.sharedInstance().handleHomeButtonSinglePressUp();
    });

""")

def on_message(message, data):
    if 'payload' in message:
            print(message['payload'])

script.on('message', on_message)
script.load()
