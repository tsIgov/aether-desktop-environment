aetherLib: path: attr:
builtins.map (set: set.${attr}) 
	(builtins.filter (set: builtins.hasAttr attr set) 
		(builtins.map (file: import file) 
			(aetherLib.moduleUtils.listModulesRecursively path)))