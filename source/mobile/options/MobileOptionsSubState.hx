package mobile.options;

import flixel.input.keyboard.FlxKey;
import options.BaseOptionsMenu;
import options.Option;

class MobileOptionsSubState extends BaseOptionsMenu {
	#if android
	var storageTypes:Array<String> = ["EXTERNAL_DATA", "EXTERNAL_MEDIA", "EXTERNAL"];
	var customPaths:Array<String> = MobileUtil.getCustomStorageDirectories(false);
	final lastStorageType:String = ClientPrefs.data.storageType;
	#end

	var option:Option;
	var HitboxTypes:Array<String>;
	public function new() {
		title = 'Mobile Options';
		rpcTitle = 'Mobile Options Menu'; // for Discord Rich Presence, fuck it
		#if android
		storageTypes = storageTypes.concat(customPaths); //Get Custom Paths From File
		#end

		#if android
		option = new Option('Storage Type',
			'Which folder Psych Engine should use?',
			'storageType',
			STRING,
			storageTypes
		);
		addOption(option);
		#end

		super();
	}

	override public function destroy() {
		super.destroy();

		#if android
		if (ClientPrefs.data.storageType != lastStorageType) {
			File.saveContent(lime.system.System.applicationStorageDirectory + 'storagetype.txt', ClientPrefs.data.storageType);
			lime.app.Application.current.window.alert("For changes to be used, u should restart the game.\n Press OK to close the game.", "Notice!");
			lime.system.System.exit(0);
			ClientPrefs.saveSettings();
			MobileUtil.initDirectory();
		}
		#end
	}
}
