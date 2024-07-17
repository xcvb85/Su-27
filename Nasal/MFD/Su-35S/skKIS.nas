var canvas_skKIS = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_skKIS], softkeys: []};
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-27/Nasal/MFD/Su-35S/softkeys.svg", {'font-mapper': font_mapper});

		canvasGroup.getElementById("SKT").hide();
		canvasGroup.getElementById("SKL").hide();
		canvasGroup.getElementById("SKB0").hide();
		canvasGroup.getElementById("SKB1").hide();
		canvasGroup.getElementById("SKB2").hide();
		canvasGroup.getElementById("SKB3").hide();
		canvasGroup.getElementById("SKB4").hide();
		canvasGroup.getElementById("SKB5").hide();
		canvasGroup.getElementById("SKR0").hide();

		append(m.softkeys, canvasGroup.getElementById("SKB6"));
		append(m.softkeys, canvasGroup.getElementById("SKB7"));
		append(m.softkeys, canvasGroup.getElementById("SKB8"));
		append(m.softkeys, canvasGroup.getElementById("SKB9"));
		append(m.softkeys, canvasGroup.getElementById("SKB10"));
		append(m.softkeys, canvasGroup.getElementById("SKB11"));
		append(m.softkeys, canvasGroup.getElementById("SKR7"));
		append(m.softkeys, canvasGroup.getElementById("SKR6"));
		append(m.softkeys, canvasGroup.getElementById("SKR5"));
		append(m.softkeys, canvasGroup.getElementById("SKR4"));
		append(m.softkeys, canvasGroup.getElementById("SKR3"));
		append(m.softkeys, canvasGroup.getElementById("SKR2"));
		append(m.softkeys, canvasGroup.getElementById("SKR1"));

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
		for(me.i = 0; me.i < 13; me.i+=1) {
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
