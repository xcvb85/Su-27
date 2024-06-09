var canvas_skMFD = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_skMFD], softkeys: []};
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-27/Nasal/MFD/softkeys.svg", {'font-mapper': font_mapper});

		canvasGroup.getElementById("SKL").hide();
		canvasGroup.getElementById("SKB").hide();
		canvasGroup.getElementById("SKT0").hide();
		canvasGroup.getElementById("SKT1").hide();
		canvasGroup.getElementById("SKT2").hide();
		canvasGroup.getElementById("SKT3").hide();
		canvasGroup.getElementById("SKT4").hide();
		canvasGroup.getElementById("SKT5").hide();
		canvasGroup.getElementById("SKR1").hide();
		canvasGroup.getElementById("SKR2").hide();
		canvasGroup.getElementById("SKR3").hide();
		canvasGroup.getElementById("SKR4").hide();
		canvasGroup.getElementById("SKR5").hide();
		canvasGroup.getElementById("SKR6").hide();
		canvasGroup.getElementById("SKR7").hide();

		append(m.softkeys, canvasGroup.getElementById("SKT6"));
		append(m.softkeys, canvasGroup.getElementById("SKT7"));
		append(m.softkeys, canvasGroup.getElementById("SKT8"));
		append(m.softkeys, canvasGroup.getElementById("SKT9"));
		append(m.softkeys, canvasGroup.getElementById("SKT10"));
		append(m.softkeys, canvasGroup.getElementById("SKT11"));
		append(m.softkeys, canvasGroup.getElementById("SKR0"));

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

		for(me.i = 0; me.i < 7; me.i+=1) {
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
