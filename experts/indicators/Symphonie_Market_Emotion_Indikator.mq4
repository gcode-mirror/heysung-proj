//+------------------------------------------------------------------+
//|                           Symphonie_Market_Emotion_Indicator.mq4 |
//|  Based on Goldminer Indicator                                    |
//+------------------------------------------------------------------+

#property copyright "Symphonie Trader System"
#property link      " "


#property indicator_separate_window
#property indicator_buffers 2
#property indicator_color1 DodgerBlue  //Red  //Aqua
#property indicator_color2 Red
#property indicator_width1 4
#property indicator_width2 4

extern int       SSP=7;
extern double    Kmax=50.6; //24 21.6 21.6 
extern int       CountBars=3000;

//---- buffers
double ExtMapBuffer1[];
double ExtMapBuffer2[];
double ExtHBuffer1[];
double ExtHBuffer2[];




//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   IndicatorBuffers(4);
   SetIndexStyle(0,DRAW_HISTOGRAM,0,4);  //Red
   SetIndexBuffer(0,ExtHBuffer1);
   SetIndexStyle(1,DRAW_HISTOGRAM,0,4);  //Aqua
   SetIndexBuffer(1,ExtHBuffer2);
   
   SetIndexBuffer(2,ExtMapBuffer1);
   SetIndexBuffer(3,ExtMapBuffer2);

   IndicatorShortName("Market Emotions v2("+SSP+")");
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {

   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
 
  if (CountBars>=Bars) CountBars=Bars;
  
   SetIndexDrawBegin(0,Bars-CountBars+SSP);
   SetIndexDrawBegin(1,Bars-CountBars+SSP);
   
  int i, counted_bars=IndicatorCounted();
  double SsMax, SsMin, smin, smax; 
  
  if(Bars<=SSP+1) return(0);

if(counted_bars<SSP+1)
   {
      for(i=1;i<=SSP;i++) ExtMapBuffer1[CountBars-i]=0.0;
      for(i=1;i<=SSP;i++) ExtMapBuffer2[CountBars-i]=0.0;
   }

for(i=CountBars-SSP;i>=0;i--) { 


  SsMax = High[Highest(NULL,0,MODE_HIGH,SSP,i-SSP+1)]; 
  SsMin = Low[Lowest(NULL,0,MODE_LOW,SSP,i-SSP+1)]; 
  
   smax = SsMax-(SsMax-SsMin)*Kmax/100;
       
   ExtMapBuffer1[i-SSP+6]=smax; 
   ExtMapBuffer2[i-SSP-1]=smax; 

}
   for(int b=CountBars-SSP;b>=0;b--)
   {
      if(ExtMapBuffer1[b]>ExtMapBuffer2[b])
      {
         ExtHBuffer1[b]=1;
         ExtHBuffer2[b]=0;
      }
      else
      {
         ExtHBuffer1[b]=0;
         ExtHBuffer2[b]=1;
      }
      
   }

return(0);
}