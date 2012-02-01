
//+------------------------------------------------------------------+
//|                                                     TZ-Pivot.mq4 |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright Shimodax"
#property link      "http://www.strategybuilderfx.com"

/*--------------------------------------------------------------------

SDX-TzPivots_v5:

Shimodax has created a wonderful pivots indicator.  Much is added in
the way of cosmetics and flexibility.  Only the SweetSpots pivots are
removed (a separate SDX indicator exists for them).  The core time 
coding by Shimodax remains unchanged.

Some revision highlights:
                                               
1) When full screen lines are shown, mid-screen label placement is now
   automatic when zooming in and out on the charts.
   
2) For a neater, cleaner chart appearance, the pivot lines are now 
   background to other charting items. 
   
3) The ZoomAdjust feature helps keep labels properly and proportionally
   positioned when changing font size, style and the 'zoom' status
   on charts, or when adding prices to the labels.                                                     

4) For the Period Separator labels, you can now show either a simple 
   "Yesterday" and "Today", or a detailed display showing the actual
   name of the Day and the timezone shift from GMT selected by the user.  
                                           
5) Added a third line placement choice that keeps the main pivot lines 
   to the right of the current candle for a really clean looking chart.
   
6) Added and a third label placement choice that keeps labels to the 
   right of the current candle, and which can be used with all line
   placement choices.  For esthetics, certain labels can still be 
   moved to the left.     


----------------------------------------------------------------------
Introduction - Time Zone Inputs:

   "Local" input:    
   This is your software server's local timezone expressed in relation
   to GMT.  For example, the MetaQuotes MT4 servers (live and demo) 
   reside at a location 2 hours ahead of GMT, hence GMT+2, and so the
   input here is "+2" (or just "2" for a positive relationship).  If,
   for example, your software server is in London, England which is 
   normally GMT+0, and is GMT+1 during Daylight Savings Time (DST), 
   you would normally enter "0", but change it to "1" during DST.
    
                  
   "Destination" input:
   This is the timezone (again, expressed in relation to GMT) you need
   to select to get the 24 hour session desired from which to calculate
   the pivot levels.  For example, using the MetaQuotes MT4 servers
   timezone of "2" here also, specifies a 24 hours session as starting
   at midnight in that timezone and proceeding to the following midnight.
   Since that timezone is 7 hours ahead of EST (New York, USA) the
   24 hours session is the same as 5PM to 5PM EST!  By using "0"
   (or "1" during DST) you are specifying London, England midnight to
   midnight time, which is what the European session is based upon.
   
   Another example:
   If your software server is located in the Eastern Standard Time zone 
   (GMT-5) and want the pivot levels to be based upon the London trading
   session, then enter "-5" for the "Local" timezone, and enter "0" for 
   the "Destination" timezone ("1" during DST/London in summer is GMT+1).

   Final note:
   Please understand that the "Local" timezone setting depends on the 
   time displayed on your MetaTrader charts.  MetaQuotes servers are 
   located at CDT (GMT+2) (or possibly CET (GMT+1)), no matter what the 
   clock on your wall says.  To get normal, non-time shifted pivot
   calculations, simply use "0" for both the "Local" and the 
   "Destination" timezone inputs. 
            
            
----------------------------------------------------------------------
Comments regarding some of the many Indicator Window inputs:

Indicator_On?:
   Use "true" to turn this indicator "ON", and "false" to turn "OFF".
   This way you do not have to delete the indicator from the chart's
   list of indicators when you do not want it displayed.
                              
Local__HrsServerTZFromGMT:
   Enter the number of hours difference between GMT and the time zone
   your platform server is in.  MT4 servers are GMT +2 hrs.  Use "0"
   to get normal, non-time shifted pivot calculations.
     
Destination__HrsNewTzfromGMT:
   Enter the number of hours difference between GMT and the timezone
   selected as the basis for pivots calculations.  For example, if you
   wish to have the day start at NY time, then enter "-5".  If you wish 
   to have the day start at Zurich time, then enter "1".  Use "0" for
   normal, non-time shifted pivot calculations. 

Show_1Daily_2FibonacciPivots:
   Either formula can be used to produce the pivot lines.
   
Enter_line_placement_number:
   Using "1" will produce pivot lines across the full screen.  Using
   "2" will start the pivot lines at the day demarcation lines.  In 
   time, on the lowest timeframe charts, the lines will progress across
   the full screen.  Using "3" will start and keep the lines right of 
   the current candle. 
      
Margin_labels_for_fullscreen:
   "true" displays prices in the right margin for full screen lines.
   "false" does not display prices in the right margin for full
   screen lines.
     
Include_price_in_line_labels:
   The pivot line labels have IDs, but selecting "true" will add the
   price anytime you have these labels on the chart.      

Slide_labels_LR_DecrIncr:
   Increase number to move line labels to the right on the chart.
   Decrease number to move line labels to the left on the chart.
   This feature is enabled only for full screen lines, either as
   originally selected, or once lines become full screen on the
   lowest timeframes over time (i. e.,the Relabeler code has
   taken over and is producing full screen lines).
     
ZoomAdjust_3_6_15_30_50:
   This function is enabled only in the absense of full screen lines
   and when labels have not been selected to remain fixed near the
   right boundary of the chart.  Other 'move label' functions exist
   for those conditions. For the line labels displayed to the left of 
   the current Period Separator, keeping neat spacing from that
   Separator line is difficult as some things "upset the apple cart".  
   Adding prices to the labels can necessitate label shifting.  Zooming
   the chart in or out can necessitate label shifting.  Even increasing 
   or decreasing the font size, or changing the font style could 
   necessitate label shifting for esthetics.  And this group of labels 
   needs to be shifted independent from the labels to the right of the
   Separator line which are not affectd by these things.  ZoomAdjust
   allows the user to input a number to move those labels to a neater
   location, relative to the Separator line, once the chart zoom is
   made, the selection of whether or not prices are included is made, 
   and the choices of font size and style are made.  The numbers in
   "ZoomAdjust_3_6_15_30_50" are there only to suggest the range that 
   may be necessary.  If prices are included, if a large font is used,
   and if the "3" style is selected, you may need to input a larger 
   number to move the labels far enough away from the Separator to 
   keep the labels from overlapping it.  An even larger number may be 
   required if you then zoom out on the chart.  You will have to
   experiment with this feature to get the hang of it.  You can 
   simply ignore it, but if you set up a chart that will be around 
   a while, and you want things nice on it, this tool is useful.
   
Fix_labels_near_right_boundary:
   "true" fixes the pivot lines to the right of the current candle
   regardless of the line placement selection.  "false" turns this 
   tool off so that it does not interfere with the normal label
   placements that go with the various line placements.  So, in a 
   sense, this is a 'label placement' override mode that keeps the
   labels to the right of the most recent candle.  In this mode
   however, for esthetics, some labels can still be moved to the 
   left per the inputs immediately following.
   
__Move_yHigh_yLow_labels_left:
   Increasing this number moves this label further to the left.
   
__Move_Open_label_left:
   Increasing this number moves this label further to the left.
  
__Move_Camarilla_labels_left:
   Increasing this number moves this label further to the left.        
                      
Color Choices for lines and labels:
   Enter the colors of your choice.
   
LabelStyle_Norm_Bold_Black_123:
   Entry of "1" produces Arial.  Entry of "2" produces Arial Bold.  
   And an entry of "3" produces Arial Black font style.    
     
LineStyle_01234:
   Your number entry selects the line style for the lines.  
   0=solid, 1=dash, 2=dashdot, 3=dashdot, and 4=dashdotdot.
   
LabelFontSize:
   Enter number for size of font desired (usually 8 - 11).   
     
SolidLineThickness:
   Your number entry selects the width of solid lines.  0 and 
   1 = single width and 2, 3, 4 graduate the thickness.  Coding 
   assures that no matter what number this is set at, non-solid 
   line styles selected will still display without having to change 
   this entry back to 0, or 1.   
          
ShowPeriodSeparatorLines:
   The choice of "true" will place a pair of vertical lines on the 
   chart showing the start and stop of the new "Destination" 24 hour 
   period you have selected for pivot calculations.  Choosing "false" 
   cancels display of these lines and their labels.
     
PlaceAt_TopBot_12_OfChart:
   "1" will place the Period Separator labels "Yesterday" and "Today" 
   at the top of the screen.  "2" will place them at the bottom.  The 
   charts are less congested.  If the screen is enlarged, downsized, 
   or scrolled, these labels will move.  But the next data tick will
   restore their position.
     
Relabeler_Adjustment:
   This number is used in the FullScreenLinesMarginPrices = "false"  
   mode to trigger when the relabeler puts labels on the screen. It 
   works under the assumption that the Today Period Separator is soon 
   to go off-screen, taking the labels with it.  The ideal number 
   would trigger the relabeler when the first labels are about to 
   move off the left of the chart.  Lowering the number triggers 
   sooner and raising it delays triggering.  The number is the number 
   of candles between the Today Separator and the chart left border.
   For example, a value of "10" will trigger the relabeler when the 
   Today Period Separator is 10 candles from the chart left border.  
   A value of "0" triggers when the Today Period Separator hits the 
   left border.  This feature allows for fine tuning charts of 
   different scales and timeframes.  In most cases either of the example 
   values is sufficient.  If the chart timeframe and scale is such that 
   full sessions are displayed without the Today Separator ever 
   disappearing, then relabeling and this adjustment to it, will not be
   required.  It only comes into play when the scale is such that the 
   Today Period Separator will move off the left of the screen, taking 
   the labels with it, before the next session Separators can come 
   on-screen.  Scaling down to make larger candles causes more 
   timeframes to need this feature. The coding takes this into account 
   and use of this adjustment is really only for fine tuning whenever 
   the user desires to do so.
     
Show_Relabeler_Comment: 
   If "true" then Relabeler related data appears in chart upper left. 
   It serves to help a new user better understand the Relabeler.
          
Show_Data_Comment:
   If "true" then key prior/current day pip data appears in the  
   upper left area of the chart.
                                                                                                                                                                                                                                            
---------------------------------------------------------------------*/


