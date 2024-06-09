var canvas_skND = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_skND], softkeys: []};
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-27/Nasal/MFD/softkeys.svg", {'font-mapper': font_mapper});

		canvasGroup.getElementById("SKL").hide();
		canvasGroup.getElementById("SKR").hide();
		canvasGroup.getElementById("SKB").hide();
		
		for(m.i=0; m.i<12; m.i+=1) {
			append(m.softkeys, canvasGroup.getElementById("SKT"~m.i));
		}

		m.path = canvasGroup.createChild("path").setStrokeLineWidth(3).set("stroke", "rgba(0,255,0,1)");
		return m;
	},
	resetFrames: func()
	{
		me.path.reset();
	},
	drawRect: func(coordinates, padding=0)
	{
		me.path.moveTo(coordinates[0]-padding,coordinates[1])
			.lineTo(coordinates[2]+padding,coordinates[1])
			.lineTo(coordinates[2]+padding,coordinates[3]+padding+10)
			.lineTo(coordinates[0]-padding,coordinates[3]+padding+10)
			.lineTo(coordinates[0]-padding,coordinates[1]);
	},
	setSoftkeys: func(softkeys, translations, selectedSoftkeys)
	{
		#setprop("instrumentation/mfd/sk"~me.InstanceId~"_"~me.i, me.Tmp.GetTranslation() or "");

		for(me.i = 0; me.i < 12; me.i+=1) {
			me.softkeys[me.i].setText(softkeys[me.i]);
			
			if(selectedSoftkeys[me.i] == 1) {
				me.center = me.softkeys[me.i].getCenter();
				me.bbox = me.softkeys[me.i].getBoundingBox();

				me.drawRect([me.center[0]+me.bbox[0], me.center[1]+me.bbox[1],
							 me.center[0]+me.bbox[2], me.center[1]+me.bbox[3]], 5);
			}
		}
	}
};
