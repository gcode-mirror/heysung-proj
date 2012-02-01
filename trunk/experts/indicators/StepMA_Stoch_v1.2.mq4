//+------------------------------------------------------------------+
//|                                              StepMA_Stoch_v1.mq4 |
//|                           Copyright © 2005, TrendLaboratory Ltd. |
//|                                       E-mail: igorad2004@list.ru |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, TrendLaboratory Ltd."
#property link      "E-mail: igorad2004@list.ru"

#property indicator_separate_window
#property indicator_buffers 4
#property indicator_color1 Yellow
#property indicator_color2 DeepSkyBlue
#property indicator_minimum 0
#property indicator_maximum 1
//---- input parameters
extern int PeriodWATR=10;
extern double Kwatr=1.0000;
extern int CalculatedBars = 500;
extern int HighLow=0;
//---- indicator buffers
double LineMinBuffer[],LineMidBuffer[],LineBuyBuffer[],LineSellBuffer[],WATRmax,WATRmin; // original conversion by igorad
double SminMin1,SmaxMin1,SminMax1,SmaxMax1,SminMid1,SmaxMid1,TrendMin,TrendMax,TrendMid; // speed-up and un-needed code removal by omelette
bool FirstPass=true;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
  int init()
  {
   string short_name;
//---- indicator line
   IndicatorBuffers(4);
   SetIndexStyle(0,DRAW_LINE,STYLE_SOLID,1);
   SetIndexStyle(1,DRAW_LINE,STYLE_SOLID,1);
   SetIndexStyle(2,DRAW_ARROW,STYLE_SOLID,2,Blue);
   SetIndexStyle(3,DRAW_ARROW,STYLE_SOLID,2,Red);
   SetIndexBuffer(0,LineMinBuffer);
   SetIndexBuffer(1,LineMidBuffer);
   SetIndexBuffer(2,LineBuyBuffer);
   SetIndexBuffer(3,LineSellBuffer);
   SetIndexEmptyValue(2,0);
   SetIndexArrow(2,233);
   SetIndexEmptyValue(3,0);
   SetIndexArrow(3,234);
   
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS));
//---- name for DataWindow and indicator subwindow label
   short_name="StepMA Stoch("+PeriodWATR+","+Kwatr+","+HighLow+")";
   IndicatorShortName(short_name);
   SetIndexLabel(0,"StepMA Stoch 1");
   SetIndexLabel(1,"StepMA Stoch 2");
//----
   SetIndexDrawBegin(0,PeriodWATR);
   SetIndexDrawBegin(1,PeriodWATR);
//----
   return(0);
  }

