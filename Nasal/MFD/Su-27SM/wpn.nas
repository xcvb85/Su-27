var canvas_wpn = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_wpn], Empties: [], Missiles: [], Bombs: [] };
		m.map = canvasGroup.createChild('map');

		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Su-27/Nasal/MFD/Su-27SM/wpn.svg", {'font-mapper': font_mapper});
		
		for(var i=0; i < 1; i+=1) {
			append(m.Empties, canvasGroup.getElementById("E7"));
			append(m.Missiles, canvasGroup.getElementById("M7"));
			append(m.Bombs, canvasGroup.getElementById("B7"));
		}

		m.Missiles[0].hide();
		m.Empties[0].hide();

		m.group = canvasGroup;
		return m;
	},
	update: func()
	{
	},
	show: func()
	{
		me.group.show();
	},
	hide: func()
	{
		me.group.hide();
	}
};
