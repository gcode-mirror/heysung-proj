/*
   Generated by EX4-TO-MQ4 decompiler V4.0.224.1 []
   Website: http://purebeam.biz
   E-mail : purebeam@gmail.com
*/
#property copyright "Skyline, 2007"
#property link      "www.forexpertutti.it"

#include <stdlib.mqh>

extern string Comment0 = "SuperNova EA (Glenn) v1.5 [04 Nov 2007]";
extern string Comment1 = "Coded by Skyline (glicci@yahoo.it)";
extern string Comment2 = "SuperNova discussion thread : http://www.forexfactory.com/showthread.php?t=44216";
extern string Null = "---- Money Management variables ----";
extern double FixedLOT = 1.0;
extern bool MM = TRUE;
extern int Risk = 3;
extern int Stoploss = 20;
extern int Takeprofit = 20;
extern int TrailingStop = 0;
extern bool TrailingByPSAR = FALSE;
extern int CandleTrailStopPSAR = 2;
extern int Slippage = 3;
extern string Null1 = "---- Entry variables ----";
extern bool EntryOnVolume = FALSE;
extern bool EntryOnDamiani = FALSE;
extern bool EntryOnDMI = FALSE;
extern bool EntryOnMomentum = FALSE;
extern bool EntryOnCCI = FALSE;
extern bool EntryOnT3 = FALSE;
extern bool EntryOnJuice = FALSE;
extern bool EntryOnLaguerre = FALSE;
extern int MaxShiftfromQQECross = 5;
extern bool AllowReEntry = FALSE;
extern string Null2 = "---- Period variables ----";
extern int QQE_SF = 1;
extern int QQE_RSI_Period = 14;
extern double QQE_DARFACTOR = 4.236;
extern int DMI_Period = 14;
extern int Mom_Period = 10;
extern int CCI_Period = 14;
extern double T3_Periods = 8.0;
extern double T3_VolumeFactor = 0.7;
extern double Juice_Proximity = 0.95;
extern double PSAR_Step = 0.04;
extern double PSAR_Maximum = 0.5;
extern double PSAR_Precision = 7.0;
extern double Laguerre1_Gamma = 0.65;
extern double Laguerre2_Gamma = 0.85;
extern string Null3 = "---- Exit variables ----";
extern bool ExitOnQQE = TRUE;
extern bool ExitOnMomentum = FALSE;
extern bool ExitOnDMI = FALSE;
extern bool ExitOnCCI = FALSE;
extern bool ExitOnT3 = FALSE;
extern bool ExitOnLaguerre = FALSE;
extern int ExitTimeframe = 0;
extern string Null4 = "---- Threshold variables ----";
extern int CCIThreshold = 100;
extern int VolumeThreshold = 400;
extern double DamianiThreshold = 1.4;
extern double LaguerreLONGEntry = 0.15;
extern double LaguerreSHORTEntry = 0.85;
extern double LaguerreLONGExit = 0.85;
extern double LaguerreSHORTExit = 0.15;
extern string Null5 = "---- Time variables ----";
extern int StartTime = 0;
extern int EndTime = 24;
int g_magic_404;
int g_time_408 = 315532800;
int g_count_412 = 0;
int g_time_416 = 315532800;
int g_shift_420 = 0;
int g_time_424 = 315532800;
int g_time_428 = 315532800;
string gs_432 = "v1.5 [04 Nov 2007]";

