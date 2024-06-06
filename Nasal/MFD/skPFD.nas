var canvas_skPFD = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_skPFD], softkeys: []};
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-35/Nasal/MFD/softkeys.svg", {'font-mapper': font_mapper});

		canvasGroup.getElementById("SKT").hide();
		canvasGroup.getElementById("SKR").hide();
		canvasGroup.getElementById("SKL0").hide();
		canvasGroup.getElementById("SKL1").hide();
		canvasGroup.getElementById("SKL2").hide();
		canvasGroup.getElementById("SKL3").hide();
		canvasGroup.getElementById("SKL4").hide();
		canvasGroup.getElementById("SKL5").hide();
		canvasGroup.getElementById("SKL7").hide();
		canvasGroup.getElementById("SKB2").hide();
		canvasGroup.getElementById("SKB3").hide();
		canvasGroup.getElementById("SKB6").hide();
		canvasGroup.getElementById("SKB7").hide();
		canvasGroup.getElementById("SKB8").hide();
		canvasGroup.getElementById("SKB9").hide();
		canvasGroup.getElementById("SKB10").hide();
		canvasGroup.getElementById("SKB11").hide();

		append(m.softkeys, canvasGroup.getElementById("SKL6"));
		append(m.softkeys, canvasGroup.getElementById("SKB0"));
		append(m.softkeys, canvasGroup.getElementById("SKB1"));
		append(m.softkeys, canvasGroup.getElementById("SKB4"));
		append(m.softkeys, canvasGroup.getElementById("SKB5"));

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

		for(me.i = 0; me.i < 5; me.i+=1) {
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
