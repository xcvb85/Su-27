var ARM_SIM = -1;
var ARM_OFF = 0;# these 3 are needed by fire-control.
var ARM_ARM = 1;

print("** Pylon & fire control system started. **");

var variant = getprop("/sim/variant-id");
var pylon01 = nil; #left wingtip
var pylon02 = nil; #left wing outboard
var pylon03 = nil; #left wing inboard
var pylon04 = nil; #left intake
var pylon05 = nil; #center front
var pylon06 = nil; #center rear
var pylon07 = nil; #right intake
var pylon08 = nil; #right wing inboard
var pylon09 = nil; #right wing outboard
var pylon10 = nil; #right wingtip
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
    R27R:  {name: "R-27R1", content: ["R-27R1"], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    R27T:  {name: "R-27T1", content: ["R-27T1"], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    R77:   {name: "R-77", content: ["R-77"], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
};

var pylon01set = nil;
var pylon02set = nil;
var pylon03set = nil;
var pylon04set = nil;
var pylon05set = nil;
var pylon06set = nil;
var pylon07set = nil;
var pylon08set = nil;
var pylon09set = nil;
var pylon10set = nil;

pylon01set = [pylonSets.empty, pylonSets.R73];
pylon02set = [pylonSets.empty, pylonSets.R73];
pylon03set = [pylonSets.empty, pylonSets.R73, pylonSets.R27T, pylonSets.R27R];
pylon04set = [pylonSets.empty, pylonSets.R27R];
pylon05set = [pylonSets.empty, pylonSets.R27R];
pylon06set = [pylonSets.empty, pylonSets.R27R];
pylon07set = [pylonSets.empty, pylonSets.R27R];
pylon08set = [pylonSets.empty, pylonSets.R73, pylonSets.R27T, pylonSets.R27R];
pylon09set = [pylonSets.empty, pylonSets.R73];
pylon10set = [pylonSets.empty, pylonSets.R73];

setprop("payload/armament/fire-control/serviceable", 1);
pylon01 = stations.Pylon.new("Left wingtip",       0, [3.0,  0.0, 0.0], pylon01set,  0, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[0]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[0]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon02 = stations.Pylon.new("Left wing outboard", 1, [0.0, -2.7, 0.0], pylon02set,  1, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[1]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[1]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon03 = stations.Pylon.new("Left wing inboard",  2, [0.0,  2.7, 0.0], pylon03set,  2, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[2]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[2]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon04 = stations.Pylon.new("Left intake",        3, [0.0, -1.7,-1.0], pylon04set,  3, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[3]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[3]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon05 = stations.Pylon.new("Center front",       4, [0.0,  1.7,-1.0], pylon05set,  4, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[4]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[4]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon06 = stations.Pylon.new("Center rear",        5, [0.0,  1.7,-1.0], pylon06set,  5, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[5]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[5]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon07 = stations.Pylon.new("Left intake",        6, [0.0, -1.7,-1.0], pylon07set,  6, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[6]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[6]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon08 = stations.Pylon.new("Left wing inboard",  7, [0.0,  2.7, 0.0], pylon08set,  7, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[7]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[7]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon09 = stations.Pylon.new("Left wing outboard", 8, [0.0, -2.7, 0.0], pylon09set,  8, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[8]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[8]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon10 = stations.Pylon.new("Left wingtip",       9, [3.0,  0.0, 0.0], pylon10set,  9, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[9]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[9]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylonI = stations.InternalStation.new("Internal gun mount",  10, [pylonSets.mm30], props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[10]", 1));

pylons = [pylon01, pylon02, pylon03, pylon04, pylon05, pylon06, pylon07, pylon08, pylon09, pylon10, pylonI];
fcs = fc.FireControl.new(pylons, [10, 0, 9, 1, 8, 2, 7, 3, 6, 4, 5], ["30mm Cannon", "R-73", "R-27T1", "R-27R1"]);

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
