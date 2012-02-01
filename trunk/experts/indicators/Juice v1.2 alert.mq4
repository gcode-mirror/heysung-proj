//+------------------------------------------------------------------+
//|                                               Juice_mod_v1.2.mq4 |
//|                                  Copyright © 2006, Forex-TSD.com |
//|                                                 Written by IgorAD|   
//|            http://finance.groups.yahoo.com/group/TrendLaboratory |                                      
//|        Thanks Perky for Idea: http://fxovereasy.atspace.com/index|
//+------------------------------------------------------------------+
#property copyright "Copyright © 2006, Forex-TSD.com "
#property link      "http://www.forex-tsd.com/"

//---- indicator settings
#property  indicator_separate_window
#property  indicator_buffers 2
#property  indicator_color1  LimeGreen
#property  indicator_color2  Orange


//---- indicator parameters
extern bool AlertsEnabled = false;
extern double AlertsProximity = 0.95;
extern string AlertsSound = "alert.wav";

extern int    Length = 7;
extern double Ks = 1.0;
extern int    CalcBars = 144;
extern int    Advance = 70; 

//---- indicator buffers
double UpBuffer[];
double DnBuffer[];


void init()
{
	//---- drawing settings
	SetIndexStyle(0, DRAW_HISTOGRAM, STYLE_SOLID);
	SetIndexStyle(1, DRAW_LINE, STYLE_DOT);
	
	//---- indicator buffers mapping
	SetIndexBuffer(0, UpBuffer);
	SetIndexBuffer(1, DnBuffer);
	
	//---- name for DataWindow and indicator subwindow label
	IndicatorShortName("Juice v1.2 alert (" + Length + "," + Ks + ")");
	SetIndexShift(1, Advance);
	
	//---- initialization done
	SetIndexEmptyValue(0, 0);
	SetIndexEmptyValue(1, 0);
}

//+------------------------------------------------------------------+
//| Juice_mod_v1.2                                                   |
//+------------------------------------------------------------------+
void start()
{
	static datetime AlertTime = 0;
	
	if (CalcBars == 0)
		int NBars = Bars - Length;
	else
		NBars = CalcBars;
	
	double sum = 0;
	for (int i = 1; i <= NBars; i++)
		sum += iStdDev(NULL, 0, Length, MODE_EMA, 0, PRICE_CLOSE, i);
	double avg = sum/NBars;
	
	for (i = Bars - Length - 1; i >= 0; i--) {
		double Juice = iStdDev(NULL, 0, Length, MODE_EMA, 0, PRICE_CLOSE, i);
		
		UpBuffer[i] = Juice;
		DnBuffer[i] = Ks*avg;
		
		if (AlertsEnabled && i == 0 && AlertTime != Time[0]) {
			if (UpBuffer[0]/DnBuffer[0] >= AlertsProximity) {
				AlertTime = Time[0];
				Alert("Juice Indicator! ", Symbol(), " M", Period());
				if (StringLen(AlertsSound) > 0)
					PlaySound(AlertsSound);
			}
		}
	}
}