#property indicator_chart_window

#property indicator_buffers    1
#property indicator_color1     CLR_NONE


extern bool   Indicator_On?                  = true;

extern int    HrsServerTzFromGMT             = 3;    //Data collection Tz of your server
extern int    HrsChoiceTZfromGMT             = 1;    //New destination Tz governing data
extern int    Show_1Daily_2FibonacciPivots   = 1;

extern string Pivot_Lines_Placement________  = "Start with fullscreen lines, enter '1'";
extern string __                             = "Start lines at Day Separator, enter '2'";
extern string ___                            = "Start lines at current candle, enter '3'";
extern int    Enter_line_placement_number    = 2;

extern string Label_items_________________   = "";
extern bool   Margin_labels_for_fullscreen   = false;
extern bool   Include_price_in_line_labels   = true;
extern int    Slide_labels_LR_DecrIncr       = 0;     //-# to move left, +# to move right
extern int    ZoomAdjust_3_6_15_30_50        = 10;    //for 8,9 fontsize: 2, 5, 10, 20, 40
extern bool   Fix_labels_near_right_boundary = true;
extern int    __Move_yHigh_yLow_labels_left  = -1;
extern int    __Move_Open_label_left         = 0;
extern int    __Move_Camarilla_labels_left   = 0;
extern color  LabelsColor                    = Gray;
extern int    LabelsFontSize                 = 8;
extern int    LabelsStyle_NormBoldBlack_123  = 2;

