//+------------------------------------------------------------------+
//|                                                  AscTrend2_2.mq4 |
//|                                     Copyright © 2006, Nick Bilak |
//|                 03/26/2008 fixed by Igorad for www.forex-tsd.com |
//| 07/11/2010 Black edition by John Last for fxhackers.blogspot.com |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2006, Nick Bilak"

//---- indicator settings
#property  indicator_chart_window
#property  indicator_buffers 2
#property  indicator_color1  LimeGreen
#property  indicator_color2  DarkOrange
#property  indicator_width1  2
#property  indicator_width2  2
//---- indicator parameters
extern int Risk=3;
extern double MONYRISK=1.5;
extern int   periodAMA = 9; //период AMA
extern int       nfast = 2; //период быстрой ЕМА
extern int       nslow = 30; //период медленной ЕМА
extern double    G = 2.0; // степень, в которую возводится сглаживающая консттанта
extern int Input_Price_Customs = 0;  //Выбор цен, по которым производится расчёт индикатора 
//(0-CLOSE, 1-OPEN, 2-HIGH, 3-LOW, 4-MEDIAN, 5-TYPICAL, 6-WEIGHTED, 7-Heiken Ashi Close, 8-SIMPL, 9-TRENDFOLLOW, 10-0.5*TRENDFOLLOW,
//11-Heiken Ashi High, 12-Heiken Ashi Low, 13-Heiken Ashi Open, 14-Heiken Ashi Close.)

//---- indicator buffers
double e1[];
double e2[];
double value9[];
double value10[];
double value4[];
double value5[];
double value6[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- drawing settings
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(0,159);
   SetIndexArrow(1,159);
   
   SetIndexEmptyValue(0,0);
   SetIndexEmptyValue(1,0);
   SetIndexEmptyValue(2,0);
   SetIndexEmptyValue(3,0);
   
   IndicatorBuffers(7);
   SetIndexBuffer(0,e1);
   SetIndexBuffer(1,e2);
   SetIndexBuffer(2,value9);
   SetIndexBuffer(3,value10);
   SetIndexBuffer(4,value4);
   SetIndexBuffer(5,value5);
   SetIndexBuffer(6,value6);
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("AscTrend2("+Risk+","+DoubleToStr(MONYRISK,2)+")");
   SetIndexLabel(0,"UpAscTrend");
   SetIndexLabel(1,"DnAscTrend");
//---- initialization done
   return(0);
   
  }

