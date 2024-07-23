var ARM_SIM = -1;
var ARM_OFF = 0;# these 3 are needed by fire-control.
var ARM_ARM = 1;

print("** Pylon & fire control system started. **");

var variant = getprop("/sim/variant-id");
var pylon01 = nil; #center front
var pylon02 = nil; #center rear
var pylon03 = nil; #left wing center
var pylon04 = nil; #right wing center
var pylon05 = nil; #left wing outboard
var pylon06 = nil; #right wing outboard
var pylon07 = nil; #left wingtip
var pylon08 = nil; #right wingtip
var pylon09 = nil; #left intake
var pylon10 = nil; #right intake
var pylon11 = nil; #left wing inboard
var pylon12 = nil; #right wing inboard
var pylonI  = nil; #gun

var msgA = "Please return to base.";
var msgB = "Refill complete.";

var cannon = stations.SubModelWeapon.new("30mm Cannon", 0.254, 510, [5], [4], props.globals.getNode("fdm/jsbsim/fcs/guntrigger",1), 0, func{return 1;}, 0);
cannon.typeShort = "GUN";
cannon.brevity = "Guns guns";

var s5l = stations.SubModelWeapon.new("B-8M1", 8, 32, [14], [], props.globals.getNode("fdm/jsbsim/fcs/s5trigger",1), 1, func{return 1;}, 1);
s5l.typeShort = "S-5";
s5l.brevity = "Rockets away";
var s5r = stations.SubModelWeapon.new("B-8M1", 8, 32, [15], [], props.globals.getNode("fdm/jsbsim/fcs/s5trigger",1), 1, func{return 1;}, 1);
s5r.typeShort = "S-5";
s5r.brevity = "Rockets away";