extern string Pivot_Lines_Parameters_______  = "";
extern color  R_Color                        = Maroon;
extern int    R_LineStyle_01234              = 2;
extern int    R_SolidLineThickness           = 1; 
extern color  CentralPivotColor              = C'3,78,209';  //RoyalBlue
extern int    CentralPivotLineStyle_01234    = 0;
extern int    CentralPivotSolidLineThickness = 1; 
extern color  S_Color                        = DarkGreen;  //C'43,170,43';
extern int    S_LineStyle_01234              = 2;
extern int    S_SolidLineThickness           = 1; 
extern color  MidPivotsColor                 = C'85,85,0'; //C'53,53,53';  //C'85,85,0';
extern int    MidPivotsLineStyle_01234       = 2;
extern int    MidPivotsLineThickness         = 1; 
extern bool   ShowMidPivots                  = true;
extern color  QtrPivotsColor                 = DarkSlateBlue;  // C'128,0,255'
extern int    QtrPivotsLineStyle_01234       = 2;
extern int    QtrPivotsLineThickness         = 1; 
extern bool   ShowQtrPivots                  = true;
extern color  YesterdayHighLowColor          = C'1,149,175';
extern int    HighLowLineStyle_01234         = 0;
extern int    HighLowSolidLineThickness      = 1; 
extern bool   ShowYesterdayHighLow           = true;
extern color  TodayOpenColor                 = C'164,0,164';  //C'179,66,206';
extern int    TodayOpenLineStyle_01234       = 0;
extern int    TodayOpenSolidLineThickness    = 1; 
extern bool   ShowTodayOpen                  = true;
extern color  CamarillaColor                 = MediumTurquoise;
extern int    CamarillaLineStyle_01234       = 2;
extern int    CamarillaSolidLineThickness    = 1; 
extern bool   ShowCamarilla                  = false;

extern string Period_Separators____________  = "";
extern color  PeriodSeparatorLinesColor      = C'85,85,0';  //C'55,55,0'; //C'85,85,0';
extern int    SeparatorLinesStyle_01234      = 2;
extern int    SeparatorLinesThickness        = 1;
extern bool   ShowPeriodSeparatorLines       = false;
extern color  PeriodSeparatorsLabelsColor    = C'85,85,0';  //C'74,74,0';  //Black;
extern int    SeparatorLabelFontSize         = 8;
extern int    S_Label_Norm_Bold_Black_123    = 2;
extern int    PlaceAt_TopBot_12_OfChart      = 2;
extern int    Label_Simple_or_Detailed_12    = 1;
extern bool   ShowPeriodSeparatorLabels      = false;

extern string Miscellaneous_______________   = "";
extern int    Relabeler_Adjustment           = 10;       //-# to advance trigger, +# to delay trigger
extern bool   Show_Relabeler_Comment         = false;
extern bool   Show_Data_Comment              = false;

int MoveLabels, MoveLabels2;
int A,B; //relabeler triggers
int digits; //decimal digits for symbol's price 
string Yesterday, Today;
//int TradingHoursFrom= 0;
//int TradingHoursTo= 24;     

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
{
	if (Ask>10) digits=2; else digits=4;
   Print("Period= ", Period()); 
   return(0);
}

