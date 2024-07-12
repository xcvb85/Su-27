var Mfd3Instance = 0;
var mfd3Listener = 0;

var mfd3 = {
	new: func(group, instance)
	{
		var m = { parents: [mfd2, Device.new(instance)] };

		# create pages
		append(m.Pages, canvas_rwr.new(group.createChild('group')));
		append(m.Pages, canvas_pfd.new(group.createChild('group')));

		m.SkInstance = canvas_softkeys.new(group.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));

		# create softkeys
		m.Menus[0].AddItem(SkPageActivateItem.new(0, m, "РЗП", "radar warning receiver", 0));
		m.Menus[0].AddItem(SkPageActivateItem.new(1, m, "ПИЛ", "pilot flying display", 1));

		m.ActivateMenu(0);
		m.ActivatePage(0);
		m.Update();
		m.Timer = maketimer(0.1, m, m.Update);
		m.Timer.start();
		return m;
	},
	Update: func()
	{
		me.PFD.update();
	},
	MfdBtClick: func(location = 0, input = -1)
	{
		me.Pages[me.ActivePage].BtClick(input);
	}
};

var mfdBtClick = func(index = 0, location = 0, input = -1) {
	MfdInstances[index].MfdBtClick(location, input);
}

mfdListener = setlistener("/sim/signals/fdm-initialized", func () {

	var mfd3Canvas = canvas.new({
		"name": "MFD3",
		"size": [1024, 1024],
		"view": [512, 768],
		"mipmapping": 1
	});

	mfd3Canvas.addPlacement({"node": "mfd3_screen"});
	Mfd3Instance = mfd3.new(mfd3Canvas.createGroup(), 0);

	removelistener(mfdListener);
});
