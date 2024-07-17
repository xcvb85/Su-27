var canvas_elec = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_elec] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "Helvetica.txf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-27/Nasal/MFD/Su-35S/elec.svg", {'font-mapper': font_mapper});

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
