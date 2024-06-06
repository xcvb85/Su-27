var PageEnum = {
	FUEL:	    0,
	GEAR:	    1,
	HYDRAULICS:	2,
	OXY:		3,
	REFUELING:	4,
	ELECTRICAL:	5,
	EMPTY:	    6,
};

var canvas_kis = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_kis, Device.new(1)], SubPages: [] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Su-35/Nasal/MFD/kis.svg", {'font-mapper': font_mapper});
		var svg_keys = ["arrowL", "arrowR", "n2L", "n2R",
						"tempL", "tempR"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}

		m.tempLn = props.globals.getNode("engines/engine[0]/egt-degf");
		m.tempRn = props.globals.getNode("engines/engine[1]/egt-degf");
		m.n2Ln = props.globals.getNode("engines/engine[0]/n2");
		m.n2Rn = props.globals.getNode("engines/engine[0]/n2");

		append(m.SubPages, canvasGroup.createChild('group'));
		append(m.SubPages, canvasGroup.createChild('group'));
		canvas.parsesvg(m.SubPages[0], "Aircraft/Su-35/Nasal/MFD/panel.svg", {'font-mapper': font_mapper});
		canvas.parsesvg(m.SubPages[1], "Aircraft/Su-35/Nasal/MFD/nozzle.svg", {'font-mapper': font_mapper});
		m.ActiveSubPage = 0;

		append(m.Pages, canvas_fuel.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_gear.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_hydraulics.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_oxy.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_refueling.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_elec.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_empty.new(canvasGroup.createChild('group')));

		m.SkInstance = canvas_skKIS.new(canvasGroup.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));
		append(m.Menus, SkMenu.new(1, m, ""));
		append(m.Menus, SkMenu.new(2, m, ""));

		# create softkeys
		m.Menus[0].AddItem(SkSwitchItem.new(0, m, "ДВИГ", "engines", "instrumentation/mfd/engine"));
		m.Menus[0].AddItem(SkPageActivateItem.new(1, m, "ТОПЛ", "fuel", PageEnum.FUEL));
		m.Menus[0].AddItem(SkPageActivateItem.new(2, m, "ППС", "gear and flap indicator", PageEnum.GEAR));
		m.Menus[0].AddItem(SkPageActivateItem.new(3, m, "ГПС", "hydraulic and pneumatic systems", PageEnum.HYDRAULICS));
		m.Menus[0].AddItem(SkPageActivateItem.new(4, m, "СЖО", "life supporting system", PageEnum.OXY));
		m.Menus[0].AddItem(SkPageActivateItem.new(5, m, "ДЗП", "aerial refueling", PageEnum.REFUELING));
		m.Menus[0].AddItem(SkPageActivateItem.new(6, m, "С\nЭ\nС", "electrical supply system", PageEnum.ELECTRICAL));
		m.Menus[0].AddItem(SkItem.new(9, m, "П\nМ\nТ", "Parameters of Maneuver Technique"));
		m.Menus[0].AddItem(SkMenuActivateItem.new(10, m, "", "move down", 1));
		m.Menus[0].AddItem(SkItem.new(11, m, "М\nН\nВ\nР", "maneuver"));
		m.Menus[0].AddItem(SkPageActivateItem.new(12, m, "С\nИ\nС", "system notifications", PageEnum.EMPTY));

		m.Menus[1].AddItem(SkSwitchItem.new(0, m, "ДВИГ", "engines", "instrumentation/mfd/engine"));
		m.Menus[1].AddItem(SkPageActivateItem.new(1, m, "ТОПЛ", "fuel", PageEnum.FUEL));
		m.Menus[1].AddItem(SkPageActivateItem.new(2, m, "ППС", "gear and flap indicator", PageEnum.GEAR));
		m.Menus[1].AddItem(SkPageActivateItem.new(3, m, "ГПС", "hydraulic and pneumatic systems", PageEnum.HYDRAULICS));
		m.Menus[1].AddItem(SkPageActivateItem.new(4, m, "СЖО", "life supporting system", PageEnum.OXY));
		m.Menus[1].AddItem(SkPageActivateItem.new(5, m, "ДЗП", "aerial refueling", PageEnum.REFUELING));
		m.Menus[1].AddItem(SkPageActivateItem.new(6, m, "С\nЭ\nС", "electrical supply system", PageEnum.ELECTRICAL));
		m.Menus[1].AddItem(SkItem.new(9, m, "П\nМ\nТ", "Parameters of Maneuver Technique"));
		m.Menus[1].AddItem(SkMenuActivateItem.new(10, m, "", "move down", 2));
		m.Menus[1].AddItem(SkPageActivateItem.new(11, m, "С\nИ\nС", "system notifications", PageEnum.EMPTY));
		m.Menus[1].AddItem(SkItem.new(12, m, "С\nТ\nР", "page"));

		m.Menus[2].AddItem(SkSwitchItem.new(0, m, "ДВИГ", "engines", "instrumentation/mfd/engine"));
		m.Menus[2].AddItem(SkPageActivateItem.new(1, m, "ТОПЛ", "fuel", PageEnum.FUEL));
		m.Menus[2].AddItem(SkPageActivateItem.new(2, m, "ППС", "gear and flap indicator", PageEnum.GEAR));
		m.Menus[2].AddItem(SkPageActivateItem.new(3, m, "ГПС", "hydraulic and pneumatic systems", PageEnum.HYDRAULICS));
		m.Menus[2].AddItem(SkPageActivateItem.new(4, m, "СЖО", "life supporting system", PageEnum.OXY));
		m.Menus[2].AddItem(SkPageActivateItem.new(5, m, "ДЗП", "aerial refueling", PageEnum.REFUELING));
		m.Menus[2].AddItem(SkPageActivateItem.new(6, m, "С\nЭ\nС", "electrical supply system", PageEnum.ELECTRICAL));
		m.Menus[2].AddItem(SkItem.new(9, m, "П\nМ\nТ", "Parameters of Maneuver Technique"));
		m.Menus[2].AddItem(SkMenuActivateItem.new(10, m, "", "move down", 0));
		m.Menus[2].AddItem(SkItem.new(11, m, "С\nТ\nР", "page"));
		m.Menus[2].AddItem(SkItem.new(12, m, "М\nН\nВ\nР", "maneuver"));

		m.ActivateMenu(0);
		m.ActivatePage(0, 2);
		m.pmt();

		m.group = canvasGroup;
		return m;
	},
	pmt: func()
	{
		me.ActiveSubPage += 1;
		
		if(me.ActiveSubPage > 2) {
			me.ActiveSubPage = 0;
		}
		
		me.SubPages[0].hide();
		me.SubPages[1].hide();
		
		if(me.ActiveSubPage == 1) {
			me.SubPages[0].show();
		}
		if(me.ActiveSubPage == 2) {
			me.SubPages[1].show();
		}
	},
	calcRotation: func(value)
	{
		if(value > 60) {
			if(value > 105) {
				return 0;
			}
			else {
				# 60-105
				return 19-((value-60)*19)/45;
			}
		}
		else {
			# 0-60
			return 32-(value*13)/60;
		}
		return 0;
	},
	update: func()
	{
		me.arrowL.setRotation(me.calcRotation(me.n2Ln.getValue())*D2R);
		me.arrowR.setRotation(-me.calcRotation(me.n2Rn.getValue())*D2R);
		me.n2L.setText(sprintf("%.1f", me.n2Ln.getValue()));
		me.n2R.setText(sprintf("%.1f", me.n2Rn.getValue()));
		me.tempL.setText(sprintf("%.0f", (me.tempLn.getValue()-32)/1.8));
		me.tempR.setText(sprintf("%.0f", (me.tempRn.getValue()-32)/1.8));
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
