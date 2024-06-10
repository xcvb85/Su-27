var canvas_refueling = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_refueling] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "Helvetica.txf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-27/Nasal/MFD/refueling.svg", {'font-mapper': font_mapper});

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
