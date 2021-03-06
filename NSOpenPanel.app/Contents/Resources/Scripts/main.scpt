JsOsaDAS1.001.00bplist00�Vscript_�// NSOpenPanel can be used used to select files/directories
// 
// NSOpenPanel: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSOpenPanel_Class/Reference/Reference.html

ObjC.import("Cocoa");

// If no superclass is provided, NSObject is subclassed.
ObjC.registerSubclass({
	name: "AppDelegate",
	methods: {
		"singleBtnClickHandler:": {
			types: ["void", ["id"]],
			implementation: function (sender) {
				var panel = $.NSOpenPanel.openPanel;
				panel.title = "Choose an Image";
				
				// NOTE: We need to bridge the JS array to an NSArray here.
				var allowedTypes = ["jpg", "png", "gif"];
				panel.allowedFileTypes = $(allowedTypes);
				
				if (panel.runModal == $.NSOKButton) {
					// NOTE: panel.URLs is an ObjectiveC Array not a JS array
					var imagePath = panel.URLs.objectAtIndex(0).path;
					textField.stringValue = imagePath;
				}
			}
		}
	}
});

var appDelegate = $.AppDelegate.alloc.init;

var styleMask = $.NSTitledWindowMask | $.NSClosableWindowMask | $.NSMiniaturizableWindowMask;
var height = 85;
var width = 600;
var window = $.NSWindow.alloc.initWithContentRectStyleMaskBackingDefer(
	$.NSMakeRect(0, 0, width, height),
	styleMask,
	$.NSBackingStoreBuffered,
	false
);

var textFieldLabel = $.NSTextField.alloc.initWithFrame($.NSMakeRect(25, (height - 40), 400, 24));
textFieldLabel.stringValue = "This is restricted to images: (jpg, png, gif)";
textFieldLabel.drawsBackground = false;
textFieldLabel.editable = false;
textFieldLabel.bezeled = false;
textFieldLabel.selectable = true;

var textField = $.NSTextField.alloc.initWithFrame($.NSMakeRect(25, (height - 60), 405, 24));
textField.editable = false;

var singleBtn = $.NSButton.alloc.initWithFrame($.NSMakeRect(430, (height - 62), 150, 25));
singleBtn.title = "Choose an Image...";
singleBtn.bezelStyle = $.NSRoundedBezelStyle;
singleBtn.buttonType = $.NSMomentaryLightButton;
singleBtn.target = appDelegate;
singleBtn.action = "singleBtnClickHandler:";

window.contentView.addSubview(textFieldLabel);
window.contentView.addSubview(textField);
window.contentView.addSubview(singleBtn);

window.center;
window.title = "NSOpenPanel Example";
window.makeKeyAndOrderFront(window);                              � jscr  ��ޭ