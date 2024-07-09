var canvas_fuel = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_fuel] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-27/Nasal/MFD/Su-35S/fuel.svg", {'font-mapper': font_mapper});

		m.group = canvasGroup;
		return m;
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
