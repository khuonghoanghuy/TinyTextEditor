package;

import openfl.Lib;
import openfl.events.IOErrorEvent;
import openfl.events.Event;
import openfl.net.FileReference;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.events.KeyboardEvent;

using StringTools;

class Main extends Sprite {
	private var textField:TextField;
	private var file:FileReference;

	public function new() {
		super();
		init();
	}

	private function init():Void {
		// Create a TextField
		textField = new TextField();
		textField.type = TextFieldType.INPUT;
		textField.border = true;
		textField.width = Lib.application.window.width;
		textField.height = Lib.application.window.height;
		textField.multiline = true;
		textField.wordWrap = true;

		// Set a default text format
		var format:TextFormat = new TextFormat();
		format.size = 20;
		format.font = "_sans";
		textField.defaultTextFormat = format;

		// Add the TextField to the stage
		addChild(textField);

		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.addEventListener(Event.ENTER_FRAME, onUpdate);
	}

	private function onUpdate(event:Event):Void {
		textField.width = Lib.application.window.width;
		textField.height = Lib.application.window.height;
	}

	private function onKeyDown(event:KeyboardEvent):Void {
		if (event.keyCode == 83 && event.ctrlKey) { // Ctrl + S
			saveText();
		}
	}

	private function saveText():Void {
		var data = textField.text;
		if ((data != null) && (data.length > 0)) {
			// trace("Saving text: " + data);
			file = new FileReference();
			file.addEventListener(Event.COMPLETE, onSaveComplete);
			file.addEventListener(Event.CANCEL, onSaveCancel);
			file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			file.save(data.trim(), "file");
		} else {
			trace("No text to save");
		}
	}

	function onSaveComplete(_):Void {
		file.removeEventListener(Event.COMPLETE, onSaveComplete);
		file.removeEventListener(Event.CANCEL, onSaveCancel);
		file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		file = null;
	}

	function onSaveCancel(_):Void {
		file.removeEventListener(Event.COMPLETE, onSaveComplete);
		file.removeEventListener(Event.CANCEL, onSaveCancel);
		file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		file = null;
	}

	function onSaveError(_):Void {
		file.removeEventListener(Event.COMPLETE, onSaveComplete);
		file.removeEventListener(Event.CANCEL, onSaveCancel);
		file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		file = null;
	}
}
