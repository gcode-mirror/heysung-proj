//+------------------------------------------------------------------+
//|                                       PriceChannel_Stop_v1.3.mq4 |
//|                               Copyright © 2006-08, Forex-TSD.com |
//|                         Written by IgorAD,igorad2003@yahoo.co.uk |   
//|            http://finance.groups.yahoo.com/group/TrendLaboratory |                                      
//+------------------------------------------------------------------+
#property copyright "Copyright © 20006-08, Forex-TSD.com "
#property link      "http://www.forex-tsd.com/"

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Aqua
#property indicator_color2 Magenta
#property indicator_color3 Aqua
#property indicator_color4 Magenta

//---- input parameters
extern int    ChannelPeriod=     9; //Price Channel Period
extern double Risk         =  0.30; //Channel narrowing factor (0...0,5)
extern int    SignalMode   =     1; //0-Signal off,1-on
extern int    AlertMode    =     0; //0-alert off,1-on
extern int    VisualMode   =     0; //0-lines,1-dots 
extern int    EmailMode    =     0; //0-Email off,1-on 

//extern int Nbars=1000;
//---- indicator buffers
double UpBuffer[];
double DnBuffer[];
double UpSignal[];
double DnSignal[];
double smin[];
double smax[];
double trend[];

bool UpTrendAlert=false, DnTrendAlert=false;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;
//---- indicator line
   IndicatorBuffers(7);
   SetIndexBuffer(0,UpBuffer);
   SetIndexBuffer(1,DnBuffer);
   SetIndexBuffer(2,UpSignal);
   SetIndexBuffer(3,DnSignal);
   SetIndexBuffer(4,smin);
   SetIndexBuffer(5,smax);
   SetIndexBuffer(6,trend);
      if(VisualMode==0)
      {
      SetIndexStyle(0,DRAW_LINE);
      SetIndexStyle(1,DRAW_LINE);
      }
      else
      {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(0,159);
      SetIndexArrow(1,159);
      }
   
   SetIndexStyle(2,DRAW_ARROW);
   SetIndexStyle(3,DRAW_ARROW);
   SetIndexArrow(2,108);
   SetIndexArrow(3,108);
//---- name for DataWindow and indicator subwindow label
   short_name="PriceChannel_Stop_v1.3("+ChannelPeriod+","+DoubleToStr(Risk,3)+")";
   IndicatorShortName(short_name);
   SetIndexLabel(0,"UpTrend");
   SetIndexLabel(1,"DnTrend");
   SetIndexLabel(2,"UpSignal");
   SetIndexLabel(3,"DnSignal");
//----
   SetIndexDrawBegin(0,ChannelPeriod);
   SetIndexDrawBegin(1,ChannelPeriod);
   SetIndexDrawBegin(2,ChannelPeriod);
   SetIndexDrawBegin(3,ChannelPeriod);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| PriceChannel_Stop_v1.3                                             |
//+------------------------------------------------------------------+
int start()
  {
   int    i,shift, counted_bars=IndicatorCounted(),limit;
   double hi, lo, price;
  
   string Message;
   
   if ( counted_bars > 0 )  limit=Bars-counted_bars;
   if ( counted_bars < 0 )  return(0);
   if ( counted_bars ==0 )  limit=Bars-ChannelPeriod-1; 
   
   if ( counted_bars < 1 ) 
   for(i=1;i<ChannelPeriod;i++)
   { 
   UpBuffer[shift]=EMPTY_VALUE;
   DnBuffer[shift]=EMPTY_VALUE;
   UpSignal[shift]=EMPTY_VALUE;
   DnSignal[shift]=EMPTY_VALUE;
   }
   
   for (shift=limit;shift>=0;shift--)
   {	
   lo = Low[iLowest(NULL,0,MODE_LOW,ChannelPeriod,shift)];    
   hi = High[iHighest(NULL,0,MODE_HIGH,ChannelPeriod,shift)];
     
   smax[shift] = hi - (hi-lo)*Risk;
   smin[shift] = lo + (hi-lo)*Risk;
     
   trend[shift]=trend[shift+1];
   if (Close[shift] > smax[shift+1]) trend[shift]= 1; 
	if (Close[shift] < smin[shift+1]) trend[shift]=-1;
		  		
      if(trend[shift] > 0)
      {
         if(smin[shift] < smin[shift+1]) smin[shift] = smin[shift+1];
      UpBuffer[shift] = smin[shift];
	      if (SignalMode > 0 && trend[shift+1] != trend[shift]) UpSignal[shift] = smin[shift];
	      else UpSignal[shift] = EMPTY_VALUE;
	      if (SignalMode == 2) UpBuffer[shift] = EMPTY_VALUE;
	   DnBuffer[shift] = EMPTY_VALUE;
	   DnSignal[shift] = EMPTY_VALUE;
	   }
	   else
	   if(trend[shift] < 0)
	   {
         if(smax[shift] > smax[shift+1]) smax[shift] = smax[shift+1];
      DnBuffer[shift] = smax[shift];
         if(SignalMode > 0 && trend[shift+1] != trend[shift]) DnSignal[shift] = smax[shift];
	      if(SignalMode == 2) DnBuffer[shift] = EMPTY_VALUE;
	   UpBuffer[shift] = EMPTY_VALUE;
	   UpSignal[shift] = EMPTY_VALUE;
	   }
   }

   if(trend[2]<0 && trend[1]>0 && Volume[0]>1 && !UpTrendAlert)
	{
	Message = " "+Symbol()+" M"+Period()+": Signal for BUY";
      if(AlertMode > 0) Alert (Message); 
      if(EmailMode > 0) SendMail ("Signal from PriceChannel_Stop",TimeToStr(CurTime())+Message);
	UpTrendAlert=true; DnTrendAlert=false;
	} 
	else 	  
	if(trend[2]>0 && trend[1]<0 && Volume[0]>1 && !DnTrendAlert)
	{
	Message = " "+Symbol()+" M"+Period()+": Signal for SELL";
      if ( AlertMode > 0) Alert (Message); 
	   if ( EmailMode > 0) SendMail ("Signal from PriceChannel_Stop",TimeToStr(CurTime())+Message);
	DnTrendAlert=true; UpTrendAlert=false;
	} 
	 
   
   return(0);
}
//+------------------------------------------------------------------+