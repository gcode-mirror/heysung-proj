//+------------------------------------------------------------------+
//|                                                 Demo_heysung.mq4 |
//|                       Copyright ?2011, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright ?2011, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window
#property indicator_minimum 1
#property indicator_maximum 10
#property indicator_buffers 2
#property indicator_color1 Red
#property indicator_color2 Blue
//--- input parameters
extern int       ExtParam1;
extern int       ExtParam2;
//--- buffers
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
   SetIndexStyle(1,DRAW_LINE);
   SetIndexBuffer(1,ExtMapBuffer2);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start() 
  {
   int    counted_bars=IndicatorCounted();
//----

    Print("the current time is ",TimeToStr(CurTime(),TIME_DATE|TIME_SECONDS), "  Period is ",Period( ) );
//----
   return(0);
  }
//+------------------------------------------------------------------+

double CalcolaLot(int ai_0) {
   double ld_4 = 0;
   ld_4 = AccountEquity();
  
   if (ld_4 >= 0.1) ld_4 = NormalizeDouble(ld_4, 1);
   else ld_4 = NormalizeDouble(ld_4, 2);
   if (ld_4 < MarketInfo(Symbol(), MODE_MINLOT)) ld_4 = MarketInfo(Symbol(), MODE_MINLOT);
   return (ld_4);
}