//+------------------------------------------------------------------+
//| Custom indicator de-initialization function                      |
//+------------------------------------------------------------------+
int deinit()
{
   int obj_total= ObjectsTotal(); 
   for (int i= obj_total; i>=0; i--)
      {
      string name= ObjectName(i);   
      if (StringSubstr(name,0,7)=="[PIVOT]")  ObjectDelete(name);
      }    
   Comment(" ");
   return(0);
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
{
   if (Indicator_On? == false) {deinit();return(0);}
   
   MoveLabels = (WindowFirstVisibleBar()/2)- Slide_labels_LR_DecrIncr;
   MoveLabels2=  MoveLabels+ZoomAdjust_3_6_15_30_50;
   
   static datetime timelastupdate= 0;
   static datetime lasttimeframe= 0;  
   datetime startofday= 0,
            startofyesterday= 0,
            startline= 0,
            startlabel= 0;
   double today_high= 0,
            today_low= 0,
            today_open= 0,
            yesterday_high= 0,
            yesterday_open= 0,
            yesterday_low= 0,
            yesterday_close= 0;
   int idxfirstbartoday= 0,
       idxfirstbaryesterday= 0,
       idxlastbaryesterday= 0;  
    
   //if (CurTime()-timelastupdate<60 && Period()==lasttimeframe)  return (0); //no need to update too often     
   lasttimeframe= Period();
   timelastupdate= CurTime();   

   //---- exit if period is greater than daily charts--------------------------------------------------
   if(Period() > 1440){return(-1);}
   //if(Period() > 1440) {Alert("TzPivots Error - Chart TF > 1 day.");return(-1);} // then exit  
 
   //-----let's find out which hour bars make today and yesterday--------------------------------------
   ComputeDayIndices(HrsServerTzFromGMT,HrsChoiceTZfromGMT,
           idxfirstbartoday, idxfirstbaryesterday, idxlastbaryesterday);
   startofday= Time[idxfirstbartoday];  // datetime (x-value) for labes on horizontal bars
   startofyesterday= Time[idxfirstbaryesterday];  // datetime (x-value) for labels on horizontal bars

   //-----walk forward through yestday's start and collect high/lows within the same day-------------------
   yesterday_high= -99999;  // not high enough to remain alltime high
   yesterday_low=  +99999;  // not low enough to remain alltime low   
   for (int idxbar= idxfirstbaryesterday; idxbar>=idxlastbaryesterday; idxbar--)
          {
          if (yesterday_open==0)  // grab first value for open
          yesterday_open= Open[idxbar];                           
          yesterday_high= MathMax(High[idxbar], yesterday_high);
          yesterday_low= MathMin(Low[idxbar], yesterday_low);      
          // overwrite close in loop until we leave with the last iteration's value
          yesterday_close= Close[idxbar];
          }
 
   //------walk forward through today and collect high/lows within the same day------------------------------
   today_open= Open[idxfirstbartoday];  // should be open of today start trading hour
   today_high= -99999; // not high enough to remain alltime high
   today_low=  +99999; // not low enough to remain alltime low
   for (int j= idxfirstbartoday; j>=0; j--) 
      {
      today_high= MathMax(today_high, High[j]);
      today_low= MathMin(today_low, Low[j]);
      }       

   //----relabeler code--------------------------------------------------------------------------------------
   A=0; B=0; //reset:  relabeler off, margin labels off
   if (Enter_line_placement_number==1 && Margin_labels_for_fullscreen == true)  {B = 1;} //B=1 asserts margin labels
   if (Enter_line_placement_number != 1)
      {
      int AA = WindowFirstVisibleBar();  //# of visible bars on chart
      int BB = ((Time[0]-Time[idxfirstbartoday])/(Period()*60)); //# of bars btwn current time and Today Separator
      int RR = (AA - BB); //# number of bars btwn Today Separator and chart left margin
      int AL = Relabeler_Adjustment; //default of zero activates relabeler as Today Separator goes off-screen
      if (RR >  AL){A = 0;} //labels not near enough to chart left margin to trigger relabeler
      if (RR <= AL){A = 1;if(Margin_labels_for_fullscreen == true)B = 1;} //labels close enough - switch to full-screen 
      }
       
   //----Autolabeler test comment
   string test = "A = "+A+",  ";  
   test = test + "Current time to Separator = "+BB+" candles.";
   test = test + "   Separator to Chart left = "+RR+" candles.";
   test = test + "   Total candles visable = "+AA+" candles.";   
   test = test + "   Relabeler is set to trigger when Separator is  "+AL+"  candles from chart left.";
   if(Show_Relabeler_Comment ==true){Comment(test);}else {Comment (" ");}
   
   //----clear all objects before redrawing screen
      int obj_total= ObjectsTotal(); 
      for (int k= obj_total; k>=0; k--)
         {
         string name= ObjectName(k);   
         if (StringSubstr(name,0,7)=="[PIVOT]")  ObjectDelete(name);
         }    

   //------draw the vertical bars/labels that mark the session spans------------------------------------------
   if(ShowPeriodSeparatorLines == true)
      {
      int DZ = HrsChoiceTZfromGMT;
      string GMT = "(GMT +0)  ";
      if(DZ>0 &&  DZ<10) {GMT = "(GMT +"+ HrsChoiceTZfromGMT +")  ";}
      if(DZ>9) {GMT = "(GMT +"+ HrsChoiceTZfromGMT +")";}
      if(DZ<0 &&  DZ>-10) {GMT = "(GMT +"+ HrsChoiceTZfromGMT +")  ";}
      if(DZ<-9) GMT = "(GMT "+ HrsChoiceTZfromGMT +")";
      if(SeparatorLinesStyle_01234>0) {SeparatorLinesThickness=1;}
      double top = WindowPriceMax();
   	double bottom = WindowPriceMin();
   	double scale = top - bottom;	
   	double YadjustTop = scale/5000; //250;
   	double YadjustBot = scale/(350/SeparatorLabelFontSize); 	
      double level = top - YadjustTop; if (PlaceAt_TopBot_12_OfChart==2){level = bottom + YadjustBot;}
      if (Label_Simple_or_Detailed_12 == 2)
         {
         SetTimeLine("YesterdayStart", Yesterday + GMT, idxfirstbaryesterday+0,  PeriodSeparatorsLabelsColor,level);
         SetTimeLine("YesterdayEnd", Today + GMT, idxfirstbartoday+0,  PeriodSeparatorsLabelsColor,level); 
         }
      else
         {
         SetTimeLine("YesterdayStart", Yesterday, idxfirstbaryesterday+0,  PeriodSeparatorsLabelsColor,level);
         SetTimeLine("YesterdayEnd", Today, idxfirstbartoday+0,  PeriodSeparatorsLabelsColor,level); 
         }      
      }
    
   //---- Calculate Pivot Levels ------------------------------------------------------------------------------- 
   double p, q, d, r1,r2,r3,r4,r5, s1,s2,s3,s4,s5;   
   d = (today_high - today_low);
   q = (yesterday_high - yesterday_low);
   p = (yesterday_high + yesterday_low + yesterday_close) / 3;  
   if(Show_1Daily_2FibonacciPivots == 1) 
   {
   r1 = (2*p)-yesterday_low;
   r2 = p+(yesterday_high - yesterday_low);  //r2 = p-s1+r1;
   r3 = (2*p)+(yesterday_high-(2*yesterday_low));
   s1 = (2*p)-yesterday_high;
   s2 = p-(yesterday_high - yesterday_low);  //s2 = p-r1+s1;
   s3 = (2*p)-((2* yesterday_high)-yesterday_low);
   }
   if(Show_1Daily_2FibonacciPivots == 2)
   {
   r1 = p+ (q * 0.382);   
   r2 = p+ (q * 0.618);  
 	r3 = p+q;  
   r4 = p+ (q * 1.618);
   r5 = p+ (q * 2.618);
   s2 = p- (q * 0.618);   
   s1 = p- (q * 0.382); 
  	s3 = p-q; 
   s4 = p- (q * 1.618);
   s5 = p- (q * 2.618);
   }
   string space = ""; if(Fix_labels_near_right_boundary == true){space = "                     ";}
   if(Enter_line_placement_number!=1 && A==0) //lines start at separators & not yet fullscreen, no margin labels in this mode (B=0)
       {
       startlabel= Time[idxfirstbartoday];  
       startline = Time[idxfirstbartoday+1];  //was "+1", "+0" stops line at Separator
       if (Time[0] > Time[idxfirstbartoday]){startline = Time[idxfirstbartoday];}
       }
   if(Enter_line_placement_number!=1 &&A ==1) //lines started at separators, but switched to full screen, B=1 asserts margin labels
       {
       startlabel= Time[MoveLabels];
       startline = WindowFirstVisibleBar();
       }      
   if(Enter_line_placement_number==1) //lines selected to be full screen, margin labels governed by value of B in relabeler code
       {
       startlabel=Time[MoveLabels];    
       startline = WindowFirstVisibleBar();
       } 
       
   if (Fix_labels_near_right_boundary){startlabel = Time[1];} 
     
   if(R_LineStyle_01234>0){R_SolidLineThickness=0;} 
   if(S_LineStyle_01234>0){S_SolidLineThickness=0;} 
   SetLevel(space+"     R5 ", r5, R_Color, R_LineStyle_01234, R_SolidLineThickness, startline,startlabel, B);  
   SetLevel(space+"     R4 ", r4, R_Color, R_LineStyle_01234, R_SolidLineThickness, startline,startlabel, B);
   SetLevel(space+"     R3 ", r3, R_Color, R_LineStyle_01234, R_SolidLineThickness, startline,startlabel, B);   
   SetLevel(space+"     R2 ", r2, R_Color, R_LineStyle_01234, R_SolidLineThickness, startline,startlabel, B); 
   SetLevel(space+"     R1 ", r1, R_Color, R_LineStyle_01234, R_SolidLineThickness, startline,startlabel, B); 
   if(Show_1Daily_2FibonacciPivots == 1){     
   SetLevel(space+"   DPV ", p, CentralPivotColor, CentralPivotLineStyle_01234 ,
               CentralPivotSolidLineThickness, startline,startlabel, B);}
   if(Show_1Daily_2FibonacciPivots == 2){  
   SetLevel(space+"   FPV ", p, CentralPivotColor, CentralPivotLineStyle_01234 ,
               CentralPivotSolidLineThickness, startline,startlabel, B);}    
   SetLevel(space+"     S1 ", s1, S_Color, S_LineStyle_01234, S_SolidLineThickness, startline,startlabel, B);
   SetLevel(space+"     S2 ", s2, S_Color, S_LineStyle_01234, S_SolidLineThickness, startline,startlabel, B);
   SetLevel(space+"     S3 ", s3, S_Color, S_LineStyle_01234, S_SolidLineThickness, startline,startlabel, B);    
   SetLevel(space+"     S4 ", s4, S_Color, S_LineStyle_01234, S_SolidLineThickness, startline,startlabel, B);
   SetLevel(space+"     S5 ", s5, S_Color, S_LineStyle_01234, S_SolidLineThickness, startline,startlabel, B);
   
   //------ Midpoints Pivots (mid-levels between pivots)
   if (ShowMidPivots==true) 
      {
      if(Enter_line_placement_number!=1 && A==0)
         {
         startlabel= Time[idxfirstbartoday];
         startline = Time[idxfirstbartoday+1];  //was "+1", "+0" stops line at Separator
         if (Time[0] > Time[idxfirstbartoday]){startline = Time[idxfirstbartoday];}
         }
      if(Enter_line_placement_number!=1 && A==1)
         {
         startlabel= Time[MoveLabels]; 
         startline = WindowFirstVisibleBar();
         } 
      if(Enter_line_placement_number==1)
         {
         startlabel= Time[MoveLabels];     
         startline = WindowFirstVisibleBar();
         }
      if (Fix_labels_near_right_boundary){startlabel = Time[1];}
                    
      if(MidPivotsLineStyle_01234>0){MidPivotsLineThickness=0;}
      SetLevel(space+"   mR5", (r4+r5)/2, MidPivotsColor, MidPivotsLineStyle_01234, MidPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"   mR4", (r3+r4)/2, MidPivotsColor, MidPivotsLineStyle_01234, MidPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"   mR3", (r2+r3)/2, MidPivotsColor, MidPivotsLineStyle_01234, MidPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"   mR2", (r1+r2)/2, MidPivotsColor, MidPivotsLineStyle_01234, MidPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"   mR1", (p+r1)/2,  MidPivotsColor, MidPivotsLineStyle_01234, MidPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"   mS1", (p+s1)/2,  MidPivotsColor, MidPivotsLineStyle_01234, MidPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"   mS2", (s1+s2)/2, MidPivotsColor, MidPivotsLineStyle_01234, MidPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"   mS3", (s2+s3)/2, MidPivotsColor, MidPivotsLineStyle_01234, MidPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"   mS4", (s3+s4)/2, MidPivotsColor, MidPivotsLineStyle_01234, MidPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"   mS5", (s4+s5)/2, MidPivotsColor, MidPivotsLineStyle_01234, MidPivotsLineThickness, startline,startlabel, B);
      }

   //------ Quarterpoint Pivots (qtr-levels between pivots)
   if (ShowQtrPivots==true) 
      {
      if(Enter_line_placement_number!=1 && A==0)
         {
         startlabel= Time[idxfirstbartoday]; 
         startline = Time[idxfirstbartoday+1];  //was "+1", "+0" stops line at Separator
         if (Time[0] > Time[idxfirstbartoday]){startline = Time[idxfirstbartoday];}
         }
      if(Enter_line_placement_number!=1 && A==1)
         {
         startlabel= Time[MoveLabels];
         startline = WindowFirstVisibleBar();
         } 
      if(Enter_line_placement_number==1)
         {
         startlabel=Time[MoveLabels];     
         startline = WindowFirstVisibleBar();
         }
      if (Fix_labels_near_right_boundary){startlabel = Time[1];}
                   
      if(QtrPivotsLineStyle_01234>0){QtrPivotsLineThickness=0;} 
      SetLevel(space+"  q3R5", r4+((r5-r4)/4)*3, QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q1R5", r4+(r5-r4)/4,     QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q3R4", r3+((r4-r3)/4)*3, QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q1R4", r3+(r4-r3)/4,     QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q3R3", r2+((r3-r2)/4)*3, QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q1R3", r2+(r3-r2)/4,     QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q3R2", r1+((r2-r1)/4)*3, QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q1R2", r1+(r2-r1)/4,     QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q3R1", p+((r1-p)/4)*3,   QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q1R1", p+(r1-p)/4,       QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);     
      SetLevel(space+"  q1S1", p-(p-s1)/4,       QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q3S1", p-((p-s1)/4)*3,   QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);     
      SetLevel(space+"  q1S2", s1-(s1-s2)/4,     QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q3S2", s1-((s1-s2)/4)*3, QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B); 
      SetLevel(space+"  q1S3", s2-(s2-s3)/4,     QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q3S3", s2-((s2-s3)/4)*3, QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);     
      SetLevel(space+"  q1S4", s3-(s3-s4)/4,     QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q3S4", s3-((s3-s4)/4)*3, QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B); 
      SetLevel(space+"  q1S5", s4-(s4-s5)/4,     QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B);
      SetLevel(space+"  q3S5", s4-((s4-s5)/4)*3, QtrPivotsColor, QtrPivotsLineStyle_01234, QtrPivotsLineThickness, startline,startlabel, B); 
      }

   //---- Yesterday High/Low
   if (ShowYesterdayHighLow == true)
      {
      if(Enter_line_placement_number!=1 && A==0)
         {
         startlabel= Time[idxfirstbartoday+1+ZoomAdjust_3_6_15_30_50 ]; 
         startline = Time[idxfirstbaryesterday+1];  //was "+1", "+0" stops line at Separator
         if (Time[0] > Time[idxfirstbartoday]){startline = Time[idxfirstbaryesterday];}
         }
      if(Enter_line_placement_number!=1 &&A ==1)
         {
         startlabel= Time[MoveLabels2];
         startline = WindowFirstVisibleBar(); 
         } 
      if(Enter_line_placement_number==1)
         {
        startlabel=Time[MoveLabels2];     
        startline = WindowFirstVisibleBar();
         }
         
      if (Fix_labels_near_right_boundary){startlabel = Time[__Move_yHigh_yLow_labels_left];} 
      if (__Move_yHigh_yLow_labels_left < 0) {startlabel= Time[idxfirstbaryesterday+1];} 
      if (idxfirstbaryesterday+1 > WindowFirstVisibleBar()) {startlabel= Time[WindowFirstVisibleBar()];}
    //if (idxfirstbarofyesterday+1 > WindowFirstVisibleBar()) {startlabel= Time[idxfirstbaroftoday+10];}
           
      if(HighLowLineStyle_01234>0){HighLowSolidLineThickness=0;}
      SetLevel(space+"      y HIGH",yesterday_high,YesterdayHighLowColor,HighLowLineStyle_01234,
                   HighLowSolidLineThickness,startline,startlabel,B);      
      SetLevel(space+"       y LOW",yesterday_low,YesterdayHighLowColor,HighLowLineStyle_01234,
                   HighLowSolidLineThickness,startline,startlabel,B);
      }

   //---- Today Open
   if (ShowTodayOpen == true)
      {
      if(Enter_line_placement_number!=1 &&A ==0)
         {
         startlabel= Time[idxfirstbartoday+1+ZoomAdjust_3_6_15_30_50]; 
         //startline = Time[idxfirstbaroftoday+1+ZoomAdjust_3_6_15_30_50];  //was "+1", "+0" stops line at Separator
         startline = Time[idxfirstbartoday+1];  //was "+1", "+0" stops line at Separator
         if (Time[0] > Time[idxfirstbartoday]){startline = Time[idxfirstbartoday];}
         }
      if(Enter_line_placement_number!=1 &&A ==1)
         {
         startlabel= Time[MoveLabels2];
         startline = WindowFirstVisibleBar();
         } 
      if(Enter_line_placement_number==1)
         {
         startlabel=Time[MoveLabels2];     
         startline = WindowFirstVisibleBar();
         }
         
      if (Fix_labels_near_right_boundary){startlabel = Time[__Move_Open_label_left];}   
           
      if(TodayOpenLineStyle_01234>0){TodayOpenSolidLineThickness=0;} 
      SetLevel(space+"  OPEN",today_open,TodayOpenColor,TodayOpenLineStyle_01234,
                   TodayOpenSolidLineThickness,startline,startlabel, B);
      }

   //----- Camarilla Lines
   if (ShowCamarilla==true) 
      {
      if(Enter_line_placement_number!=1 &&A ==0)
         {
         startlabel= Time[idxfirstbartoday+1+ZoomAdjust_3_6_15_30_50];
         startline = Time[idxfirstbartoday+1];  //was "+1", "+0" stops line at Separator
         if (Time[0] > Time[idxfirstbartoday]){startline = Time[idxfirstbartoday];}
         }
      if(Enter_line_placement_number!=1 &&A ==1)
         {
         startlabel= Time[MoveLabels2];
         startline = WindowFirstVisibleBar();
         }   
      if(Enter_line_placement_number==1)
         {
         startlabel=Time[MoveLabels2];     
         startline = WindowFirstVisibleBar();
         } 
      
      if (Fix_labels_near_right_boundary){startlabel = Time[__Move_Camarilla_labels_left];}    
         
      if(CamarillaLineStyle_01234>0){CamarillaSolidLineThickness=0;}
      double cr2, cr1, cs1,cs2;
	   cr2 = (q*0.55)+yesterday_close;
	   cr1 = (q*0.27)+yesterday_close;
	   cs1 = yesterday_close-(q*0.27);	
	   cs2 = yesterday_close-(q*0.55);		   
      SetLevel(space+"  cr1", cr1, CamarillaColor, CamarillaLineStyle_01234, CamarillaSolidLineThickness, startline, startlabel, B);
      SetLevel(space+"  cr2", cr2, CamarillaColor, CamarillaLineStyle_01234, CamarillaSolidLineThickness, startline, startlabel, B);
      SetLevel(space+"  cs1", cs1, CamarillaColor, CamarillaLineStyle_01234, CamarillaSolidLineThickness, startline, startlabel, B);
      SetLevel(space+"  cs2", cs2, CamarillaColor, CamarillaLineStyle_01234, CamarillaSolidLineThickness, startline, startlabel, B);
      }

   //------ Comment for upper left corner
   if (Show_Data_Comment) {
      string comment= "  ";      
      comment= comment + "-- Good luck with your trading! ---\n";
      comment= comment + "Range: Yesterday "+DoubleToStr(MathRound(q/Point),0) 
                       +" pips, Today "+DoubleToStr(MathRound(d/Point),0)+" pips" + "\n";
      comment= comment + "Highs: Yesterday "+DoubleToStr(yesterday_high,Digits)  
                       +", Today "+DoubleToStr(today_high,Digits) +"\n";
      comment= comment + "Lows:  Yesterday "+DoubleToStr(yesterday_low,Digits)  
                       +", Today "+DoubleToStr(today_low,Digits)  +"\n";
      comment= comment + "Close: Yesterday "+DoubleToStr(yesterday_close,Digits) + "\n";
   // comment= comment + "Pivot: " + DoubleToStr(p,Digits) + ", S1/2/3: " + DoubleToStr(s1,Digits)
   //                  + "/" + DoubleToStr(s2,Digits) + "/" + DoubleToStr(s3,Digits) + "\n" ;
   // comment= comment + "Fibos: " + DoubleToStr(yesterday_low + q*0.382, Digits) + ", " 
   //                  + DoubleToStr(yesterday_high - q*0.382,Digits) + "\n";     
      Comment(comment); 
   }
   return(0);
} 

//+-------------------------------------------------------------------------------------+
//| Compute index of first/last bar of yesterday and today                              |
//+-------------------------------------------------------------------------------------+
void ComputeDayIndices(int tzlocal, int tzdest, int &idxfirstbartoday,
       int &idxfirstbaryesterday, int &idxlastbaryesterday)
{     
   int tzdiff= tzlocal - tzdest,
       tzdiffsec= tzdiff*3600,
       dayminutes= 24 * 60,
       barsperday= dayminutes/Period();
   
   int dayofweektoday= TimeDayOfWeek(Time[0] - tzdiffsec),  // what day is today in the dest timezone?
       dayofweektofind= -1; 
      // due to gaps in the data, and shift of time around weekends (due 
      // to time zone) it is not as easy as to just look back for a bar 
      // with 00:00 time  
      idxfirstbartoday= 0;
      idxfirstbaryesterday= 0;
      idxlastbaryesterday= 0;      
   switch (dayofweektoday) 
      { 
      case 6: // sat
      case 0: // sun
      case 1: // mon
            dayofweektofind= 5; // yesterday in terms of trading was previous friday
            break;           
      default:
            dayofweektofind= dayofweektoday -1; 
            break;
      }           
   //----search  backwards for the last occrrence (backwards) of the day today (today's first bar)-----------
   for (int i=1; i<=barsperday+1; i++) 
      {
      datetime timet= Time[i] - tzdiffsec;
      if (TimeDayOfWeek(timet)!=dayofweektoday) {idxfirstbartoday= i-1; break;}
      }
   // search  backwards for the first occrrence (backwards) of the weekday we are looking for (yesterday's last bar)
   for (int j= 0; j<=2*barsperday+1; j++)
      {
      datetime timey= Time[i+j] - tzdiffsec;
      if (TimeDayOfWeek(timey)==dayofweektofind) {  // ignore saturdays (a Sa may happen due to TZ conversion)
      idxlastbaryesterday= i+j; break;}
      }
   // search  backwards for the first occurrence of weekday before yesterday (to determine yesterday's first bar)
   for (j= 1; j<=barsperday; j++)
      {
      datetime timey2= Time[idxlastbaryesterday+j] - tzdiffsec;
      if (TimeDayOfWeek(timey2)!=dayofweektofind) {  // ignore saturdays (a Sa may happen due to TZ conversion)
      idxfirstbaryesterday= idxlastbaryesterday+j-1; break;}
      } 
   if (Label_Simple_or_Detailed_12 == 2)
      {        
      if (dayofweektofind == 1)  {Yesterday = "      Monday    "; Today = "     Tuesday    ";}  
      if (dayofweektofind == 2)  {Yesterday = "     Tuesday    "; Today = "Wednesday    ";}
      if (dayofweektofind == 3)  {Yesterday = "Wednesday    "; Today = "    Thursday    ";}
      if (dayofweektofind == 4)  {Yesterday = "    Thursday    "; Today = "        Friday    ";}
      if (dayofweektofind == 5)  {Yesterday = "        Friday    "; Today = "      Monday    ";}
      }
   else {Yesterday = "Yesterday"; Today = "Today";}   
}

//+-----------------------------------------------------------------------------------------+
//| Helper sub-routine that creates lines and their labels                                  |                                                                                  |
//+-----------------------------------------------------------------------------------------+
void SetLevel(string text, double level, color col1, int linestyle,
        int thickness, datetime startline, datetime startlabel, int CC)
{
   int digits= Digits; 
   string labelname= "[PIVOT] " + text + " Label", linename= "[PIVOT] " + text + " Line", pricelabel; 

   //----create or move the horizontal line-------------------------------------------------  
   
    int a = linestyle;
    int b = thickness;
    int c =1; if (a==0)c=b;
   
       
   int Z;
   if (CC == 0){Z = OBJ_TREND;}
   if (CC == 1){Z = OBJ_HLINE;}
   if (Enter_line_placement_number==3){startline=Time[1];}   
   if (ObjectFind(linename) != 0) 
       {
       ObjectCreate(linename, Z, 0, startline, level, Time[0], level);
       ObjectSet   (linename, OBJPROP_STYLE, linestyle);
       ObjectSet   (linename, OBJPROP_COLOR, col1);
       ObjectSet   (linename, OBJPROP_WIDTH, c);
       ObjectSet   (linename, OBJPROP_BACK, true); 
       }
   else
       {
       ObjectMove  (linename, 1, Time[0],level);
       ObjectMove  (linename, 0, startline, level);
       }     
 
   //----create or move the labels-----------------------------------------------------------
     string FontStyle;   
     if (LabelsStyle_NormBoldBlack_123 <= 1){FontStyle = "Batang";}
     if (LabelsStyle_NormBoldBlack_123 == 2){FontStyle = "Arial Bold";}
     if (LabelsStyle_NormBoldBlack_123 >= 3){FontStyle = "Arial Black";}
     if (LabelsFontSize >12){LabelsFontSize = 12;}
     text = "                        " + text;//24,25
     if (Include_price_in_line_labels && StrToInteger(text)==0) {text = text + ": "+DoubleToStr(level, Digits);} 
                      
     if (ObjectFind(labelname) != 0)
        {
        ObjectCreate  (labelname, OBJ_TEXT, 0, startlabel, level);       
        ObjectSetText (labelname, text, LabelsFontSize, FontStyle, LabelsColor);
        }
     else
        {
        ObjectMove(labelname, 0, startlabel, level);
        }       
}

//+-------------------------------------------------------------------------------------------+
//| Helper=draws vertical timelines & gets "yesterday/today" from elsewhere and displays them.|                                                        
//+-------------------------------------------------------------------------------------------+
void SetTimeLine(string objname, string text, int idx, color col1, double vleveltext) 
{
   string FontStyle; string name= "[PIVOT] " + objname; int x= Time[idx];
   if (ObjectFind(name) != 0)
      { 
      ObjectCreate(name, OBJ_TREND, 0, x, 0, x, 100);
      ObjectSet(name, OBJPROP_STYLE, SeparatorLinesStyle_01234);
      ObjectSet(name, OBJPROP_COLOR, PeriodSeparatorLinesColor);
      ObjectSet(name, OBJPROP_WIDTH, SeparatorLinesThickness);
      ObjectSet(name, OBJPROP_BACK, true); 
      }
   else 
      {
      ObjectMove(name, 0, x, 0); 
      ObjectMove(name, 1, x, 100);
      }  
   if(ShowPeriodSeparatorLabels ==true)
      {  
      if (S_Label_Norm_Bold_Black_123 <= 1){FontStyle = "Batang";}
      if (S_Label_Norm_Bold_Black_123 == 2){FontStyle = "Arial Bold";}
      if (S_Label_Norm_Bold_Black_123 >= 3){FontStyle = "Arial Black";}
      if (ObjectFind(name + " Label") != 0) 
         {
         ObjectCreate (name + " Label", OBJ_TEXT, 0, x, vleveltext);
         ObjectSetText(name + " Label", text, SeparatorLabelFontSize, FontStyle,  PeriodSeparatorsLabelsColor);    
         }       
      else 
         {
         ObjectMove(name + " Label", 0, x, vleveltext);            
         }     
      }
}

//+-------------------------------------------------------------------------------------------+
//|                       End of Program                                                      |                                                        
//+-------------------------------------------------------------------------------------------+

