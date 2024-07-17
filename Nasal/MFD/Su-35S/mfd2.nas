var MenuEnum = {
	TO:		0,
	KIS:	1,
};

var mfd2 = {
	new: func(group)
	{
		var m = { parents: [mfd2, Device.new()] };

		# create pages
		append(m.Pages, canvas_to.new(group.createChild('group')));
		append(m.Pages, canvas_kis.new(group.createChild('group')));
		m.PFD = canvas_pfd.new(group.createChild('group'));

		m.SkInstance = canvas_skMFD.new(group.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(MenuEnum.TO, m, ""));
		append(m.Menus, SkMenu.new(MenuEnum.KIS, m, ""));

		# create softkeys
		m.Menus[MenuEnum.TO].AddItem(SkItem.new(0, m, "ПИЛ", ""));
		m.Menus[MenuEnum.TO].AddItem(SkMenuPageActivateItem.new(1, m, "ТО", "tactical situation", MenuEnum.TO, MenuEnum.TO));
		m.Menus[MenuEnum.TO].AddItem(SkMenuPageActivateItem.new(2, m, "КИС", "controlling and informational system", MenuEnum.KIS, MenuEnum.KIS));
		m.Menus[MenuEnum.TO].AddItem(SkItem.new(3, m, "ОПС", ""));
		m.Menus[MenuEnum.TO].AddItem(SkItem.new(5, m, "<=>", "swap screens"));
		m.Menus[MenuEnum.TO].AddItem(SkItem.new(6, m, "", ""));

		m.Menus[MenuEnum.KIS].AddItem(SkItem.new(0, m, "ПИЛ", ""));
		m.Menus[MenuEnum.KIS].AddItem(SkMenuPageActivateItem.new(1, m, "ТО", "tactical situation", MenuEnum.TO, MenuEnum.TO));
		m.Menus[MenuEnum.KIS].AddItem(SkMenuPageActivateItem.new(2, m, "КИС", "controlling and informational system", MenuEnum.KIS, MenuEnum.KIS));
		m.Menus[MenuEnum.KIS].AddItem(SkItem.new(3, m, "ОПС", ""));
		m.Menus[MenuEnum.KIS].AddItem(SkItem.new(5, m, "<=>", "swap screens"));
		m.Menus[MenuEnum.KIS].AddItem(SkItem.new(6, m, "О\nЧ\nР", "next message"));

		m.ActivateMenu(MenuEnum.KIS);
		m.ActivatePage(MenuEnum.KIS, 2);
		m.Update();
		m.Timer = maketimer(0.1, m, m.Update);
		m.Timer.start();
		return m;
	},
	Update: func()
	{
		me.PFD.update();
		me.Pages[MenuEnum.KIS].update();
	},
	MfdBtClick: func(location = 0, input = -1)
	{
		if(location == 0) {
			if (input > 5) {
				me.BtClick(input-6);
			}
		}
		else if(location == 1) {
			if (input > 5) {
				me.SubBtClick(input-6);
			}
		}
		else if(location == 3) {
			if (input > 0) {
				me.SubBtClick(13-input);
			}
		}
	},
	SubBtClick: func(input)
	{
		if(input == 9) {
			me.Pages[MenuEnum.KIS].pmt();
		}
		else {
			me.Pages[MenuEnum.KIS].BtClick(input);
		}
	}
};
