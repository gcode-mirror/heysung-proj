//+------------------------------------------------------------------+
//|                                           |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Red
#property indicator_color2 DeepSkyBlue
//---- input parameters
extern int       numBars=630;
//---- buffers
double ExtMapBuffer1[];
double ExtMapBuffer2[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,ExtMapBuffer1);
   SetIndexArrow(0,160);
   SetIndexEmptyValue(0,0.0);
   SetIndexStyle(1,DRAW_LINE);
   SetIndexBuffer(1,ExtMapBuffer2);
   SetIndexArrow(1,160);   
   SetIndexEmptyValue(1,0.0);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//---- TODO: add your code here
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int    counted_bars=IndicatorCounted();
   
   int shift=0;
	double MACD=0, MACD1=0, MACD2=0 ,pvu=0 ,pvd=0;
//---- TODO: add your code here
   for (shift=numBars-Period()-1;shift>=1;shift--)
   {
   //********** Coding Gue mulai di sini nih 
   MACD=iMACD(NULL,0,5,13,9,PRICE_CLOSE,MODE_MAIN,shift);
   MACD1=iMACD(NULL,0,5,13,9,PRICE_CLOSE,MODE_MAIN,shift+1);
   MACD2=iMACD(NULL,0,5,13,9,PRICE_CLOSE,MODE_MAIN,shift+2);
   
   double seco= (Time[4]-Time[5])-MathMod(CurTime(),Time[4]-Time[5]);
   double minu=seco/60;
   seco=(minu-MathFloor(minu))*60;
   minu=MathFloor(minu);
   
   if (MACD2<0 && MACD1>=0) 
      {
      pvu=High[shift+1];
      }
   if (MACD2>0 && MACD1<=0) 
      {
      pvd=Low[shift+1];
      }

   if (iMA(NULL,0,5,0,MODE_EMA,PRICE_CLOSE,shift+1)>=iMA(NULL,0,13,0,MODE_EMA,PRICE_CLOSE,shift+1)+(1*Point))
      {
   //   ExtMapBuffer1[shift]=pvu;
      Comment("Time for next bar: ",	minu," min ",seco," sec");
      }
   if (iMA(NULL,0,5,0,MODE_EMA,PRICE_CLOSE,shift+1)<=iMA(NULL,0,13,0,MODE_EMA,PRICE_CLOSE,shift+1)-(1*Point)) 
      {
   //	ExtMapBuffer2[shift]=pvd;
   	Comment("Time for next bar: ",	minu," min ",seco," sec");
   	}

   }
//----

    return(0);
  }
//+------------------------------------------------------------------+