//+------------------------------------------------------------------+
//|                                        NonLagMA Stoch Signal.mq4 |
//|                              Copyright © 2008, TradingSytemForex |
//|                                http://www.tradingsystemforex.com |
//+------------------------------------------------------------------+

#property copyright "Copyright © 2008, TradingSytemForex"
#property link "http://www.tradingsystemforex.com"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 DeepSkyBlue
#property indicator_color2 OrangeRed

double CrossUp[];
double CrossDown[];
double prevtime;
double Range, AvgRange;
double LimeRmonow, LimeRmoprevious;
double GoldRmonow, GoldRmoprevious;

extern string S1="---------------- NonLagMA Settings";
extern int Price=0;  //Apply to Price(0-Close;1-Open;2-High;3-Low;4-Median price;5-Typical price;6-Weighted Close) 
extern int Length=12;  //Period of NonLagMA
extern int Displace=0;  //DispLace or Shift 
extern double PctFilter=0;  //Dynamic filter in decimal
extern int Color=1;  //Switch of Color mode (1-color)  
extern int ColorBarBack=-3;  //Bar back for color mode
extern double Deviation=0;  //Up/down deviation        
extern int SoundAlertMode=0;  //Sound Alert switch 
extern string S2="---------------- NonLagMA Settings";
extern int StochKP=12;
extern int StochDP=12;
extern int StochSP=5;
extern string S3="---------------- Alert Settings";
extern int  PopAlert    = 0; //0=disabled

//+------------------------------------------------------------------+
//| Initialization                                                   |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   SetIndexStyle(0, DRAW_ARROW, EMPTY, 2);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, CrossUp);
   SetIndexStyle(1, DRAW_ARROW, EMPTY, 2);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, CrossDown);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Deinitialization                                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//---- 

//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Iteration                                                        |
//+------------------------------------------------------------------+
int start()
 {
   int limit, i, counter;
   int counted_bars=IndicatorCounted();
   
   if(counted_bars<0) return(-1);
   if(counted_bars>0) counted_bars--;
   
   limit=Bars-counted_bars;
   
   for(i = 0; i <= limit; i++)
   {
      counter=i;
      Range=0;
      AvgRange=0;
      for(counter=i ;counter<=i+9;counter++)
      {
         AvgRange=AvgRange+MathAbs(High[counter]-Low[counter]);
      }
      Range=AvgRange/10;
      
double NLM1a=iCustom(Symbol(),0,"NonLagMA_v7",Price,Length,Displace,PctFilter,Color,ColorBarBack,Deviation,SoundAlertMode,2,i+2);//down
double NLM1=iCustom(Symbol(),0,"NonLagMA_v7",Price,Length,Displace,PctFilter,Color,ColorBarBack,Deviation,SoundAlertMode,2,i+1);
double NLM2=iCustom(Symbol(),0,"NonLagMA_v7",Price,Length,Displace,PctFilter,Color,ColorBarBack,Deviation,SoundAlertMode,2,i);
double NLM3a=iCustom(Symbol(),0,"NonLagMA_v7",Price,Length,Displace,PctFilter,Color,ColorBarBack,Deviation,SoundAlertMode,0,i+2);//mid
double NLM3=iCustom(Symbol(),0,"NonLagMA_v7",Price,Length,Displace,PctFilter,Color,ColorBarBack,Deviation,SoundAlertMode,0,i+1);
double NLM4=iCustom(Symbol(),0,"NonLagMA_v7",Price,Length,Displace,PctFilter,Color,ColorBarBack,Deviation,SoundAlertMode,0,i);
double NLM5a=iCustom(Symbol(),0,"NonLagMA_v7",Price,Length,Displace,PctFilter,Color,ColorBarBack,Deviation,SoundAlertMode,1,i+2);//up
double NLM5=iCustom(Symbol(),0,"NonLagMA_v7",Price,Length,Displace,PctFilter,Color,ColorBarBack,Deviation,SoundAlertMode,1,i+1);
double NLM6=iCustom(Symbol(),0,"NonLagMA_v7",Price,Length,Displace,PctFilter,Color,ColorBarBack,Deviation,SoundAlertMode,1,i);

double STO1=iStochastic(NULL,0,StochKP,StochDP,StochSP,MODE_LWMA,0,MODE_MAIN,i+1);
double STO2=iStochastic(NULL,0,StochKP,StochDP,StochSP,MODE_LWMA,0,MODE_SIGNAL,i+1);
double STO3=iStochastic(NULL,0,StochKP,StochDP,StochSP,MODE_LWMA,0,MODE_MAIN,i);
double STO4=iStochastic(NULL,0,StochKP,StochDP,StochSP,MODE_LWMA,0,MODE_SIGNAL,i);
      
      if((!(NLM5a!=EMPTY_VALUE&&NLM5!=EMPTY_VALUE&&NLM3a!=NLM5)&&NLM5!=EMPTY_VALUE&&NLM6!=EMPTY_VALUE&&NLM3!=NLM6)&&(STO2>STO1&&STO4<STO3))
      {
         CrossUp[i] = Low[i] - Range*0.5;
       }
       
      if ((!(NLM1a!=EMPTY_VALUE&&NLM1!=EMPTY_VALUE&&NLM3a!=NLM1)&&NLM1!=EMPTY_VALUE&&NLM2!=EMPTY_VALUE&&NLM3!=NLM2)&&(STO2<STO1&&STO4>STO3))
      {
         CrossDown[i] = High[i] + Range*0.5;
      }
   }
   if((CrossUp[0] > 2000) && (CrossDown[0] > 2000)) { prevtime = 0; }
   if((CrossUp[0] == Low[0] - Range*0.5) && (prevtime != Time[0]) && (PopAlert != 0))
   {
      prevtime = Time[0];
      Alert(Symbol()," NonLagMA Stoch Signal Up @  Hour ",Hour(),"  Minute ",Minute());
   } 
   if((CrossDown[0] == High[0] + Range*0.5) && (prevtime != Time[0]) && (PopAlert != 0))
   {
      prevtime = Time[0];
      Alert(Symbol()," NonLagMA Stoch Signal Down @  Hour ",Hour(),"  Minute ",Minute());
   }
   return(0);
 }