int start() {
   double l_price_0;
   double l_lots_8;
   double l_price_16;
   int l_ticket_24;
   int l_error_28;
   string ls_unused_32;
   string ls_unused_40;
   string ls_unused_48;
   string ls_unused_56;
   string ls_unused_64;
   string ls_unused_72;
   double l_icustom_112;
   double l_icustom_120;
   double l_icustom_128;
   double l_icustom_136;
   double l_icustom_144;
   double l_ivolume_152;
   double l_icci_160;
   double l_icci_168;
   double l_icustom_176;
   double l_icustom_184;
   double l_icustom_192;
   double l_icustom_200;
   double l_icustom_208;
   double l_icustom_216;
   double l_icustom_224;
   double l_icustom_232;
   double l_icustom_240;
   double l_icci_248;
   double l_icci_256;
   double l_icustom_264;
   double l_icustom_272;
   double l_icustom_316;
   double l_icustom_324;
   string ls_280 = "\nEntry rules enabled : QQE";
   string ls_288 = "\nExit rules enabled : ";
   string ls_296 = "";
   g_magic_404 = MagicFromSymbol();
   if (MM == TRUE) {
      l_lots_8 = CalcolaLot(Risk);
      ls_296 = "\nMoney Management : Enabled ( " + Risk + "% Risk per trade )";
   } else {
      l_lots_8 = FixedLOT;
      ls_296 = "\nMoney Management : Disabled ( " + l_lots_8 + " fixed Lots for all trades )";
   }
   double l_icustom_80 = iCustom(NULL, 0, "QQEA", QQE_SF, QQE_RSI_Period, QQE_DARFACTOR, 0, 1);
   double l_icustom_88 = iCustom(NULL, 0, "QQEA", QQE_SF, QQE_RSI_Period, QQE_DARFACTOR, 1, 1);
   double l_icustom_96 = iCustom(NULL, 0, "QQEA", QQE_SF, QQE_RSI_Period, QQE_DARFACTOR, 0, 2);
   double l_icustom_104 = iCustom(NULL, 0, "QQEA", QQE_SF, QQE_RSI_Period, QQE_DARFACTOR, 1, 2);
   if (EntryOnDMI == TRUE) {
      l_icustom_112 = iCustom(NULL, 0, "DMI", DMI_Period, 0, 0, 1, 1, 1, 0, 1);
      l_icustom_120 = iCustom(NULL, 0, "DMI", DMI_Period, 0, 0, 1, 1, 1, 1, 1);
      ls_280 = ls_280 + " DMI";
   }
   if (EntryOnMomentum == TRUE) {
      l_icustom_128 = iCustom(NULL, 0, "MomentumVT", Mom_Period, 0, 1);
      ls_280 = ls_280 + " Momentum";
   }
   if (EntryOnDamiani == TRUE) {
      l_icustom_136 = iCustom(NULL, 0, "Damiani_volatmeter v3.2", 13, 20, 40, 100, DamianiThreshold, 1, 2000, 2, 1);
      l_icustom_144 = iCustom(NULL, 0, "Damiani_volatmeter v3.2", 13, 20, 40, 100, DamianiThreshold, 1, 2000, 0, 1);
      ls_280 = ls_280 + " Damiani";
   }
   if (EntryOnVolume == TRUE) {
      l_ivolume_152 = iVolume(NULL, 0, 1);
      ls_280 = ls_280 + " Volume";
   }
   if (EntryOnCCI == TRUE) {
      l_icci_160 = iCCI(NULL, 0, CCI_Period, PRICE_TYPICAL, 2);
      l_icci_168 = iCCI(NULL, 0, CCI_Period, PRICE_TYPICAL, 1);
      ls_280 = ls_280 + " CCI";
   }
   if (EntryOnJuice == TRUE) {
      l_icustom_176 = iCustom(NULL, 0, "Juice v1.2 alert", 0, Juice_Proximity, "alert.wav", 7, 1, 144, 70, 0, 1);
      l_icustom_184 = iCustom(NULL, 0, "Juice v1.2 alert", 0, Juice_Proximity, "alert.wav", 7, 1, 144, 70, 1, 1);
      ls_280 = ls_280 + " Juice";
   }
   if (EntryOnLaguerre == TRUE) {
      l_icustom_192 = iCustom(NULL, 0, "Laguerre", Laguerre1_Gamma, 950, 0, 1);
      l_icustom_200 = iCustom(NULL, 0, "Laguerre", Laguerre1_Gamma, 950, 0, 2);
      ls_280 = ls_280 + " Laguerre";
   }
   if (EntryOnT3 == TRUE) ls_280 = ls_280 + " T3";
   if (ExitTimeframe != 0 && ExitTimeframe != PERIOD_M1 && ExitTimeframe != PERIOD_M5 && ExitTimeframe != PERIOD_M15 && ExitTimeframe != PERIOD_M30 && ExitTimeframe != PERIOD_H1 &&
      ExitTimeframe != PERIOD_H4 && ExitTimeframe != PERIOD_D1 && ExitTimeframe != PERIOD_W1 && ExitTimeframe != PERIOD_MN1) {
      Alert("Please choose correct value for ExitTimeFrame (0,1,5,15,30,60,240,1440,10080,43200)");
      return (0);
   }
   if (ExitOnQQE == TRUE) {
      l_icustom_208 = iCustom(NULL, ExitTimeframe, "QQEA", QQE_SF, QQE_RSI_Period, QQE_DARFACTOR, 0, 1);
      l_icustom_216 = iCustom(NULL, ExitTimeframe, "QQEA", QQE_SF, QQE_RSI_Period, QQE_DARFACTOR, 1, 1);
      ls_288 = ls_288 + " QQE";
   }
   if (ExitOnDMI == TRUE) {
      l_icustom_224 = iCustom(NULL, ExitTimeframe, "DMI", DMI_Period, 0, 0, 1, 1, 1, 0, 1);
      l_icustom_232 = iCustom(NULL, ExitTimeframe, "DMI", DMI_Period, 0, 0, 1, 1, 1, 1, 1);
      ls_288 = ls_288 + " DMI";
   }
   if (ExitOnMomentum == TRUE) {
      l_icustom_240 = iCustom(NULL, ExitTimeframe, "MomentumVT", Mom_Period, 0, 1);
      ls_288 = ls_288 + " Momentum";
   }
   if (ExitOnCCI == TRUE) {
      l_icci_248 = iCCI(NULL, ExitTimeframe, CCI_Period, PRICE_TYPICAL, 2);
      l_icci_256 = iCCI(NULL, ExitTimeframe, CCI_Period, PRICE_TYPICAL, 1);
      ls_288 = ls_288 + " CCI";
   }
   if (ExitOnLaguerre == TRUE) {
      l_icustom_264 = iCustom(NULL, ExitTimeframe, "Laguerre", Laguerre2_Gamma, 950, 0, 1);
      l_icustom_272 = iCustom(NULL, ExitTimeframe, "Laguerre", Laguerre2_Gamma, 950, 0, 2);
      ls_288 = ls_288 + " Laguerre";
   }
   if (ExitOnT3 == TRUE) ls_288 = ls_288 + " T3";
   int li_304 = TotalOrders();
   if (l_icustom_96 < l_icustom_104 && l_icustom_80 > l_icustom_88 && g_time_428 != Time[0]) {
      g_time_416 = Time[1];
      g_time_428 = Time[0];
      Print("LastQQECross = ", TimeToStr(g_time_416));
   }
   if (l_icustom_96 > l_icustom_104 && l_icustom_80 < l_icustom_88 && g_time_428 != Time[0]) {
      g_time_416 = Time[1];
      g_time_428 = Time[0];
      Print("LastQQECross = ", TimeToStr(g_time_416));
   }
   g_shift_420 = iBarShift(NULL, 0, g_time_416, TRUE);
   if (li_304 < 1 && Hour() >= StartTime && Hour() <= EndTime) {
      if (l_icustom_80 > l_icustom_88 && OrdiniChiusiSullaCandela() == 0 && g_time_408 != Time[0] && g_time_416 > 315532800 && g_shift_420 <= MaxShiftfromQQECross) {
         g_count_412 = 0;
         if (EntryOnDMI == TRUE) {
            if (l_icustom_112 >= l_icustom_120) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnMomentum == TRUE) {
            if (l_icustom_128 > 0.0) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnDamiani == TRUE) {
            if (l_icustom_136 > l_icustom_144) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnVolume == TRUE) {
            if (l_ivolume_152 > VolumeThreshold) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnCCI == TRUE)
            if (l_icci_160 < CCIThreshold && l_icci_168 >= CCIThreshold) g_count_412++;
         if (EntryOnT3 == TRUE) {
            if (HA("Open", 1) > T3(1, 0)) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnJuice == TRUE) {
            if (l_icustom_176 / l_icustom_184 >= Juice_Proximity) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnLaguerre == TRUE) {
            if (l_icustom_200 < LaguerreLONGEntry && l_icustom_192 >= LaguerreLONGEntry) g_count_412++;
            else g_count_412 = 0;
         }
         if (g_count_412 == EntryOnDMI + EntryOnMomentum + EntryOnDamiani + EntryOnVolume + EntryOnCCI + EntryOnT3 + EntryOnJuice + EntryOnLaguerre) {
            g_time_408 = Time[0];
            l_price_0 = 0;
            l_price_16 = 0;
            l_ticket_24 = OrderSend(Symbol(), OP_BUY, l_lots_8, Ask, Slippage, l_price_0, l_price_16, Periodo(Period()), g_magic_404, 0, Blue);
            if (l_ticket_24 < 0) {
               l_error_28 = GetLastError();
               Print("Errore BUY (", l_error_28, ") : ", ErrorDescription(l_error_28));
            } else {
               PlaySound("alert.wav");
               g_count_412 = 0;
               Print("**** BUY LastQQECross = ", TimeToStr(g_time_416));
               if (AllowReEntry == FALSE) g_time_416 = 315532800;
            }
         }
      }
      if (l_icustom_80 < l_icustom_88 && OrdiniChiusiSullaCandela() == 0 && g_time_408 != Time[0] && g_time_416 > 315532800 && g_shift_420 <= MaxShiftfromQQECross) {
         g_count_412 = 0;
         if (EntryOnDMI == TRUE) {
            if (l_icustom_112 < l_icustom_120) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnMomentum == TRUE) {
            if (l_icustom_128 < 0.0) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnDamiani == TRUE) {
            if (l_icustom_136 > l_icustom_144) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnVolume == TRUE) {
            if (l_ivolume_152 > VolumeThreshold) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnCCI == TRUE)
            if (l_icci_160 > (-CCIThreshold) && l_icci_168 <= (-CCIThreshold)) g_count_412++;
         if (EntryOnT3 == TRUE) {
            if (HA("Open", 1) < T3(1, 0)) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnJuice == TRUE) {
            if (l_icustom_176 / l_icustom_184 >= Juice_Proximity) g_count_412++;
            else g_count_412 = 0;
         }
         if (EntryOnLaguerre == TRUE)
            if (l_icustom_200 > LaguerreSHORTEntry && l_icustom_192 <= LaguerreSHORTEntry) g_count_412++;
         if (g_count_412 == EntryOnDMI + EntryOnMomentum + EntryOnDamiani + EntryOnVolume + EntryOnCCI + EntryOnT3 + EntryOnJuice + EntryOnLaguerre) {
            g_time_408 = Time[0];
            l_price_0 = 0;
            l_price_16 = 0;
            l_ticket_24 = OrderSend(Symbol(), OP_SELL, l_lots_8, Bid, Slippage, l_price_0, l_price_16, Periodo(Period()), g_magic_404, 0, Blue);
            if (l_ticket_24 < 0) {
               l_error_28 = GetLastError();
               Print("Errore SELL(", l_error_28, ") : ", ErrorDescription(l_error_28));
            } else {
               PlaySound("alert.wav");
               g_count_412 = 0;
               Print("**** SELL LastQQECross = ", TimeToStr(g_time_416));
               if (AllowReEntry == FALSE) g_time_416 = 315532800;
            }
         }
      }
   }
   string ls_308 = "";
   if (TrailingStop > 0 && TrailingByPSAR == FALSE) {
      TrailingStop();
      ls_308 = "\nTrailingStop : Normal ( " + TrailingStop + " pips )";
   }
   if (TrailingByPSAR == TRUE) {
      l_icustom_316 = iCustom(NULL, 0, "Parabolic SAR Color - Alert", 0, PSAR_Step, PSAR_Maximum, PSAR_Precision, 0, CandleTrailStopPSAR);
      l_icustom_324 = iCustom(NULL, 0, "Parabolic SAR Color - Alert", 0, PSAR_Step, PSAR_Maximum, PSAR_Precision, 1, CandleTrailStopPSAR);
      TrailPSAR(l_icustom_316, l_icustom_324);
      ls_308 = "\nTrailingStop : Parabolic SAR ( " + CandleTrailStopPSAR + " candles back trailing )";
   }
   TakeProfit();
   StopLoss();
   ChiudeOrdini(l_icustom_208, l_icustom_216, l_icustom_240, l_icustom_224, l_icustom_232, l_icci_248, l_icci_256, l_icustom_264, l_icustom_272);
   Comment("\n----- SuperNova EA ", gs_432, " -----", 
      "\nCoded by Skyline", 
      "\nDonation Paypal account : glicci@yahoo.it (thank you!)", 
      "\n---------------------------------", 
      "\nMagic Number : ", g_magic_404, 
      "\nEA Start Time :", StartTime, " (Broker Time!)", 
   "\nEA End Time :", EndTime, " (Broker Time!)", ls_296, ls_308, ls_280, ls_288);
   return (0);
}