int start()  
{
   int i,Counter,TrueCount,MRO1,MRO2,MRO3,MRO4;


   int counted_bars=IndicatorCounted();
   if(counted_bars<0) return(-1);
   if(counted_bars>0) counted_bars--;
   int limit=Bars-counted_bars-1;
   int value3=18+3*Risk;
   
   for(i=limit; i>=0; i--) 
   {
	   if(i<Bars-value3-1)
	   {
	   double Range=0;
	   double AvgRange=0;
	   double AvgRange1=0;
         for (Counter=i; Counter<=i+9; Counter++)
	      { 
	      AvgRange+=MathAbs(High[Counter]-Low[Counter]);
	      AvgRange1+=MathAbs(Close[Counter]-Close[Counter+3]);
	      }
	
      if((High[i] - Low[i]) == 0) Range=AvgRange1/10.0;
	   else Range=AvgRange/10.0;
         
      double value19=MONYRISK*Range;
	   int value2=Risk;
	
   
      double value11 = iCustom(Symbol(),Period(),"AMA",periodAMA,nfast,nslow,G,Input_Price_Customs,0,i);
	   double value12 = iCustom(Symbol(),Period(),"AMA",periodAMA,nfast,nslow,G,Input_Price_Customs,0,i+1);
	   double value11_1 = iCustom(Symbol(),Period(),"AMA",periodAMA,nfast,nslow,G,Input_Price_Customs,0,i+1);
	   double value12_1 = iCustom(Symbol(),Period(),"AMA",periodAMA,nfast,nslow,G,Input_Price_Customs,0,i+2);
	   double value13=Range;   
	   // -----
	   //value4_1=UserFunction("JESSD",High[i+1],Low[i+1],High[i+1+value2],Low[i+1+value2],Close[i+1+value2]);
	   double AvgRange_1=(High[i]+Low[i])/2.0;
   	if (Close[i+value2]<AvgRange_1) 
      value4[i]=2*AvgRange_1-Low[i+value2];
	   else 
	   value4[i]=2*AvgRange_1-High[i+value2];
	   // -----
	   MRO1=-1;
	   Counter=i+1;
	   TrueCount=0;
         while (Counter<i+3 && TrueCount<1) 
	      {
		
		if (value4[Counter] > value4[Counter+1] && value4[Counter+1] < value4[Counter+2]) TrueCount=TrueCount+1;
		Counter=Counter+1;
		}
	   
      if (TrueCount>=1) MRO1=Counter-(i+1)-1;
	   // -----
	   MRO2=-1;
	   Counter=i+1;
	   TrueCount=0;
         while (Counter<i+3 && TrueCount<1) 
	      {
		   if (value4[Counter] < value4[Counter+1] && value4[Counter+1] > value4[Counter+2]) TrueCount=TrueCount+1; 
		   Counter=Counter+1;
		   }
   
      if (TrueCount>=1) MRO2=Counter-(i+1)-1;
	
      // -----
	   if (value11_1 < value12_1 && value11 > value12) 
      {
	   //value5=UserFunction("TrueLow",i)-value13;
         if (Close[i+1]<Low[i]) value5[i]=Close[i+1]-value13;
		   else value5[i]=Low[i]-value13;
	   }
	   else
	   {
         if (MRO1>-1 && Low[i+1] > value4[i+1]) value5[i] = value4[i+1] - value13;
	      else
	      value5[i] = value5[i+1];
	   }
	
	   // ----- 
	   if (value11_1 > value12_1 && value11 < value12) 
	   {
	   //value5=UserFunction("TrueHigh",i)+value13;
         if (Close[i+1] > High[i]) value6[i]=Close[i+1]+value13;
		   else value6[i] = High[i]+value13;
	   }
	   else
	   {
         if (MRO2>-1 && High[i+1] < value4[i+1]) value6[i] = value4[i+1] + value13;
	      else
	      value6[i] = value6[i+1];
      }	   
	   // -----
	   if (MathAbs(Open[i]-Close[i+1])>=1.618*value13) 
	   {
         if (value11 > value12) value5[i]=Low[i]-value13;
	      if (value11 < value12) value6[i]=High[i]+value13;
	   }
	   // -----
	   //value7=UserFunction("BS105",Low[i],2.40,value13,value9);
	   if (Low[i]-2.40 * value13 < value9[i+1]) 
	   double value7 = value9[i+1];
	   else 	
	   value7 = Low[i] - 2.40 * value13;
	   // -----
	   //value8=UserFunction("SS105",High[i],2.40,value13,value10);
	   if (High[i] + 2.40*value13 > value10[i+1]) 
	   double value8 = value10[i+1];
	   else 
	   value8 = High[i] + 2.40 * value13;
	   // -----
	   //value9=UserFunction("BS0",Low[i],60,value7,RISK,value19);
	   if(Low[i] - 0.05*value19 - 10*60*Point > value7) value9[i] = value7;
	   else
	   value9[i] = Low[i] - 0.05*value19 - 10*60*Point;
	   // -----
	   //value10=UserFunction("SS0",High[i],60,value8,RISK,value19);
	   if(High[i] + 0.05*value19 + 10*60*Point < value8) value10[i] = value8;
	   else
	   value10[i] = High[i] + 0.05*value19 + 10*60*Point;
	   // -----
	   if (Low[i]-value9[i] > value19) value9[i]=Low[i]-(1.50+0.1*Risk)*value13;
	  	if (value10[i]-High[i] > value19) value10[i]=High[i]+(1.50+0.1*Risk)*value13;
	
	   if (value11>=value12 && value5[i]>=value9[i]) value9[i]=value5[i];
	   if (value11<=value12 && value6[i]<=value10[i]) value10[i]=value6[i];
	   if (value11<=value12 && value5[i]<=value9[i]) value9[i]=value5[i];
	   if (value11>=value12 && value6[i]>=value10[i]) value10[i]=value6[i];
	   // -----
	   MRO3=-1;
	   Counter=i+1;
	   TrueCount=0;
         while (Counter<i+3 && TrueCount<1) 
         {
		   double value11_3 = iCustom(Symbol(),Period(),"AMA",periodAMA,nfast,nslow,G,Input_Price_Customs,0,i);
		   double value12_3 = iCustom(Symbol(),Period(),"AMA",value3,nfast,nslow,G,Input_Price_Customs,0,i);
		   if (value11_3>=value12_3) TrueCount=TrueCount+1;
		   Counter=Counter+1;
		   }
	   if (TrueCount>=1) MRO3=Counter-(i+1)-1;
      // -----
	   MRO4=-1;
	   Counter=i+1;
	   TrueCount=0;
         while (Counter<i+3 && TrueCount<1) 
         {
		   //value11=UserFunction("AverageClose",9,Counter);
		   double value11_4 = iCustom(Symbol(),Period(),"AMA",periodAMA,nfast,nslow,G,Input_Price_Customs,0,i);
		   double value12_4 = iCustom(Symbol(),Period(),"AMA",value3,nfast,nslow,G,Input_Price_Customs,0,i);
		   if (value11_4<=value12_4) TrueCount=TrueCount+1;
		   Counter=Counter+1;
		   }
      if (TrueCount>=1) MRO4=Counter-(i+1)-1;
	   // -----
	   if (MRO3>-1 && value9[i]<=value9[i+1] ) value9[i]=value9[i+1];
	   if (MRO4>-1 && value10[i]>=value10[i+1]) value10[i]=value10[i+1];
	
      if (value9[i]>0 && value9[i]<=High[i] && value11>=value12) e1[i]=value9[i];
      else e1[i] = EMPTY_VALUE;
	   if (value10[i]>0 && value10[i]<100000 && value11<value12 && value10[i]>=Low[i]) e2[i]=value10[i];
	   else e2[i] = EMPTY_VALUE;
   // -----
      }
   }
}