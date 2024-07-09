var canvas_pfd = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_pfd, Device.new(1)] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "Helvetica.txf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-27/Nasal/MFD/Su-35S/pfd.svg", {'font-mapper': font_mapper});
		var svg_keys = ["horizon", "aircraft", "asiNeedle", "compass",
						"lb0", "lb3", "lb6", "lb9", "lb12", "lb15", "lb18",
						"lb21", "lb24", "lb27", "lb30", "lb33",
						"alt1Needle", "alt2Needle"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}
		m.h_trans = m.horizon.createTransform();
		m.horizon.set("clip", "rect(80, 419, 410, 121)");# top,right,bottom,left

		m.SkInstance = canvas_skPFD.new(canvasGroup.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));

		# create softkeys
		m.Menus[0].AddItem(SkItem.new(0, m, "А\nР\nК", "nav source", 1));
		m.Menus[0].AddItem(SkItem.new(1, m, "ПУСК", "start timer"));
		m.Menus[0].AddItem(SkItem.new(2, m, "Hоп", "set target altitude"));
		m.Menus[0].AddItem(SkItem.new(3, m, "Р760", "local barometer"));
		m.Menus[0].AddItem(SkItem.new(4, m, "Раэр", "standard pressure"));

		m.ias = props.globals.getNode("instrumentation/airspeed-indicator/indicated-speed-kt");
		m.alt = props.globals.getNode("instrumentation/altimeter/indicated-altitude-ft");
		m.pitch = props.globals.getNode("orientation/pitch-deg");
		m.roll = props.globals.getNode("orientation/roll-deg");
		m.hdg = props.globals.getNode("orientation/heading-deg");
		m.vSpd = props.globals.getNode("velocities/vertical-speed-fps");
		m.heading = 0;
		
		m.ActivateMenu(0);
		m.group = canvasGroup;
		return m;
	},
	update: func()
	{
		me.h_trans.setTranslation(0, me.pitch.getValue()*10.5);
		me.aircraft.setRotation(me.roll.getValue()*D2R);
		me.asiNeedle.setRotation((me.ias.getValue()*D2R*360)/540);
		me.alt1Needle.setRotation(me.alt.getValue()*0.1097*D2R);
		me.alt2Needle.setRotation(me.alt.getValue()*0.0035*D2R);

		me.heading = me.hdg.getValue()*D2R;
		me.compass.setRotation(-me.heading);
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