void TakeProfit() {
   int li_8;
   if (Takeprofit > 0) {
      li_8 = TotalOrders();
      for (int l_pos_0 = 0; l_pos_0 < li_8; l_pos_0++) {
         OrderSelect(l_pos_0, SELECT_BY_POS, MODE_TRADES);
         if (OrderMagicNumber() == g_magic_404) {
            if (OrderType() == OP_BUY) {
               if (Bid - OrderOpenPrice() >= Takeprofit * Point) {
                  if (AllowReEntry == FALSE) g_time_416 = 315532800;
                  OrderClose(OrderTicket(), OrderLots(), Bid, Slippage, LimeGreen);
                  return;
               }
            }
            if (OrderType() == OP_SELL) {
               if (OrderOpenPrice() - Ask >= Takeprofit * Point) {
                  if (AllowReEntry == FALSE) g_time_416 = 315532800;
                  OrderClose(OrderTicket(), OrderLots(), Ask, Slippage, Red);
                  return;
               }
            }
         }
      }
   }
}

void StopLoss() {
   int li_8;
   if (Stoploss > 0) {
      li_8 = TotalOrders();
      for (int l_pos_0 = 0; l_pos_0 < li_8; l_pos_0++) {
         OrderSelect(l_pos_0, SELECT_BY_POS, MODE_TRADES);
         if (OrderMagicNumber() == g_magic_404) {
            if (OrderType() == OP_BUY) {
               if (Bid - OrderOpenPrice() >= Stoploss * Point) {
                  if (AllowReEntry == FALSE) g_time_416 = 315532800;
                  OrderClose(OrderTicket(), OrderLots(), Bid, Slippage, LimeGreen);
                  return;
               }
            }
            if (OrderType() == OP_SELL) {
               if (OrderOpenPrice() - Ask >= Stoploss * Point) {
                  if (AllowReEntry == FALSE) g_time_416 = 315532800;
                  OrderClose(OrderTicket(), OrderLots(), Ask, Slippage, Red);
                  return;
               }
            }
         }
      }
   }
}

