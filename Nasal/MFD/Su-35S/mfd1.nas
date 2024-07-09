var mfd1 = {
	new: func(group)
	{
		var m = { parents: [mfd1, Device.new(0)] };

		append(m.Pages, canvas_map.new(group.createChild('group')));

		m.SkInstance = canvas_skND.new(group.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));

		# create softkeys
		m.Menus[0].AddItem(SkItem.new(0, m, "ТО", "tactical situation"));

		m.ActivateMenu(0);
		m.ActivatePage(0, 0);

		m.Update();
		m.Timer = maketimer(0.1, m, m.Update);
		m.Timer.start();
		return m;
	},
	Update: func()
	{
		me.Pages[0].update();
	},
	MfdBtClick: func(location = 0, input = -1)
	{
	}
};
