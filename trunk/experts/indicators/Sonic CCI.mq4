//------------------------------------------------------+
//                                                      |
//               FX Sniper's CCI.mq4                    |
//                                                      |
//------------------------------------------------------+

#property copyright "Copyright © 2006 FX Sniper, fxsniper@gmail.com."
#property link      ""

#property indicator_separate_window

#property indicator_buffers     7
#property indicator_color1      DarkBlue
#property indicator_color2      SaddleBrown
#property indicator_color3      Gray
#property indicator_color4      Yellow
#property indicator_color5      Silver
#property indicator_color6      Red
#property indicator_color7      LimeGreen

#property indicator_width1      3
#property indicator_width2      3
#property indicator_width3      3
#property indicator_width4      3
#property indicator_width5      1
#property indicator_width6      1
#property indicator_width7      1

#property indicator_style1      STYLE_SOLID
#property indicator_style2      STYLE_SOLID
#property indicator_style3      STYLE_SOLID
#property indicator_style4      STYLE_SOLID
#property indicator_style5      STYLE_SOLID
#property indicator_style6      STYLE_SOLID
#property indicator_style7      STYLE_SOLID

#property indicator_level1      100.0
#property indicator_level2      200.0
#property indicator_level3     -100.0
#property indicator_level4     -200.0
#property indicator_levelcolor  DimGray
#property indicator_levelstyle  2
#property indicator_levelwidth  1

extern int CCI_Period = 34;
double g_ibuf_84[];
double g_ibuf_88[];
double g_ibuf_92[];
double g_ibuf_96[];
double g_ibuf_100[];
double g_ibuf_104[];
double g_ibuf_108[];
int g_count_120;
int g_count_124;
int gi_unused_128 = 0;

int init() {
   IndicatorBuffers(8);
   SetIndexStyle(4, DRAW_LINE);
   SetIndexBuffer(4, g_ibuf_84);
   SetIndexLabel(4, "TrendCCI");
   SetIndexStyle(0, DRAW_HISTOGRAM);
   SetIndexBuffer(0, g_ibuf_88);
   SetIndexStyle(1, DRAW_HISTOGRAM);
   SetIndexBuffer(1, g_ibuf_92);
   SetIndexStyle(2, DRAW_HISTOGRAM);
   SetIndexBuffer(2, g_ibuf_96);
   SetIndexStyle(3, DRAW_HISTOGRAM);
   SetIndexBuffer(3, g_ibuf_100);
   SetIndexStyle(5, DRAW_ARROW);
   SetIndexArrow(5, 167);
   SetIndexBuffer(5, g_ibuf_104);
   SetIndexStyle(6, DRAW_ARROW);
   SetIndexArrow(6, 167); //158=circle, 167=solid square
   SetIndexBuffer(6, g_ibuf_108);
   SetIndexLabel(0, NULL);
   SetIndexLabel(1, NULL);
   SetIndexLabel(2, NULL);
   SetIndexLabel(3, NULL);
   SetIndexLabel(4, NULL);
   SetIndexLabel(5, NULL);
   SetIndexLabel(6, NULL);
   SetIndexLabel(7, NULL);
   
   if(CCI_Period <= 0) {CCI_Period = 14;}
   
   //---- name for DataWindow and indicator subwindow label
   string short_name;
   short_name="CCI   ( "+CCI_Period+" )  ";
   IndicatorShortName(short_name);
   SetIndexLabel(8, short_name);  
   
   return (0);
}

int deinit() {
   return (0);
}

int start() {
   double ld_48;
   double ld_56;
   double ld_64;
   double ld_72;
   int l_day_0 = TimeDay(TimeCurrent());
   int l_month_4 = TimeMonth(TimeCurrent());
   int l_year_8 = TimeYear(TimeCurrent());
   int li_28 = IndicatorCounted();
   if (li_28 < 0) return (-1);
   if (li_28 > 0) li_28--;
   int l_bars_12 = Bars;
   int l_period_20 = CCI_Period;
   for (int l_bars_16 = l_bars_12; l_bars_16 >= 0; l_bars_16--) {
      g_ibuf_96[l_bars_16] = 0;
      g_ibuf_92[l_bars_16] = 0;
      g_ibuf_100[l_bars_16] = 0;
      g_ibuf_88[l_bars_16] = 0;
      g_ibuf_84[l_bars_16] = iCCI(NULL, 0, l_period_20, PRICE_TYPICAL, l_bars_16);
      if (g_ibuf_84[l_bars_16] > 0.0 && g_ibuf_84[l_bars_16 + 1] < 0.0)
         if (g_count_124 > 4) g_count_120 = 0;
      if (g_ibuf_84[l_bars_16] > 0.0) {
         if (g_count_120 < 5) {
            g_ibuf_96[l_bars_16] = g_ibuf_84[l_bars_16];
            g_count_120++;
         }
         if (g_count_120 == 5) {
            g_ibuf_100[l_bars_16] = g_ibuf_84[l_bars_16];
            g_count_120++;
         }
         if (g_count_120 > 5) g_ibuf_88[l_bars_16] = g_ibuf_84[l_bars_16];
      }
      if (g_ibuf_84[l_bars_16] < 0.0 && g_ibuf_84[l_bars_16 + 1] > 0.0)
         if (g_count_120 > 4) g_count_124 = 0;
      if (g_ibuf_84[l_bars_16] < 0.0) {
         if (g_count_124 < 5) {
            g_ibuf_96[l_bars_16] = g_ibuf_84[l_bars_16];
            g_count_124++;
         }
         if (g_count_124 == 5) {
            g_ibuf_100[l_bars_16] = g_ibuf_84[l_bars_16];
            g_count_124++;
         }
         if (g_count_124 > 5) g_ibuf_92[l_bars_16] = g_ibuf_84[l_bars_16];
      }
   }
   int li_32 = 25;
   int li_36 = Bars - li_32 - 5;
   int li_40 = li_36 - li_32 - 1;
   for (int li_44 = li_40; li_44 >= 0; li_44--) {
      ld_48 = 0;
      for (l_bars_16 = li_32; l_bars_16 >= 1; l_bars_16--) {
         ld_56 = li_32 + 1;
         ld_56 /= 3.0;
         ld_64 = 0;
         ld_64 = (l_bars_16 - ld_56) * (Close[li_32 - l_bars_16 + li_44]);
         ld_48 += ld_64;
      }
      ld_72 = 6.0 * ld_48 / (li_32 * (li_32 + 1));
      g_ibuf_104[li_44] = 0;
      g_ibuf_108[li_44] = 0;
      if (ld_72 > Close[li_44]) g_ibuf_108[li_44] = EMPTY_VALUE;
      else
         if (ld_72 < Close[li_44]) g_ibuf_104[li_44] = EMPTY_VALUE;
   }
   return (0);
}
//-----------------End Program------------------------------