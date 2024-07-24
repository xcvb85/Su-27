##########################################################################################################
# EFIS Framework
# Daniel Overbeck - 2018
##########################################################################################################

var NUM_SOFTKEYS = 14;

# base class
var SkItem = {
	new: func(id, device, title, translation, decoration=0) {
		var m = {parents: [SkItem]};
		m.Id = id;
		m.Device = device;
		m.Title = title;
		m.Translation = translation;
		m.Decoration = decoration;
		return m;
	},
	Activate: func {
	},
	GetId: func {
		return me.Id;
	},
	GetDecoration: func {
		return me.Decoration;
	},
	GetTitle: func {
		return me.Title;
	},
	GetTranslation: func {
		return me.Translation;
	},
	SetDecoration: func(decoration) {
		me.Decoration = decoration;
	}
};

# item which changes menu
var SkMenuActivateItem = {
	new: func(id, device, title, translation, menu) {
		var m = {parents: [SkMenuActivateItem, SkItem.new(id, device, title, translation)]};
		m.Menu = menu;
		return m;
	},
	Activate: func {
		me.Device.ActivateMenu(me.Menu);
	}
};

# item which changes menu and page
var SkMenuPageActivateItem = {
	new: func(id, device, title, translation, menu, page) {
		var m = {parents: [SkMenuPageActivateItem, SkItem.new(id, device, title, translation)]};
		m.Menu = menu;
		m.Page = page;
		return m;
	},
	Activate: func {
		me.Device.ActivateMenu(me.Menu); # run first to reset active menu
		me.Device.ActivatePage(me.Page, me.Id);
	}
};

# item which changes page
var SkPageActivateItem = {
	new: func(id, device, title, translation, page) {
		var m = {parents: [SkPageActivateItem, SkItem.new(id, device, title, translation)]};
		m.Page = page;
		return m;
	},
	GetDecoration: func(activePage) {
		return me.Page == activePage;
	},
	Activate: func {
		me.Device.ActivatePage(me.Page, me.Id);
	}
};

# item which acts like a switch
var SkSwitchItem = {
	new: func(id, device, title, translation, path) {
		var m = {parents: [SkSwitchItem, SkItem.new(id, device, title, translation)]};
		m.Node = props.globals.initNode(path, 0, "BOOL");
		m.Active = 0;
		return m;
	},
	Activate: func {
		if(me.Active) {
			me.Active = 0;
		}
		else {
			me.Active = 1;
		}
		me.Node.setValue(me.Active);
		me.Device.UpdateMenu();
	},
	GetDecoration: func {
		return me.Node.getValue();
	}
};

var SkMenu = {
	new: func(id, device) {
		var m = { parents: [SkMenu],
			Items: []};
		setsize(m.Items, NUM_SOFTKEYS);
		m.Id = id;
		m.Device = device;
		m.Tmp = 0;
		return m;
	},
	ActivateItem: func(index) {
		if(me.Items[index] != nil) {
			me.Items[index].Activate();
		}
	},
	GetItem: func(index) {
		return me.Items[index];
	},
	ResetDecoration: func {
		for(me.Tmp = 0; me.Tmp < NUM_SOFTKEYS; me.Tmp+=1) {
			if(me.Items[me.Tmp] != nil) {
				me.Items[me.Tmp].SetDecoration(0);
			}
		}
	},
	SetDecoration: func(index) {
		for(me.Tmp = 0; me.Tmp < NUM_SOFTKEYS; me.Tmp+=1) {
			if(me.Items[me.Tmp] != nil) {
				if(me.Tmp == index) {
					me.Items[me.Tmp].SetDecoration(1);
				}
				else {
					me.Items[me.Tmp].SetDecoration(0);
				}
			}
		}
	},
	AddItem: func(item) {
		var index = item.GetId();
		if(index >= 0 and index < NUM_SOFTKEYS) {
			me.Items[index] = item;
		}
	}
};

var Device = {
	new: func {
		var m = {
			parents: [Device],
			SkInstance: {},
			Pages: [],
			Menus: [],
			Softkeys: [],
			Translations: [],
			SoftkeyFrames: [],
			ActiveMenu: 0, # to know where button clicks must go
			ActivePage: 0, # used for softkey decoration
			SkFrameMenu: 0,
			KnobMode: 1, # knob can have different functionalities
			Tmp: 0,
		};

		for(m.i=0; m.i < NUM_SOFTKEYS; m.i+=1) {
			append(m.Softkeys, "");
			append(m.Translations, "");
			append(m.SoftkeyFrames, 0);
		}

		return m;
	},
	ActivateMenu: func(id) {
		me.ActiveMenu = id;
		me.UpdateMenu();
	},
	ActivatePage: func(page, softkey) {
		if(page < size(me.Pages)) {
			me.Menus[me.SkFrameMenu].ResetDecoration();
			me.SkFrameMenu = me.ActiveMenu;
			me.Menus[me.SkFrameMenu].SetDecoration(softkey);
			me.ActivePage = page;

			me.UpdateMenu();

			for(me.i=0; me.i < size(me.Pages); me.i+=1) {
				if(me.i == page) {
					me.Pages[me.i].show();
				}
				else {
					me.Pages[me.i].hide();
				}
			}
		}
	},
	# input: 0=back, 1=sk1...5=sk5
	BtClick: func(input = -1) {
		me.Menus[me.ActiveMenu].ActivateItem(input);
	},
	GetKnobMode: func()
	{
		return me.KnobMode;
	},
	UpdateMenu: func() {
		me.SkInstance.resetFrames();

		# copy sk names to array
		for(me.i = 0; me.i < NUM_SOFTKEYS; me.i+=1) {
			me.Tmp = me.Menus[me.ActiveMenu].GetItem(me.i);
			if(me.Tmp != nil) {
				me.Softkeys[me.i] = me.Tmp.GetTitle();
				me.Translations[me.i] = me.Tmp.GetTranslation();
				me.SoftkeyFrames[me.i] = me.Tmp.GetDecoration(me.ActivePage);
			}
		}
		me.SkInstance.setSoftkeys(me.Softkeys, me.Translations, me.SoftkeyFrames);
	}
};