void TrailPSAR(double a_price_0, double a_price_8) {
   int l_error_20;
   int li_24;
   if (g_time_424 != Time[0]) {
      g_time_424 = Time[0];
      li_24 = TotalOrders();
      for (int l_pos_16 = 0; l_pos_16 < li_24; l_pos_16++) {
         OrderSelect(l_pos_16, SELECT_BY_POS, MODE_TRADES);
         if (OrderType() == OP_BUY && OrderMagicNumber() == g_magic_404) {
            if (a_price_8 > 0.0) {
               if (OrderModify(OrderTicket(), OrderOpenPrice(), a_price_8, OrderTakeProfit(), 0, Green) != FALSE) break;
               l_error_20 = GetLastError();
               if (l_error_20 > 1/* NO_RESULT */) Print("Error modifying SL by PSAR (", l_error_20, "): ", ErrorDescription(l_error_20));
            }
         }
         if (OrderType() == OP_SELL && OrderMagicNumber() == g_magic_404) {
            if (a_price_0 > 0.0) {
               if (OrderModify(OrderTicket(), OrderOpenPrice(), a_price_0, OrderTakeProfit(), 0, Red) != FALSE) break;
               l_error_20 = GetLastError();
               if (l_error_20 > 1/* NO_RESULT */) Print("error(", l_error_20, "): ", ErrorDescription(l_error_20));
            }
         }
      }
   }
}

