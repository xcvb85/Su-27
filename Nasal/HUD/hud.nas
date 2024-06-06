var HUDInstance = {};

var HUD = {
    new: func(group, instance) {
        var m = {parents:[HUD], Pages:{}};
        m.Instance = instance;

        m.Pages[0] = hud_radar.new(group.createChild('group'), instance);
        m.Index = 0;

        m.ActivatePage(0);
        m.Timer = maketimer(0.05, m, m.Update);
        m.Timer.start();
        m.group = group;
        
        return m;
    },
    ActivatePage: func(input = -1)
    {
        me.ActivePage = 0;
        for(var i=0; i < size(me.Pages); i=i+1) {
            if(i == input) {
                me.Pages[i].update();
                me.Pages[i].show();
                me.ActivePage = i;
            }
            else {
                me.Pages[i].hide();
            }
        }
    },
    Update: func()
    {
        if(me.ActivePage >= 0 and me.ActivePage <= 1) {
            if(me.ActivePage != me.Index) {
                me.ActivatePage(me.Index);
            }
            else {
                me.Pages[me.ActivePage].update();
            }
        }
    }
};

var hudListener = setlistener("sim/signals/fdm-initialized", func () {

    var hudCanvas = canvas.new({
        "name": "HUD_Screen",
        "size": [1024, 1024],
        "view": [256, 256],
        "mipmapping": 1
    });
    hudCanvas.addPlacement({"node": "HUD_Screen"});
    hudCanvas.set("additive-blend", 1);
    hudCanvas.setColorBackground(0, 0, 0, 0);
    HUDInstance = HUD.new(hudCanvas.createGroup(), 0);
    removelistener(hudListener);
});
