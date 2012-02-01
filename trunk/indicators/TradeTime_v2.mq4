
//+------------------------------------------------------------------+
//|                                                 TradeTime_v1.mq4 |
//|                                                          Kalenzo |
//|                                      bartlomiej.gorski@gmail.com |
//+------------------------------------------------------------------+
#property copyright "Kalenzo"
#property link      "bartlomiej.gorski@gmail.com"

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 DarkSlateGray
#property indicator_color2 Yellow
#property indicator_color3 DarkOrange
#property indicator_color4 DarkOrange
 
 
 
double UpBuffer[];
double DnBuffer[];

double BorderTop[];
double BorderBottom[];



extern int START_Hour = 7;
extern int END_Hour = 18;

extern int START_Day = 3;
extern int END_Day = 5;

string shortName = "TradeTime";

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- additional buffers are used for counting
   IndicatorBuffers(4);
   SetIndexStyle(0,DRAW_HISTOGRAM,STYLE_DOT,1);
   SetIndexStyle(1,DRAW_HISTOGRAM,STYLE_DOT,1);
   
   SetIndexStyle(2,DRAW_LINE,STYLE_SOLID,2);
   SetIndexStyle(3,DRAW_LINE,STYLE_SOLID,2);
   
   SetIndexBuffer(0,UpBuffer);
   SetIndexBuffer(1,DnBuffer);
   
   SetIndexBuffer(2,BorderTop);
   SetIndexBuffer(3,BorderBottom);
 
   IndicatorShortName(shortName);
   return(0);
  }
//+------------------------------------------------------------------+
//| SignalIndicator                                                  |
//+------------------------------------------------------------------+
int start()
  {
   int limit;
   int counted_bars=IndicatorCounted();
   if(counted_bars<0) counted_bars=0;
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
   
   if(START_Hour >= END_Hour)
   {
      Alert("WRONG TIME START MUST BE > THAN END");
      for(int w = 0 ;w <= limit ;w++)
      {
         UpBuffer[w] = EMPTY_VALUE;
         DnBuffer[w] = EMPTY_VALUE;
    
         BorderTop[w] = EMPTY_VALUE;
         BorderBottom[w] = EMPTY_VALUE;
         
       }   
      return(0);
   }
   
   if(START_Hour > 23 || END_Hour > 23)
   {
      Alert("WRONG TIME - VALID HOURS ARE BETWEEN 0 AND 23");
      return(0);
   }
   
//---- 
   for(int i = 0 ;i <= limit ;i++)
   {
      if( (TimeHour(Time[i]) >= START_Hour && TimeHour(Time[i]) <= END_Hour) && (TimeDayOfWeek(Time[i]) >= START_Day && TimeDayOfWeek(Time[i])<=END_Day) )
      {
         //BUY SIGNAL
         UpBuffer[i] = iHigh(Symbol(),PERIOD_D1,iBarShift(Symbol(),PERIOD_D1,Time[i]));
         DnBuffer[i] = iLow(Symbol(),PERIOD_D1,iBarShift(Symbol(),PERIOD_D1,Time[i]));
         
         BorderTop[i] = iHigh(Symbol(),PERIOD_D1,iBarShift(Symbol(),PERIOD_D1,Time[i]));
         BorderBottom[i] = iLow(Symbol(),PERIOD_D1,iBarShift(Symbol(),PERIOD_D1,Time[i]));
         
      }
      else
      {
         //NO SIGNAL
         UpBuffer[i] = EMPTY_VALUE;
         DnBuffer[i] = EMPTY_VALUE;
    
         BorderTop[i] = EMPTY_VALUE;
         BorderBottom[i] = EMPTY_VALUE;
         
       }
      
       
      
   }
//----
 return(0);
  }
//+------------------------------------------------------------------+
 