var smfdInstance = 0;
var smfdListener = 0;

var smfd = {
	new: func(group)
	{
		var m = { parents: [smfd, Device.new()] };

		# create pages
		append(m.Pages, canvas_srwr.new(group.createChild('group')));
		append(m.Pages, canvas_spfd.new(group.createChild('group')));

		m.SkInstance = canvas_ssoftkeys.new(group.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));

		# create softkeys
		m.Menus[0].AddItem(SkPageActivateItem.new(0, m, "РЗП", "radar warning receiver", 0));
		m.Menus[0].AddItem(SkPageActivateItem.new(1, m, "ПИЛ", "pilot flying display", 1));

		m.ActivateMenu(0);
		m.ActivatePage(0,0);
		m.Update();
		m.Timer = maketimer(0.1, m, m.Update);
		m.Timer.start();
		return m;
	},
	Update: func()
	{
		me.Pages[me.ActivePage].update();
	},
	MfdBtClick: func(location = 0, input = -1)
	{
		me.Pages[me.ActivePage].BtClick(input);
	}
};

var smfdBtClick = func(index = 0, location = 0, input = -1) {
	smfdInstance.MfdBtClick(location, input);
}

smfdListener = setlistener("/sim/signals/fdm-initialized", func () {

	var smfdCanvas = canvas.new({
		"name": "SMFD",
		"size": [1024, 1024],
		"view": [512, 768],
		"mipmapping": 1
	});

	smfdCanvas.addPlacement({"node": "mfd3_screen"});
	smfdInstance = smfd.new(smfdCanvas.createGroup());

	removelistener(smfdListener);
});
