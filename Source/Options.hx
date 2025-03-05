package;

import sys.io.File;

using StringTools;

class Options {
	public static var opt:Array<String> = ["_sans", "20"];

	public static function initOpt():Void {
		if (opt == null)
			opt = ["_sans", "20"];

		if (opt != null) {
			opt = opt.filter(function(line) {
				return line.trim() != "" && !line.trim().startsWith("#"); // skip
			});
			opt = File.getContent("assets/options.txt").split("\n");
		}
	}
}
