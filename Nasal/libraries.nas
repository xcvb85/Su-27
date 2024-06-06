if(getprop("/sim/variant-id")==1) {
    aircraft.livery.init("Aircraft/Su-27/Models/Su-27-Liveries/");
}
else if(getprop("/sim/variant-id")==2) {
    aircraft.livery.init("Aircraft/Su-27/Models/Su-33-Liveries/");
}
else {
    aircraft.livery.init("Aircraft/Su-27/Models/Su-35-Liveries/");
}