int TotalOrders() {
   int l_count_4 = 0;
   for (int l_pos_0 = 0; l_pos_0 < OrdersTotal(); l_pos_0++) {
      OrderSelect(l_pos_0, SELECT_BY_POS, MODE_TRADES);
      if (OrderMagicNumber() == g_magic_404) l_count_4++;
   }
   return (l_count_4);
}

void TrailingStop() {
   int l_error_4;
   int li_8;
   if (TrailingStop > 0) {
      li_8 = TotalOrders();
      for (int l_pos_0 = 0; l_pos_0 < li_8; l_pos_0++) {
         OrderSelect(l_pos_0, SELECT_BY_POS, MODE_TRADES);
         if (OrderType() == OP_BUY && OrderMagicNumber() == g_magic_404) {
            if (Bid - OrderOpenPrice() > Point * TrailingStop) {
               if (OrderStopLoss() < Bid - Point * TrailingStop) {
                  if (AllowReEntry == FALSE) g_time_416 = 315532800;
                  if (OrderModify(OrderTicket(), OrderOpenPrice(), Bid - Point * TrailingStop, OrderTakeProfit(), 0, Green) != FALSE) break;
                  l_error_4 = GetLastError();
                  Print("error(", l_error_4, "): ", ErrorDescription(l_error_4));
               }
            }
         }
         if (OrderType() == OP_SELL && OrderMagicNumber() == g_magic_404) {
            if (OrderOpenPrice() - Ask > Point * TrailingStop) {
               if (OrderStopLoss() > Ask + Point * TrailingStop || OrderStopLoss() == 0.0) {
                  if (AllowReEntry == FALSE) g_time_416 = 315532800;
                  if (OrderModify(OrderTicket(), OrderOpenPrice(), Ask + Point * TrailingStop, OrderTakeProfit(), 0, Red) != FALSE) break;
                  l_error_4 = GetLastError();
                  Print("error(", l_error_4, "): ", ErrorDescription(l_error_4));
               }
            }
         }
      }
   }
}

