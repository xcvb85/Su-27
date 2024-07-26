var ndlayers = [{name:'APT',style:{scale_factor:0.8,label_font_color:[0,1,0],color_default:[0,1,0],line_width:3}},
		{name:'RTE',style:{scale_factor:0.8,color:[0,1,0],line_width:2}},
		{name:'DME_su',style:{scale_factor:0.8,color:[0,0,1]}},
		{name:'NDB_su',style:{scale_factor:0.8,color:[1,0,0]}},
		{name:'WPT_su',style:{scale_factor:0.8,color:[0,1,0]}}];

var canvas_map = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_map] };
		m.map = canvasGroup.createChild('map');

		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Su-27/Nasal/MFD/Su-27SM/map.svg", {'font-mapper': font_mapper});

		var svg_keys = ["compass1", "compass2",
						"lb0", "lb3", "lb6", "lb9",
						"lb12", "lb15", "lb18",
						"lb21", "lb24", "lb27",
						"lb30", "lb33"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}

		var ctrl_ns = canvas.Map.Controller.get("Aircraft position");
		var source = ctrl_ns.SOURCES["to-map"];
		if (source == nil) {
			var source = ctrl_ns.SOURCES["to-map"] = {
			getPosition: func subvec(geo.aircraft_position().latlon(), 0, 2),
			getAltitude: func getprop('/position/altitude-ft'),
			getHeading:  func { 0 },
			aircraft_heading: 1,
			};
		}

		m.map.setRange(10);
		m.map.setTranslation(512, 393);
		m.map.setController("Aircraft position");

		foreach(var layer; ndlayers) {
			m.map.addLayer(
				factory: canvas.SymbolLayer,
				type_arg: layer.name,
				visible: 1,
				style: layer.style,
				priority: layer['z-index']
			);
		}
		
		m.hdg = props.globals.getNode("orientation/heading-deg");
		m.heading = 0;

		m.group = canvasGroup;
		return m;
	},
	update: func()
	{
		me.heading = me.hdg.getValue()*D2R;
		me.compass1.setRotation(-me.heading);
		me.compass2.setRotation(-me.heading);
		me.lb0.setRotation(me.heading);
		me.lb3.setRotation(me.heading);
		me.lb6.setRotation(me.heading);
		me.lb9.setRotation(me.heading);
		me.lb12.setRotation(me.heading);
		me.lb15.setRotation(me.heading);
		me.lb18.setRotation(me.heading);
		me.lb21.setRotation(me.heading);
		me.lb24.setRotation(me.heading);
		me.lb27.setRotation(me.heading);
		me.lb30.setRotation(me.heading);
		me.lb33.setRotation(me.heading);
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