//+------------------------------------------------------------------+
//| StepMA_3D_v1                                                         |
//+------------------------------------------------------------------+
int start()
  {
   int      count,i,shift,Nbars;
   double   SumRange,dK,WATR0;
   double   SminMin0,SmaxMin0,SminMax0,SmaxMax0,SminMid0,SmaxMid0;
   double   linemin,linemax,linemid,Stoch1,Stoch2,bsmin,bsmax;
   	
   int counted_bars = IndicatorCounted();
   
   if (counted_bars < 0 || CalculatedBars < WindowBarsPerChart())
    return;   
   else Nbars = Bars - counted_bars - 1;
   if (Nbars == 1 || FirstPass) {
    Nbars = CalculatedBars-1;
    WATRmax = 0;
    WATRmin = 99999; }
   
   for(shift=Nbars;shift>=0;shift--)
   {
	SumRange=0;
	for (i=PeriodWATR-1;i>=0;i--) { 
    dK = 1+1.0*(PeriodWATR-i)/PeriodWATR;
    SumRange+= dK*(High[i+shift]-Low[i+shift]); }
   WATR0 = SumRange/PeriodWATR;	
	if (shift == CalculatedBars-1-PeriodWATR)
	 WATRmin=WATR0;
	WATRmin=MathMin(WATR0,WATRmin);
   WATRmax=MathMax(WATR0,WATRmax);
   
	double StepSizeMin=Kwatr*WATRmin;
	double StepSizeMax=Kwatr*WATRmax;
	double StepSizeMid=Kwatr*0.5*(WATRmax+WATRmin);
	
	if (HighLow>0)
	  {
	  SmaxMin0=Low[shift]+2*StepSizeMin;
	  SminMin0=High[shift]-2*StepSizeMin;
	  
	  SmaxMax0=Low[shift]+2*StepSizeMax;
	  SminMax0=High[shift]-2*StepSizeMax;
	  
	  SmaxMid0=Low[shift]+2*StepSizeMid;
	  SminMid0=High[shift]-2*StepSizeMid;
	  
	  if(Close[shift]>SmaxMin1) TrendMin=1; 
	  if(Close[shift]<SminMin1) TrendMin=-1;
	  
	  if(Close[shift]>SmaxMax1) TrendMax=1; 
	  if(Close[shift]<SminMax1) TrendMax=-1;
	  
	  if(Close[shift]>SmaxMid1) TrendMid=1; 
	  if(Close[shift]<SminMid1) TrendMid=-1;
	  }
	 
	if (HighLow == 0)
	  {
	  SmaxMin0=Close[shift]+2*StepSizeMin;
	  SminMin0=Close[shift]-2*StepSizeMin;
	  
	  SmaxMax0=Close[shift]+2*StepSizeMax;
	  SminMax0=Close[shift]-2*StepSizeMax;
	  
	  SmaxMid0=Close[shift]+2*StepSizeMid;
	  SminMid0=Close[shift]-2*StepSizeMid;
	 
	  if(Close[shift]>SmaxMin1) TrendMin=1; 
	  if(Close[shift]<SminMin1) TrendMin=-1;
	  
	  if(Close[shift]>SmaxMax1) TrendMax=1; 
	  if(Close[shift]<SminMax1) TrendMax=-1;
	  
	  if(Close[shift]>SmaxMid1) TrendMid=1; 
	  if(Close[shift]<SminMid1) TrendMid=-1;
	  }
	 	
	  if(TrendMin>0 && SminMin0<SminMin1) SminMin0=SminMin1;
	  if(TrendMin<0 && SmaxMin0>SmaxMin1) SmaxMin0=SmaxMin1;
		
	  if(TrendMax>0 && SminMax0<SminMax1) SminMax0=SminMax1;
	  if(TrendMax<0 && SmaxMax0>SmaxMax1) SmaxMax0=SmaxMax1;
	  
	  if(TrendMid>0 && SminMid0<SminMid1) SminMid0=SminMid1;
	  if(TrendMid<0 && SmaxMid0>SmaxMid1) SmaxMid0=SmaxMid1;
	  
	  
	  if (TrendMin>0) linemin=SminMin0+StepSizeMin;
	  if (TrendMin<0) linemin=SmaxMin0-StepSizeMin;
	  
	  if (TrendMax>0) linemax=SminMax0+StepSizeMax;
	  if (TrendMax<0) linemax=SmaxMax0-StepSizeMax;
	  
	  if (TrendMid>0) linemid=SminMid0+StepSizeMid;
	  if (TrendMid<0) linemid=SmaxMid0-StepSizeMid;
	  
	  bsmin=linemax-StepSizeMax;
	  bsmax=linemax+StepSizeMax;
	  
	  Stoch1=(linemin-bsmin)/(bsmax-bsmin);
	  Stoch2=(linemid-bsmin)/(bsmax-bsmin);
	  
	  LineMinBuffer[shift]=Stoch1;
	  LineMidBuffer[shift]=Stoch2;
	  
	  if (shift > 0) { 
	   SminMin1=SminMin0;
	   SmaxMin1=SmaxMin0;
	  
	   SminMax1=SminMax0;
	   SmaxMax1=SmaxMax0;
	  
	   SminMid1=SminMid0;
	   SmaxMid1=SmaxMid0;
	   if (LineMinBuffer[shift]>LineMidBuffer[shift] && LineMinBuffer[shift + 1]<LineMidBuffer[shift + 1])
	    LineBuyBuffer[shift] = LineMidBuffer[shift];
	   else if (LineMinBuffer[shift]<LineMidBuffer[shift] && LineMinBuffer[shift + 1]>LineMidBuffer[shift + 1])
	    LineSellBuffer[shift] = LineMidBuffer[shift];
	   else { LineBuyBuffer[shift] = EMPTY_VALUE;
	    LineSellBuffer[shift] = EMPTY_VALUE; } }
	 }
	FirstPass = false;
	return(0);	
 }

