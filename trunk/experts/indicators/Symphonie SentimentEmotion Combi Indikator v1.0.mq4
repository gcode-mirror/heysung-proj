//+------------------------------------------------------------------+
//|                                               GoldSuperCycle.mq4 |
//|                      Copyright © 2011, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2011, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_separate_window

#property indicator_buffers 4
#property indicator_color1 DodgerBlue  //Red  //Aqua
#property indicator_color2 Red
#property indicator_color3 Yellow
#property indicator_color4 Green
#property indicator_width1 4
#property indicator_width2 4
#property indicator_width3 4
#property indicator_width4 4

//---- buffers
double ExtMapBuffer1[];
double ExtMapBuffer2[];
double ExtMapBuffer3[];
double ExtMapBuffer4[];
double ExtHBuffer1[];
double ExtHBuffer2[];
double ExtHBuffer3[];
double ExtHBuffer4[];

extern bool      CalcOnNewBar = false;
extern bool      TransitionAlert = false;

extern string    CmtTF0 = "TimeFrame Values";
extern string    CmtTF1 = "0-Current Chart";
extern string    CmtTF2 = "1-1 Min,5-5 Min,15-15 Min";
extern string    CmtTF3 = "30-30 Min,60-1 HR,240-4 HR";
extern string    CmtTF4 = "1440=1 Day";
extern int       TimeFrame = 0;


extern string    Cmt0 = "Sentiment Variables";
extern int       SentimentPeriod = 12;

extern string    Cmt1 = "Emotion Variables";
extern int       EmotionSSP = 7;
extern double    EmotionKmax = 50.6; //24 21.6 21.6 
extern int       EmotionCountBars = 3000;

extern string    Cmt2 = "Trendline Variables";
extern int       TrendlineCciPeriod = 63;
extern int       TrendlineAtrPeriod = 18;


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   IndicatorBuffers(8);
   SetIndexStyle(0,DRAW_HISTOGRAM,0,4);  //Red
   SetIndexBuffer(0,ExtHBuffer1);
   SetIndexStyle(1,DRAW_HISTOGRAM,0,4);  //Aqua
   SetIndexBuffer(1,ExtHBuffer2);
   SetIndexStyle(2,DRAW_HISTOGRAM,0,4);  //Yellow
   SetIndexBuffer(2,ExtHBuffer3);
   SetIndexStyle(3,DRAW_HISTOGRAM,0,4);  //Green
   SetIndexBuffer(3,ExtHBuffer4);

   SetIndexBuffer(4,ExtMapBuffer1);
   SetIndexBuffer(5,ExtMapBuffer2);
   SetIndexBuffer(6,ExtMapBuffer3);
   SetIndexBuffer(7,ExtMapBuffer4);

   IndicatorShortName("GoldSuperCycle");
   
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
  
bool bNewBar()
{
  static int iTimeCheck = 0;
  
  if (iTimeCheck < iTime(0,0,0))
  {
    iTimeCheck = iTime(0,0,0);
    return(true);
  }
  else
  {
    return(false);
  }
}
  
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
{
   static bool bFirstTime = true;
   
   if (!bFirstTime)
   {
     if (CalcOnNewBar)
     {
       if (!bNewBar())
       {
         return(0);
       }
     }
   }
   else 
   {
     bFirstTime = false;
   }
   
   int counted_bars = IndicatorCounted();
   int i = 0;
   
   if (EmotionCountBars >= Bars) 
   {
     EmotionCountBars = Bars;
   }
   
   if (Bars <= (EmotionSSP + 1)) 
   {
     return(0);
   }

   if(counted_bars< EmotionSSP+1)
   {
     for(i=1;i<=EmotionSSP;i++)
     {
       ExtMapBuffer1[EmotionCountBars-i]=0.0;
       ExtMapBuffer2[EmotionCountBars-i]=0.0;
       ExtMapBuffer3[EmotionCountBars-i]=0.0;
       ExtMapBuffer4[EmotionCountBars - i] = 0.0;
     }
   }
 
   SetIndexDrawBegin(0,Bars - EmotionCountBars + EmotionSSP);
   SetIndexDrawBegin(1,Bars - EmotionCountBars + EmotionSSP);
   SetIndexDrawBegin(2,Bars - EmotionCountBars + EmotionSSP);
   SetIndexDrawBegin(3,Bars - EmotionCountBars + EmotionSSP);

   for(i = EmotionCountBars - EmotionSSP;i >= 0;i--) 
   { 
     ExtMapBuffer1[i] = 1; 
     ExtMapBuffer2[i] = 0; 
     ExtMapBuffer3[i] = 0;
     ExtMapBuffer4[i] = 0;
     
     double SentimentValue0 = iCustom(NULL,TimeFrame,"Symphonie_Sentiment_Indikator",SentimentPeriod,0,i);
     double EmotionValue0 = iCustom(NULL,TimeFrame,"Symphonie_Market_Emotion_Indikator",EmotionSSP,EmotionKmax,EmotionCountBars,0,i);
     double EmotionValue1 = iCustom(NULL,TimeFrame,"Symphonie_Market_Emotion_Indikator",EmotionSSP,EmotionKmax,EmotionCountBars,1,i);
     //double TrendValue0 = iCustom(NULL,0,"Symphonie_Trendline_Indikator",TrendlineCciPeriod,TrendlineAtrPeriod,0,i);
     //double TrendValue1 = iCustom(NULL,0,"Symphonie_Trendline_Indicator",TrendlineCciPeriod,TrendlineAtrPeriod,1,i);
     //double StochasticMain = iStochastic(NULL,0,StochasticPctK,StochasticPctD,StochasticSlowing,MODE_SMA,0,MODE_MAIN,i);
     //double StochasticSignal = iStochastic(NULL,0,StochasticPctK,StochasticPctD,StochasticSlowing,MODE_SMA,MODE_SIGNAL,i);
     
     //To Do.
     //if ((TrendValue0 > 0.0) && (SentimentValue0 > 0.0) && (EmotionValue0 == 1.0))
    // {
    // }
     
     if ((SentimentValue0 > 0.0) && (EmotionValue0 == 1.0))
     {
        ExtHBuffer1[i] = 1;
        ExtHBuffer2[i] = 0;
        ExtHBuffer3[i] = 0;
     }
     else
     {
       if ((SentimentValue0 < 0.0) && (EmotionValue1 == 1.0))
       {
         ExtHBuffer1[i] = 0;
         ExtHBuffer2[i] = 1;
         ExtHBuffer3[i] = 0;
       }
       else
       {
         ExtHBuffer1[i] = 0;
         ExtHBuffer2[i] = 0;
         ExtHBuffer3[i] = 1;

       }
     }
   }      
   
   if (CalcOnNewBar)
   {
     if (TransitionAlert)
     {
       if (bNewBar())
       {
         if (findChosenIndex(1) != findChosenIndex(2))
         {
           Alert(Symbol() + " - GoldCycle Transitional Alert");
         }
       }
     }
   }
   return(0);
}

int findChosenIndex(int nIndex)
{
  int nChosenIndex = -1;
  
  if (ExtHBuffer1[nIndex] == 1)
  {
    nChosenIndex = 0;
  }
  else
  {
    if (ExtHBuffer2[nIndex] == 1)
    {
      nChosenIndex =  1;
    }
    else
    {
      if (ExtHBuffer3[nIndex] == 1)
      {
        nChosenIndex = 2;
      }
    }
  }
  
  return(nChosenIndex);
}
//+------------------------------------------------------------------+