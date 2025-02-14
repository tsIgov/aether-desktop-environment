{
	home = { pkgs, config, aether, ... }:
	let
		palette = aether.lib.appearance.getPalette { inherit config; };
	in
	{
		home.file.".config/walker/themes/aether.css".text = ''
#window,
#box,
#aiScroll,
#aiList,
#search,
#password,
#input,
#prompt,
#clear,
#typeahead,
#list,
child,
scrollbar,
slider,
#item,
#text,
#label,
#bar,
#sub,
#activationlabel {
  all: unset;
}

#cfgerr {
  background: #${palette.red};
  margin-top: 20px;
  padding: 8px;
  font-size: 1.2em;
}

#window {
  color: #${palette.text};
}

#box {
  border-radius: 2px;
  background: #${palette.mantle};
  padding: 24px;
  border: 1px solid #${palette.accent};
}

#search {
  background: #${palette.surface0};
  padding: 8px;
}

#prompt {
  margin-left: 4px;
  margin-right: 12px;
  color: #${palette.text};
}

#clear {
  color: #${palette.text};
}


#typeahead {
  color: #${palette.subtext0};
}

#input placeholder {
  color: #${palette.subtext0};
}

child {
  padding: 6px;
  border-radius: 2px;
}

child:selected,
child:hover {
  font-weight: 800;
  background: alpha(#${palette.overlay2}, 0.2);
}

#icon {
  margin-right: 8px;
}

#sub {
  color: #${palette.subtext0};
  font-size: 0.8em;
}
		'';
	};
}
