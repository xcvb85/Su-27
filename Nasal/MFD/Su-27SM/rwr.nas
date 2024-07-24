var canvas_rwr = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_rwr] };
		m.map = canvasGroup.createChild('group');

		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Su-27/Nasal/MFD/Su-27SM/rwr.svg", {'font-mapper': font_mapper});

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
