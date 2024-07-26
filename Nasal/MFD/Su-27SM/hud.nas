var canvas_hud = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_hud] };
        m.hud = hud.hud_radar.new(canvasGroup.createChild('group'));

		m.group = canvasGroup;
		return m;
	},
	update: func()
	{
		me.hud.update();
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
