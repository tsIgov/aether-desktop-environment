aetherLib: flavorName: 
let
	flavor = aetherLib.appearance.flavors.${flavorName};
in with flavor;
''{
	"type": "palette",
	"name": "Aether ${flavorName}",
	"desc": "Aether ${flavorName} theme",
	"smooth": false,
	"colors": [
        "#${rosewater}",
        "#${flamingo}",
        "#${pink}",
        "#${mauve}",
        "#${red}",
        "#${maroon}",
        "#${peach}",
        "#${yellow}",
        "#${green}",
        "#${teal}",
        "#${sky}",
        "#${sapphire}",
        "#${blue}",
        "#${lavender}",
        "#${text}",
        "#${subtext1}",
        "#${subtext0}",
        "#${overlay2}",
        "#${overlay1}",
        "#${overlay0}",
        "#${surface2}",
        "#${surface1}",
        "#${surface0}",
        "#${base}",
        "#${mantle}",
        "#${crust}"
    ]
}''