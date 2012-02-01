//+------------------------------------------------------------------+
//|   #SpudFibo.mq4 - downloaded from ultimaforex.com
//+------------------------------------------------------------------+

/*--------------------------------------------------------------------
#SpudFibo_v2:

For a "cleaner" look, this version completely separates the three groups
of Fibos from each other, and changes the diagonal line on the main 
Fibo to a vertical line, to match the others.  An indicator ON/OFF
"switch" has been added so that the indicator can remain in the list of
chart indicators, but be turned on/off by selecting "true" or "false" in 
the Indcator Window.
                                                       - Traderathome
----------------------------------------------------------------------*/  

#property  indicator_chart_window

extern bool   Indicator_On?  = true;
extern color  UpperFiboColor = RoyalBlue;
extern bool   UpperFiboOn    = true;
extern color  MainFiboColor  = DarkOliveGreen;
extern bool   MainFiboOn     = true;
extern color  LowerFiboColor = IndianRed;
extern bool   LowerFiboOn    = true;

double HiPrice, LoPrice, Range;
datetime StartTime;

//+------------------------------------------------------------------+
//| Indicator Initialization                                         |
//+------------------------------------------------------------------+
int init()
{
   return(0);
}

//+------------------------------------------------------------------+
//| Indicator De-initializtion                                       |
//+------------------------------------------------------------------+
int deinit()
{
   ObjectDelete("FiboUp");
   ObjectDelete("FiboDn");
   ObjectDelete("FiboIn");
   return(0);
}

//+------------------------------------------------------------------+
//| Indicator start function                                         |
//+------------------------------------------------------------------+

int start()
{
   if (Indicator_On? == false){return(0);}
   
	int shift	= iBarShift(NULL,PERIOD_D1,Time[0]) + 1;	// yesterday
	HiPrice		= iHigh(NULL,PERIOD_D1,shift);
	LoPrice		= iLow (NULL,PERIOD_D1,shift);
	StartTime	= iTime(NULL,PERIOD_D1,shift);

	if(TimeDayOfWeek(StartTime)==0/*Sunday*/)
	{//Add fridays high and low
		HiPrice = MathMax(HiPrice,iHigh(NULL,PERIOD_D1,shift+1));
		LoPrice = MathMin(LoPrice,iLow(NULL,PERIOD_D1,shift+1));
	}

	Range = HiPrice-LoPrice;
	DrawFibo();
	return(0);
}

//+------------------------------------------------------------------+
//| Indicator Draw Fibo Sub-routine                                  |
//+------------------------------------------------------------------+

