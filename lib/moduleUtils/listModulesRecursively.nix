lib: path: 
builtins.filter (n: lib.strings.hasSuffix ".nix" (toString n)) (lib.filesystem.listFilesRecursive path)