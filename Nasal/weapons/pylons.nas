var ARM_SIM = -1;
var ARM_OFF = 0;# these 3 are needed by fire-control.
var ARM_ARM = 1;

print("** Pylon & fire control system started. **");

var variant = getprop("/sim/variant-id");
var pylon1 = nil; #fuselage
var pylon2 = nil; #left wing
var pylon3 = nil; #right wing
var pylon4 = nil; #left inboard
var pylon5 = nil; #right inboard
var pylonI = nil; #gun

var msgA = "Please return to base.";
var msgB = "Refill complete.";

var cannon = stations.SubModelWeapon.new("30mm Cannon", 0.254, 510, [5], [4], props.globals.getNode("fdm/jsbsim/fcs/guntrigger",1), 0, func{return 1;}, 0);
cannon.typeShort = "GUN";
cannon.brevity = "Guns guns";

var pylonSets = {
    empty: {name: "Empty", content: [], fireOrder: [], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    mm30:  {name: "30mm Cannon", content: [cannon], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 1, category: 1},
    R73:   {name: "R-73", content: ["R-73"], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    R77:   {name: "R-77", content: ["R-77"], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
};

var pylon1set = nil;
var pylon2set = nil;
var pylon3set = nil;
var pylon4set = nil;
var pylon5set = nil;

pylon1set = [pylonSets.empty];
pylon2set = [pylonSets.empty, pylonSets.R73];
pylon3set = [pylonSets.empty, pylonSets.R73];
pylon4set = [pylonSets.empty, pylonSets.R77];
pylon5set = [pylonSets.empty, pylonSets.R77];

setprop("payload/armament/fire-control/serviceable", 1);
pylon1 = stations.Pylon.new("Center Station (1-4)", 0, [3.0,  0.0, 0.0], pylon1set,  0, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[0]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[0]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon2 = stations.Pylon.new("Left wing (5)",        1, [0.0, -2.7, 0.0], pylon2set,  1, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[1]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[1]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon3 = stations.Pylon.new("Right wing (6)",       2, [0.0,  2.7, 0.0], pylon3set,  2, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[2]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[2]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon4 = stations.Pylon.new("Left Fuselage (7)",    3, [0.0, -1.7,-1.0], pylon4set,  3, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[3]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[3]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon5 = stations.Pylon.new("Right Fuselage (8)",   4, [0.0,  1.7,-1.0], pylon5set,  4, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[4]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[4]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylonI = stations.InternalStation.new("Internal gun mount",   3, [pylonSets.mm30], props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[3]", 1));

pylons = [pylon1, pylon2, pylon3, pylon4, pylon5, pylonI];
fcs = fc.FireControl.new(pylons, [4, 5, 1, 2, 3], ["30mm Cannon", "R-77", "R-73"]);

var selectedWeapon = {};
var bore_loop = func {
    #enables firing of aim9 without radar. The aim-9 seeker will be fixed 3.5 degs below bore and any aircraft the gets near that will result in lock.
    if (fcs != nil) {
        selectedWeapon = fcs.getSelectedWeapon();
        if (selectedWeapon != nil and (selectedWeapon.type == "R-73")) {
            selectedWeapon.setContacts(radar_system.getCompleteList());
            selectedWeapon.commandDir(0,-3.5);# the real is bored to -6 deg below real bore
        }
    }
    settimer(bore_loop, 0.5);
};
if (fcs!=nil) {
    bore_loop();
}