int DrawFibo()
{
   if(UpperFiboOn)
   {
	if(ObjectFind("FiboUp") == -1)
	 //ObjectCreate("FiboUp",OBJ_FIBO,0,StartTime,HiPrice+Range,StartTime,HiPrice);
		ObjectCreate("FiboUp",OBJ_FIBO,0,StartTime,HiPrice+Range,StartTime,HiPrice+Range*0.236);
	else
	{
		ObjectSet("FiboUp",OBJPROP_TIME2, StartTime);
		ObjectSet("FiboUp",OBJPROP_TIME1, StartTime);
		ObjectSet("FiboUp",OBJPROP_PRICE1,HiPrice+Range);
	 //ObjectSet("FiboUp",OBJPROP_PRICE2,HiPrice);
		ObjectSet("FiboUp",OBJPROP_PRICE2,HiPrice+Range*0.236);
	}
   ObjectSet("FiboUp",OBJPROP_LEVELCOLOR,UpperFiboColor);
   ObjectSet("FiboUp",OBJPROP_FIBOLEVELS,18);   
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+ 0,0.000); ObjectSetFiboDescription("FiboUp",0,"(123.6%) -  %$");
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+ 1,0.189); ObjectSetFiboDescription("FiboUp",1,"(138.2%) -  %$");
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+ 2,0.346); ObjectSetFiboDescription("FiboUp",2,"(150.0%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+ 3,0.500); ObjectSetFiboDescription("FiboUp",3,"(161.8%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+ 4,0.691); ObjectSetFiboDescription("FiboUp",4,"(176.4%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+ 5,1.000); ObjectSetFiboDescription("FiboUp",5,"(200.0%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+ 6,1.311); ObjectSetFiboDescription("FiboUp",6,"(223.6%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+ 7,1.500); ObjectSetFiboDescription("FiboUp",7,"(238.2%) -  %$");
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+ 8,1.654); ObjectSetFiboDescription("FiboUp",8,"(250.0%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+ 9,1.810); ObjectSetFiboDescription("FiboUp",9,"(261.8%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+10,2.000); ObjectSetFiboDescription("FiboUp",10,"(276.4%) -  %$");
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+11,2.309); ObjectSetFiboDescription("FiboUp",11,"(300.0%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+12,2.960); ObjectSetFiboDescription("FiboUp",12,"(350.0%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+13,3.618); ObjectSetFiboDescription("FiboUp",13,"(400.0%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+14,4.272); ObjectSetFiboDescription("FiboUp",14,"(450.0%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+15,4.927); ObjectSetFiboDescription("FiboUp",15,"(500.0%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+16,5.578); ObjectSetFiboDescription("FiboUp",16,"(550.0%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_FIRSTLEVEL+17,6.236); ObjectSetFiboDescription("FiboUp",17,"(600.0%) -  %$"); 
   ObjectSet("FiboUp",OBJPROP_RAY,true);
   ObjectSet("FiboUp",OBJPROP_BACK,true);
   }

   //-----------------------------------------------------------------
	if(MainFiboOn)
	{
	if(ObjectFind("FiboIn") == -1)
	 //ObjectCreate("FiboIn",OBJ_FIBO,0,StartTime,HiPrice,StartTime+PERIOD_D1*60,LoPrice); //diagonal line
		ObjectCreate("FiboIn",OBJ_FIBO,0,StartTime,HiPrice,StartTime,LoPrice);              //vertical line
	else
	{
		ObjectSet("FiboIn",OBJPROP_TIME2, StartTime);
	 //ObjectSet("FiboIn",OBJPROP_TIME1, StartTime+PERIOD_D1*60); //creates diagonal line
		ObjectSet("FiboIn",OBJPROP_TIME1, StartTime);              //creates vertical line
		ObjectSet("FiboIn",OBJPROP_PRICE1,HiPrice);
		ObjectSet("FiboIn",OBJPROP_PRICE2,LoPrice);
	}
   ObjectSet("FiboIn",OBJPROP_LEVELCOLOR,MainFiboColor); 
   ObjectSet("FiboIn",OBJPROP_FIBOLEVELS,7);
   ObjectSet("FiboIn",OBJPROP_FIRSTLEVEL+0,0.000);	ObjectSetFiboDescription("FiboIn",0,"Daily LOW  (  0  ) -  %$"); 
   ObjectSet("FiboIn",OBJPROP_FIRSTLEVEL+1,0.236);	ObjectSetFiboDescription("FiboIn",1,"(23.6) -  %$"); 
   ObjectSet("FiboIn",OBJPROP_FIRSTLEVEL+2,0.382);	ObjectSetFiboDescription("FiboIn",2,"(38.2) -  %$"); 
   ObjectSet("FiboIn",OBJPROP_FIRSTLEVEL+3,0.500);	ObjectSetFiboDescription("FiboIn",3,"(50.0) -  %$"); 
   ObjectSet("FiboIn",OBJPROP_FIRSTLEVEL+4,0.618);	ObjectSetFiboDescription("FiboIn",4,"(61.8) -  %$"); 
   ObjectSet("FiboIn",OBJPROP_FIRSTLEVEL+5,0.764);	ObjectSetFiboDescription("FiboIn",5,"(76.4) -  %$"); 
   ObjectSet("FiboIn",OBJPROP_FIRSTLEVEL+6,1.000);	ObjectSetFiboDescription("FiboIn",6,"Daily HIGH  (100) -  %$"); 
   ObjectSet("FiboIn",OBJPROP_RAY,true);
   ObjectSet("FiboIn",OBJPROP_BACK,true);
   }


   //-----------------------------------------------------------------
   if(LowerFiboOn)
   {
	if(ObjectFind("FiboDn") == -1)
	 //ObjectCreate("FiboDn",OBJ_FIBO,0,StartTime,LoPrice-Range,StartTime,LoPrice);
		ObjectCreate("FiboDn",OBJ_FIBO,0,StartTime,LoPrice-Range,StartTime,LoPrice-Range*0.236);
	else
	{
		ObjectSet("FiboDn",OBJPROP_TIME2, StartTime);
		ObjectSet("FiboDn",OBJPROP_TIME1, StartTime);
		ObjectSet("FiboDn",OBJPROP_PRICE1,LoPrice-Range);
	 //ObjectSet("FiboDn",OBJPROP_PRICE1,LoPrice);
		ObjectSet("FiboDn",OBJPROP_PRICE2,LoPrice-Range*0.236);
	}
   ObjectSet("FiboDn",OBJPROP_LEVELCOLOR,LowerFiboColor); 
   ObjectSet("FiboDn",OBJPROP_FIBOLEVELS,18);   
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+ 0,0.000); ObjectSetFiboDescription("FiboDn", 0,"(-23.6%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+ 1,0.189); ObjectSetFiboDescription("FiboDn", 1,"(-38.2%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+ 2,0.346); ObjectSetFiboDescription("FiboDn", 2,"(-50.0%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+ 3,0.500); ObjectSetFiboDescription("FiboDn", 3,"(-61.8%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+ 4,0.691); ObjectSetFiboDescription("FiboDn", 4,"(-76.4%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+ 5,1.000); ObjectSetFiboDescription("FiboDn", 5,"(-100.0%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+ 6,1.311); ObjectSetFiboDescription("FiboDn", 6,"(-123.6%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+ 7,1.500); ObjectSetFiboDescription("FiboDn", 7,"(-138.2%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+ 8,1.654); ObjectSetFiboDescription("FiboDn", 8,"(-150.0%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+ 9,1.810); ObjectSetFiboDescription("FiboDn", 9,"(-161.8%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+10,2.000); ObjectSetFiboDescription("FiboDn",10,"(-176.4%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+11,2.309); ObjectSetFiboDescription("FiboDn",11,"(-200.0%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+12,2.960); ObjectSetFiboDescription("FiboDn",12,"(-250.0%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+13,3.618); ObjectSetFiboDescription("FiboDn",13,"(-300.0%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+14,4.272); ObjectSetFiboDescription("FiboDn",14,"(-350.0%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+15,4.927); ObjectSetFiboDescription("FiboDn",15,"(-400.0%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+16,5.578); ObjectSetFiboDescription("FiboDn",16,"(-450.0%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_FIRSTLEVEL+17,6.236); ObjectSetFiboDescription("FiboDn",17,"(-500.0%) -  %$"); 
   ObjectSet("FiboDn",OBJPROP_RAY,true);
   ObjectSet("FiboDn",OBJPROP_BACK,true);
   } 
}

//+------------------------------------------------------------------+
//| Indicator - End of Program                                       |
//+------------------------------------------------------------------+