var pylonSets = {
    empty: {name: "Empty", content: [], fireOrder: [], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    mm30:  {name: "30mm Cannon", content: [cannon], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 1, category: 1},

    # A/A weapons
    R73:   {name: "R-73", content: ["R-73"], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    R27R:  {name: "R-27R1", content: ["R-27R1"], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    R27T:  {name: "R-27T1", content: ["R-27T1"], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    R77:   {name: "R-77", content: ["R-77"], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    R77x2: {name: "2 x R-77", content: ["R-77", "R-77"], fireOrder: [0, 1], launcherDragArea: -0.05, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},

    # A/G weapons
    B8M1L: {name: "B-8M1",  content: [s5l], fireOrder: [0], launcherDragArea: 0.007, launcherMass: 230, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 3},
    B8M1R: {name: "B-8M1",  content: [s5r], fireOrder: [0], launcherDragArea: 0.007, launcherMass: 230, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 3},
    Kh29T: {name: "Kh-29T", content: ["Kh-29T"], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    Kh31P: {name: "Kh-31P", content: ["Kh-31P"], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
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
var pylon11set = nil;
var pylon12set = nil;

setprop("payload/armament/fire-control/serviceable", 1);
if(variant <= 3) {
    # Su-27SK, Su-33 and Su-27SM have 10 pylons
    if(variant <= 2) {
        # Su-27SK, Su-33
        pylon01set = [pylonSets.empty, pylonSets.R27R];
        pylon02set = [pylonSets.empty, pylonSets.R27R];
        pylon03set = [pylonSets.empty, pylonSets.R27R, pylonSets.R27T, pylonSets.R73, pylonSets.B8M1L];
        pylon04set = [pylonSets.empty, pylonSets.R27R, pylonSets.R27T, pylonSets.R73, pylonSets.B8M1R];
        pylon05set = [pylonSets.empty, pylonSets.R73];
        pylon06set = [pylonSets.empty, pylonSets.R73];
        pylon07set = [pylonSets.empty, pylonSets.R73];
        pylon08set = [pylonSets.empty, pylonSets.R73];
        pylon09set = [pylonSets.empty, pylonSets.R27R];
        pylon10set = [pylonSets.empty, pylonSets.R27R];
    }
    else {
        # Su-27SM
        pylon01set = [pylonSets.empty, pylonSets.R27R, pylonSets.R77x2];
        pylon02set = [pylonSets.empty, pylonSets.R27R, pylonSets.R77x2];
        pylon03set = [pylonSets.empty, pylonSets.R27R, pylonSets.R27T, pylonSets.R73, pylonSets.R77, pylonSets.Kh29T, pylonSets.Kh31P, pylonSets.B8M1L];
        pylon04set = [pylonSets.empty, pylonSets.R27R, pylonSets.R27T, pylonSets.R73, pylonSets.R77, pylonSets.Kh29T, pylonSets.Kh31P, pylonSets.B8M1R];
        pylon05set = [pylonSets.empty, pylonSets.R73, pylonSets.R77];
        pylon06set = [pylonSets.empty, pylonSets.R73, pylonSets.R77];
        pylon07set = [pylonSets.empty, pylonSets.R73];
        pylon08set = [pylonSets.empty, pylonSets.R73];
        pylon09set = [pylonSets.empty, pylonSets.R27R, pylonSets.R77, pylonSets.Kh29T, pylonSets.Kh31P];
        pylon10set = [pylonSets.empty, pylonSets.R27R, pylonSets.R77, pylonSets.Kh29T, pylonSets.Kh31P];
    }

    pylon01 = stations.Pylon.new("Center front  #1",        0, [0.0,  1.7,-1.0], pylon01set,  0, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[0]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[0]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon02 = stations.Pylon.new("Center rear  #2",         1, [0.0,  1.7,-1.0], pylon02set,  1, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[1]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[1]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon03 = stations.Pylon.new("Left wing inboard  #3",   2, [0.0,  2.7, 0.0], pylon03set,  2, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[2]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[2]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon04 = stations.Pylon.new("Right wing inboard  #4",  3, [0.0,  2.7, 0.0], pylon04set,  3, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[3]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[3]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon05 = stations.Pylon.new("Left wing outboard  #5",  4, [0.0, -2.7, 0.0], pylon05set,  4, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[4]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[4]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon06 = stations.Pylon.new("Right wing outboard  #6", 5, [0.0, -2.7, 0.0], pylon06set,  5, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[5]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[5]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon07 = stations.Pylon.new("Left wingtip  #7",        6, [3.0,  0.0, 0.0], pylon07set,  6, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[6]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[6]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon08 = stations.Pylon.new("Right wingtip  #8",       7, [3.0,  0.0, 0.0], pylon08set,  7, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[7]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[7]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon09 = stations.Pylon.new("Left intake  #9",         8, [0.0, -1.7,-1.0], pylon09set,  8, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[8]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[8]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon10 = stations.Pylon.new("Right intake #10",        9, [0.0, -1.7,-1.0], pylon10set,  9, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[9]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[9]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylonI = stations.InternalStation.new("Internal gun mount",  10, [pylonSets.mm30], props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[10]", 1));

    pylons = [pylon01, pylon02, pylon03, pylon04, pylon05, pylon06, pylon07, pylon08, pylon09, pylon10, pylonI];
    fcs = fc.FireControl.new(pylons, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], ["30mm Cannon", "R-73", "R-77", "R-27T1", "R-27R1", "Kh-29T", "Kh-31P", "B-8M1"]);
}
else {
    # Su-35S has 12 pylons
    pylon01set = [pylonSets.empty, pylonSets.R27R, pylonSets.R77x2];
    pylon02set = [pylonSets.empty, pylonSets.R27R, pylonSets.R77x2];
    pylon03set = [pylonSets.empty, pylonSets.R27R, pylonSets.R27T, pylonSets.R73, pylonSets.R77, pylonSets.Kh29T, pylonSets.Kh31P, pylonSets.B8M1L];
    pylon04set = [pylonSets.empty, pylonSets.R27R, pylonSets.R27T, pylonSets.R73, pylonSets.R77, pylonSets.Kh29T, pylonSets.Kh31P, pylonSets.B8M1R];
    pylon05set = [pylonSets.empty, pylonSets.R73, pylonSets.R77];
    pylon06set = [pylonSets.empty, pylonSets.R73, pylonSets.R77];
    pylon07set = [pylonSets.empty, pylonSets.R73];
    pylon08set = [pylonSets.empty, pylonSets.R73];
    pylon09set = [pylonSets.empty, pylonSets.R27R, pylonSets.R77, pylonSets.Kh29T, pylonSets.Kh31P];
    pylon10set = [pylonSets.empty, pylonSets.R27R, pylonSets.R77, pylonSets.Kh29T, pylonSets.Kh31P];
    pylon11set = [pylonSets.empty, pylonSets.R27R, pylonSets.R27T, pylonSets.R77, pylonSets.Kh29T, pylonSets.Kh31P];
    pylon12set = [pylonSets.empty, pylonSets.R27R, pylonSets.R27T, pylonSets.R77, pylonSets.Kh29T, pylonSets.Kh31P];

    pylon01 = stations.Pylon.new("Center front  #1",        0, [0.0,  1.7,-1.0], pylon01set,  0, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[0]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[0]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon02 = stations.Pylon.new("Center rear  #2",         1, [0.0,  1.7,-1.0], pylon02set,  1, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[1]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[1]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon03 = stations.Pylon.new("Left wing center  #3",    2, [0.0,  2.7, 0.0], pylon03set,  2, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[2]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[2]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon04 = stations.Pylon.new("Right wing center  #4",   3, [0.0,  2.7, 0.0], pylon04set,  3, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[3]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[3]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon05 = stations.Pylon.new("Left wing outboard  #5",  4, [0.0, -2.7, 0.0], pylon05set,  4, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[4]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[4]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon06 = stations.Pylon.new("Right wing outboard  #6", 5, [0.0, -2.7, 0.0], pylon06set,  5, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[5]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[5]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon07 = stations.Pylon.new("Left wingtip  #7",        6, [3.0,  0.0, 0.0], pylon07set,  6, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[6]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[6]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon08 = stations.Pylon.new("Right wingtip  #8",       7, [3.0,  0.0, 0.0], pylon08set,  7, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[7]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[7]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon09 = stations.Pylon.new("Left intake  #9",         8, [0.0, -1.7,-1.0], pylon09set,  8, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[8]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[8]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon10 = stations.Pylon.new("Right intake #10",        9, [0.0, -1.7,-1.0], pylon10set,  9, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[9]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[9]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon11 = stations.Pylon.new("Left wing inboard #11",  10, [0.0,  2.7, 0.0], pylon11set, 10, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[10]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[10]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylon12 = stations.Pylon.new("Right wing inboard #12", 11, [0.0,  2.7, 0.0], pylon12set, 11, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[11]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[11]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
    pylonI = stations.InternalStation.new("Internal gun mount",  12, [pylonSets.mm30], props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[12]", 1));

    pylons = [pylon01, pylon02, pylon03, pylon04, pylon05, pylon06, pylon07, pylon08, pylon09, pylon10, pylon11, pylon12, pylonI];
    fcs = fc.FireControl.new(pylons, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], ["30mm Cannon", "R-73", "R-77", "R-27T1", "R-27R1", "Kh-29T", "Kh-31P", "B-8M1"]);
}

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