double T3(int ai_0, int a_timeframe_4) {
   double l_icustom_8;
   if (EntryOnT3 == FALSE && ExitOnT3 == FALSE) return (0);
   l_icustom_8 = iCustom(NULL, a_timeframe_4, "T3", T3_Periods, T3_VolumeFactor, 0, ai_0);
   return (l_icustom_8);
}

double HA(string as_0, int ai_8) {
   double l_icustom_12;
   if (EntryOnT3 == FALSE && ExitOnT3 == FALSE) return (0);
   if (as_0 == "Open") l_icustom_12 = iCustom(NULL, 0, "Heiken Ashi", 255, 32768, 255, 32768, 2, ai_8);
   if (as_0 == "Close") l_icustom_12 = iCustom(NULL, 0, "Heiken Ashi", 255, 32768, 255, 32768, 3, ai_8);
   if (as_0 == "High") {
      if (HA("Open", ai_8) < HA("Close", ai_8)) l_icustom_12 = iCustom(NULL, 0, "Heiken Ashi", 255, 32768, 255, 32768, 1, ai_8);
      else l_icustom_12 = iCustom(NULL, 0, "Heiken Ashi", 255, 32768, 255, 32768, 0, ai_8);
   }
   if (as_0 == "Low") {
      if (HA("Open", ai_8) < HA("Close", ai_8)) l_icustom_12 = iCustom(NULL, 0, "Heiken Ashi", 255, 32768, 255, 32768, 0, ai_8);
      else l_icustom_12 = iCustom(NULL, 0, "Heiken Ashi", 255, 32768, 255, 32768, 1, ai_8);
   }
   return (l_icustom_12);
}

