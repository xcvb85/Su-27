var canvas_hydraulics = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_hydraulics] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-27/Nasal/MFD/hydraulics.svg", {'font-mapper': font_mapper});

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
