var mfdInstances = [{}, {}];
var mfdListener = 0;

var mfd = {
	new: func(group)
	{
		var m = { parents: [mfd, Device.new()] };

		# create pages
		append(m.Pages, canvas_pfd.new(group.createChild('group')));
		append(m.Pages, canvas_to.new(group.createChild('group')));
		append(m.Pages, canvas_rwr.new(group.createChild('group')));
		append(m.Pages, canvas_wpn.new(group.createChild('group')));

		m.SkInstance = canvas_softkeys.new(group.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));

		# create softkeys
		m.Menus[0].AddItem(SkPageActivateItem.new(0, m, "ПИЛ", "pilot flying display", 0));
		m.Menus[0].AddItem(SkPageActivateItem.new(1, m, "ТО", "tactical situation", 1));
		m.Menus[0].AddItem(SkPageActivateItem.new(2, m, "РЗП", "radar warning receiver", 2));
		m.Menus[0].AddItem(SkPageActivateItem.new(3, m, "ОПС", "weapon system", 3));
		m.Menus[0].AddItem(SkPageActivateItem.new(4, m, "ИЛС", "HUD repeater", 4));

		m.ActivateMenu(0);
		m.ActivatePage(0, 0);
		m.Update();
		m.Timer = maketimer(0.1, m, m.Update);
		m.Timer.start();
		return m;
	},
	Update: func()
	{
		me.Pages[me.ActivePage].update();
	},
	MfdBtClick: func(input = -1)
	{
		me.ActivatePage(input, 0);
	}
};

var mfdBtClick = func(index = 0, input = -1) {
	mfdInstances[index].MfdBtClick(input);
}

mfdListener = setlistener("/sim/signals/fdm-initialized", func () {

	var mfd1Canvas = canvas.new({
		"name": "MFD1",
		"size": [1024, 1024],
		"view": [1024, 768],
		"mipmapping": 1
	});
	var mfd2Canvas = canvas.new({
		"name": "MFD2",
		"size": [1024, 1024],
		"view": [1024, 768],
		"mipmapping": 1
	});
	
	mfd1Canvas.addPlacement({"node": "mfd1_screen"});
	mfd2Canvas.addPlacement({"node": "mfd2_screen"});
	mfdInstances[0] = mfd.new(mfd1Canvas.createGroup());
	mfdInstances[1] = mfd.new(mfd2Canvas.createGroup());
	mfdInstances[1].MfdBtClick(3);
	removelistener(mfdListener);
});