void ChiudeOrdini(double ad_0, double ad_8, double ad_16, double ad_24, double ad_32, double ad_40, double ad_48, double ad_56, double ad_64) {
   int li_72 = TotalOrders();
   int l_count_76 = 0;
   for (int l_pos_80 = 0; l_pos_80 < li_72; l_pos_80++) {
      OrderSelect(l_pos_80, SELECT_BY_POS, MODE_TRADES);
      if (OrderType() == OP_BUY && OrderMagicNumber() == g_magic_404) {
         if (ExitOnQQE == TRUE)
         {
            if (ad_0 < ad_8) {l_count_76++;
            Print("BUY order is closed at v1 ", ad_0,", v2 ",ad_8);
            }
            
            }
         if (ExitOnMomentum == TRUE)
            if (ad_16 < 0.0) l_count_76++;
         if (ExitOnDMI == TRUE)
            if (ad_24 < ad_32) l_count_76++;
         if (ExitOnCCI == TRUE)
            if (ad_40 > CCIThreshold && ad_48 < CCIThreshold) l_count_76++;
         if (ExitOnT3 == TRUE)
            if (HA("Open", 1) < T3(1, ExitTimeframe)) l_count_76++;
         if (ExitOnLaguerre == TRUE)
            if (ad_64 > LaguerreLONGExit && ad_56 <= LaguerreLONGExit) l_count_76++;
         if (l_count_76 > 0) {
            OrderClose(OrderTicket(), OrderLots(), Bid, 0, LimeGreen);
            l_count_76 = 0;
            return;
         }
      }
      if (OrderType() == OP_SELL && OrderMagicNumber() == g_magic_404) {
         if (ExitOnQQE == TRUE)
         {
            if (ad_0 > ad_8) {l_count_76++;
             Print("SELL order is closed at v1 ", ad_0,", v2 ",ad_8);
             }
          }
         if (ExitOnMomentum == TRUE)
            if (ad_16 > 0.0) l_count_76++;
         if (ExitOnDMI == TRUE)
            if (ad_24 > ad_32) l_count_76++;
         if (ExitOnCCI == TRUE)
            if (ad_40 < (-CCIThreshold) && ad_48 > (-CCIThreshold)) l_count_76++;
         if (ExitOnT3 == TRUE)
            if (HA("Open", 1) > T3(1, ExitTimeframe)) l_count_76++;
         if (ExitOnLaguerre == TRUE)
            if (ad_64 > LaguerreSHORTExit && ad_56 <= LaguerreSHORTExit) l_count_76++;
         if (l_count_76 > 0) {
            OrderClose(OrderTicket(), OrderLots(), Ask, 0, Red);
            l_count_76 = 0;
            return;
         }
      }
   }
}

int MagicFromSymbol() {
   int li_ret_0 = 0;
   for (int li_4 = 0; li_4 < 5; li_4++) li_ret_0 = li_ret_0 * 2 + StringGetChar(Symbol(), li_4);
   li_ret_0 = 2 * li_ret_0 + Period();
   return (li_ret_0);
}

int OrdiniChiusiSullaCandela() {
   int l_shift_12;
   int l_count_4 = 0;
   int l_hist_total_8 = OrdersHistoryTotal();
   for (int l_pos_0 = 0; l_pos_0 < l_hist_total_8; l_pos_0++) {
      if (OrderSelect(l_pos_0, SELECT_BY_POS, MODE_HISTORY) == TRUE) {
         l_shift_12 = iBarShift(NULL, 0, OrderCloseTime());
         if (Time[l_shift_12] == Time[0]) l_count_4++;
      }
   }
   return (l_count_4);
}

double CalcolaLot(int ai_0) {
   double ld_ret_4 = 0;
   ld_ret_4 = AccountEquity() * ai_0 / 100.0 / 1000.0;
   if (ld_ret_4 >= 0.1) ld_ret_4 = NormalizeDouble(ld_ret_4, 1);
   else ld_ret_4 = NormalizeDouble(ld_ret_4, 2);
   if (ld_ret_4 < MarketInfo(Symbol(), MODE_MINLOT)) ld_ret_4 = MarketInfo(Symbol(), MODE_MINLOT);
   return (ld_ret_4);
}

string Periodo(int ai_0) {
   if (ai_0 == 1) return ("M1");
   if (ai_0 == 5) return ("M5");
   if (ai_0 == 15) return ("M15");
   if (ai_0 == 30) return ("M30");
   if (ai_0 == 60) return ("H1");
   if (ai_0 == 240) return ("H4");
   if (ai_0 == 1440) return ("D1");
   return ("");
}