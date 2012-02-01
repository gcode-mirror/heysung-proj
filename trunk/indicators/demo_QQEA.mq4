//+------------------------------------------------------------------+
//|                                                 QQE Alert v3.mq4 |
//|                                                    Skyline, 2007 |
//|                                             www.forexpertutti.it |
//+------------------------------------------------------------------+
#property copyright "Skyline, 2007"
#property link      "www.forexpertutti.it"

#property indicator_chart_window

#property indicator_buffers 2
#property indicator_color1 DodgerBlue
#property indicator_color2 Magenta

extern string Comment1             = "QQEA Alert v3 compiled by Skyline on 31 Oct 2007";
extern string Comment2             = "email : glicci@yahoo.it"; 
//extern bool   ShowCrossQQE_RSISlow = true;
extern int    QQE_SF               = 1;
extern int    QQE_RSI_Period       = 14;
extern double QQE_DARFACTOR        = 4.236; 
extern int    QQE_Width            = 1;
extern double QQE_Position         = 0.5;
extern bool   EnableSoundAlert     = true;
extern bool   EnableVisualAlert    = false;
extern bool   EnableEmailAlert     = true;

double CrossUp[];
double CrossDown[];

static datetime alertTag = D'1980.01.01'; 
static datetime soundTag = D'1980.01.01';
static datetime emailTag = D'1980.01.01';

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
    SetIndexStyle(0, DRAW_ARROW, EMPTY,QQE_Width);
    SetIndexArrow(0, 241);
    SetIndexBuffer(0, CrossUp);
    SetIndexStyle(1, DRAW_ARROW, EMPTY,QQE_Width);
    SetIndexArrow(1, 242);
    SetIndexBuffer(1, CrossDown);   
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
   int limit, i, counter;
   //double fasterEMAnow, slowerEMAnow, fasterEMAprevious, slowerEMAprevious, fasterEMAafter, slowerEMAafter;
   double fasterRSInow,slowerRSInow,fasterRSIprevious,slowerRSIprevious,fasterRSIafter,slowerRSIafter;
   double Range, AvgRange;
   
   
   i=0;
      
      fasterRSInow      = iCustom(NULL,0,"QQEA",QQE_SF,QQE_RSI_Period,QQE_DARFACTOR,0,i);
      fasterRSIprevious = iCustom(NULL,0,"QQEA",QQE_SF,QQE_RSI_Period,QQE_DARFACTOR,0,i+1); 
      fasterRSIafter    = iCustom(NULL,0,"QQEA",QQE_SF,QQE_RSI_Period,QQE_DARFACTOR,0,i-1); 
      Print(" fasterRSInow is ",fasterRSInow);
      Print(" fasterRSIprevious ",fasterRSIprevious);
      Print(" fasterRSIafter is ",fasterRSIafter);
    

      if ((fasterRSInow > slowerRSInow) && (fasterRSIprevious < slowerRSIprevious) && (fasterRSIafter > slowerRSIafter)) 
      {
         CrossUp[i] = Low[i] - Range*QQE_Position;
      }
      else 
      if ((fasterRSInow < slowerRSInow) && (fasterRSIprevious > slowerRSIprevious) && (fasterRSIafter < slowerRSIafter)) 
      {
          CrossDown[i] = High[i] + Range*QQE_Position;
      }
      
  
   return(0);
}

