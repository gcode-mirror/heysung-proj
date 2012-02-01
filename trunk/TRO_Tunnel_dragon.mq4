//+------------------------------------------------------------------+
//|           TRO_Tunnel_dragon                                      |
//|                                                                  |
//|   Copyright © 2008, Avery T. Horton, Jr. aka TheRumpledOne       |
//|                                                                  |
//|   PO BOX 43575, TUCSON, AZ 85733                                 |
//|                                                                  |
//|   GIFTS AND DONATIONS ACCEPTED                                   | 
//|                                                                  |
//|   therumpledone@gmail.com                                        |  
//+------------------------------------------------------------------+ 

// http://forums.babypips.com/free-forex-trading-systems/10766-trading-systems-new-concepts-technical-trading-systems-j-welles-wilder-40.html

#property  copyright "Copyright © 2008, Avery T. Horton, Jr. aka TRO" 
#property indicator_chart_window 

#property indicator_buffers 8

#property indicator_color1 DodgerBlue 
#property indicator_color2 Red
#property indicator_color3 DodgerBlue
/*
#property indicator_color4 Purple
#property indicator_color5 Teal
#property indicator_color6 Orange
#property indicator_color7 Red
#property indicator_color8 Magenta
*/
// indicators parameters


extern bool   Show.PriceBox  = true ;
extern int    myThickness    = 1 ;
extern int    myStyle        = 0 ;

extern int   myPeriod        = 0 ;
extern int   myShift         = 0 ;

extern string    notetype         = "0=SMA,1=EMA,2=SMMA,3=LWMA" ;
extern string    noteprice        = "0=CLOSE,1=OPEN,2=HIGH,3=LOW,4=MEDIAN,5=PP,6=WEIGHT" ;
extern int   myMA_Period1  = 50 ;
extern int       MAType1   = 1;
extern int       MAPrice1  = PRICE_HIGH ;

extern int   myMA_Period2  = 50 ;
extern int       MAType2   = 1;
extern int       MAPrice2  = PRICE_CLOSE ;

extern int   myMA_Period3  = 50 ;
extern int       MAType3   = 1;
extern int       MAPrice3  = PRICE_LOW ;




//extern int   myWingDing  = 119 ;



//---- buffers

double P0Buffer[];
double P1Buffer[];
double P2Buffer[];
double P3Buffer[];
double P4Buffer[];
double P5Buffer[];
double P6Buffer[];
double P7Buffer[];

string tP0Buf = "drma_01" ;
string tP1Buf = "drma_02" ;
string tP2Buf = "drma_03" ;


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- name for indicator window

   string short_name=" ";
   IndicatorShortName(short_name);
   SetIndexBuffer(0, P0Buffer);
   SetIndexBuffer(1, P1Buffer);
   SetIndexBuffer(2, P2Buffer);
   SetIndexBuffer(3, P3Buffer); 
   SetIndexBuffer(4, P4Buffer);
   SetIndexBuffer(5, P5Buffer);
   SetIndexBuffer(6, P6Buffer);
   SetIndexBuffer(7, P7Buffer);  
//----

SetIndexArrow(0, 119); 
SetIndexArrow(1, 119); 
SetIndexArrow(2, 119); 
SetIndexArrow(3, 119); 
SetIndexArrow(4, 119); 
SetIndexArrow(5, 119); 
SetIndexArrow(6, 119); 
SetIndexArrow(7, 119); 

   SetIndexStyle(0, DRAW_LINE, myStyle, myThickness, indicator_color1 );
   SetIndexStyle(1, DRAW_LINE, myStyle, myThickness, indicator_color2 );   
   SetIndexStyle(2, DRAW_LINE, myStyle, myThickness, indicator_color3 );
/*   
   SetIndexStyle(3, DRAW_ARROW, myStyle, myThickness, indicator_color4 );   
   SetIndexStyle(4, DRAW_ARROW, myStyle, myThickness, indicator_color5 );
   SetIndexStyle(5, DRAW_ARROW, myStyle, myThickness, indicator_color6 );   
   SetIndexStyle(6, DRAW_ARROW, myStyle, myThickness, indicator_color7 );
   SetIndexStyle(7, DRAW_ARROW, myStyle, myThickness, indicator_color8 );   

*/  
   // setting the indicator values, which will be invisible on the chart
   SetIndexEmptyValue(0,0); 
   SetIndexEmptyValue(1,0);
   SetIndexEmptyValue(2,0); 
   SetIndexEmptyValue(3,0); 
   SetIndexEmptyValue(4,0); 
   SetIndexEmptyValue(5,0);
   SetIndexEmptyValue(6,0); 
   SetIndexEmptyValue(7,0); 
   
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
   

   ObjectDelete(tP0Buf);
   ObjectDelete(tP1Buf);
   ObjectDelete(tP2Buf);
         
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   datetime TimeArray[];
   int i, dayi, counted_bars = IndicatorCounted();
//---- check for possible errors
   if(counted_bars < 0) 
       return(-1);
//---- last counted bar will be recounted
   if(counted_bars > 0) 
       counted_bars--;  
   int limit = Bars - counted_bars;
//----   
   for(i = limit - 1; i >= 0; i--)
     {
        //---- Tricolor indicator code 


int BarShift = iBarShift(NULL,myPeriod,Time[i+myShift],true); 

 
        
P0Buffer[i] = iMA(NULL,myPeriod,myMA_Period1,0,MAType1,MAPrice1,BarShift);       
P1Buffer[i] = iMA(NULL,myPeriod,myMA_Period2,0,MAType2,MAPrice2,BarShift); 
P2Buffer[i] = iMA(NULL,myPeriod,myMA_Period3,0,MAType3,MAPrice3,BarShift);       
 
}	 



if(Show.PriceBox) 
{ 
  if (ObjectFind(tP0Buf) != 0)
      {
      
//          ObjectCreate(tP0Buf,OBJ_HLINE,0,Time[0],X01);         
          ObjectCreate(tP0Buf,OBJ_ARROW,0,Time[0],P0Buffer[0]);
          ObjectSet(tP0Buf,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
          ObjectSet(tP0Buf,OBJPROP_COLOR,indicator_color1);  
      } 
      else
      {
         ObjectMove(tP0Buf,0,Time[0],P0Buffer[0]);
      }
 

    
    if (ObjectFind(tP1Buf) != 0)
      {
          ObjectCreate(tP1Buf,OBJ_ARROW,0,Time[0],P1Buffer[0]);
          ObjectSet(tP1Buf,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
          ObjectSet(tP1Buf,OBJPROP_COLOR,indicator_color2);  
      } 
      else
      {
         ObjectMove(tP1Buf,0,Time[0],P1Buffer[0]);
      }


    if (ObjectFind(tP2Buf) != 0)
      {
          ObjectCreate(tP2Buf,OBJ_ARROW,0,Time[0],P2Buffer[0]);
          ObjectSet(tP2Buf,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
          ObjectSet(tP2Buf,OBJPROP_COLOR,indicator_color3);  
      } 
      else
      {
         ObjectMove(tP2Buf,0,Time[0],P2Buffer[0]);
      }
}   
	
   return(0);

  }