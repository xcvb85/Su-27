if(getprop("/sim/variant-id")==1) {
    aircraft.livery.init("Aircraft/Su-27/Models/Su-27SK-Liveries/");
}
else if(getprop("/sim/variant-id")==2) {
    aircraft.livery.init("Aircraft/Su-27/Models/Su-33-Liveries/");
}
else if(getprop("/sim/variant-id")==3) {
    aircraft.livery.init("Aircraft/Su-27/Models/Su-27SM-Liveries/");
}
else {
    aircraft.livery.init("Aircraft/Su-27/Models/Su-35S-Liveries/");
}
