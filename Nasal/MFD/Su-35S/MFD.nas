var MfdInstances = [{}, {}];

var mfdListener = 0;
var variant = getprop("sim/variant-id") or 0;
var swap = 0;

# two screens
var t50BtClick = func(index = 0, location = 0, input = -1) {
	if(getprop("instrumentation/mfd/swap") or 0) {
		if(location == 0 and input == 11) {
			setprop("instrumentation/mfd/swap", 0);
		}
		
		if(index) {
			index = 0;
		}
		else {
			index = 1;
		}
	}
	else {
		if(location == 0 and input == 11) {
			setprop("instrumentation/mfd/swap", 1);
		}
	}

	MfdInstances[index].MfdBtClick(location, input);
}

# one screen
var su57BtClick = func(index = 0, location = 0, input = -1) {
	if(getprop("instrumentation/mfd/swap") or 0) {
		if(location == 0 and input == 11) {
			setprop("instrumentation/mfd/swap", 0);
		}
	}
	else {
		if(location == 0 and input == 11) {
			setprop("instrumentation/mfd/swap", 1);
		}
	}

	MfdInstances[index].MfdBtClick(location, input);
}

var mfdBtClick = func(index = 0, location = 0, input = -1) {
	if(variant > 0) {
		su57BtClick(index, location, input);
	}
	else {
		t50BtClick(index, location, input);
	}
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

	mfd1Canvas.addPlacement({"node": "mfd1_screen1"});
	mfd1Canvas.addPlacement({"node": "mfd2_screen2"});
	mfd2Canvas.addPlacement({"node": "mfd2_screen1"});
	mfd2Canvas.addPlacement({"node": "mfd1_screen2"});
	MfdInstances[0] = mfd1.new(mfd1Canvas.createGroup());
	MfdInstances[1] = mfd2.new(mfd2Canvas.createGroup());

	removelistener(mfdListener);
});
