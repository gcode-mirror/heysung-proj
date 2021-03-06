/*
   Generated by EX4-TO-MQ4 decompiler V4.0.224.1 []
   Website: http://purebeam.biz
   E-mail : purebeam@gmail.com
*/
#property copyright "Copyright ?2009, Cobra THV Trading System"
#property link      "http://www.cobraforex.net"

#include <stdlib.mqh>

extern string Trade_Mgmnt = "EA opens trades base on Lots and TP on Pivot lvls or batch and leave the rest to run...";
extern string Can_use_Both = "Both Pivot and Batch can be combined to manage profit taking. But total percentage must be less than 100%.";
extern bool UsePivots_for_TP = FALSE;
extern bool Include_Mid_Levels_SR = TRUE;
extern double TP_1st_Lots_Percent = 50.0;
extern double TP_2nd_Lots_Percent = 25.0;
extern double TP_3rd_Lots_Percent = 25.0;
extern string Settings_for_SDX_Pivot = "Enter the SDX-TzPivots Settings below";
extern int Local__HrsServerTzFromGMT = 2;
extern int Destination__HrsNewTZfromGMT = 0;
extern int Show_1Daily_2FibonacciPivots = 2;
extern bool UseTP_By_Batch = TRUE;
extern double TP_1st_Batch_Lots_Percent = 50.0;
extern double TP_2nd_Batch_Lots_Percent = 0.0;
extern double TP_3rd_Batch_Lots_Percent = 0.0;
extern double TP_1st_Batch_Pips = 15.0;
extern double TP_2nd_Batch_Pips = 0.0;
extern double TP_3rd_Batch_Pips = 0.0;
extern string Capital_Protection = "Protect capital after PA moves in your favor by pips value";
extern bool UseNoLossAfterPips = TRUE;
extern int NoLossAfterPips = 10;
extern string Manage_Losses = "Manage losses by batches";
extern bool UseLoss_by_Batch = FALSE;
extern double Loss_1st_Batch_Lots_Percent = 25.0;
extern double Loss_2nd_Batch_Lots_Percent = 25.0;
extern double Loss_3rd_Batch_Lots_Percent = 25.0;
extern double Loss_1st_Batch_Pips = 15.0;
extern double Loss_2nd_Batch_Pips = 20.0;
extern double Loss_3rd_Batch_Pips = 35.0;
extern string Standard_Settings = "-------------------------------------";
extern int TakeProfit = 75;
extern int StopLoss = 25;
extern string Trailing_Stops = "2 stage trailing stops available. 1st stage is classic trailing stop.";
extern bool UseTrailiingStop = TRUE;
extern int Trailing_Stop_Pips = 25;
extern string Special_Trailing_Stop = "2nd stage trailing is by percentage of profit after min. pips reached.";
extern bool UseTrailPriceByPercentage = TRUE;
extern int MinPipsToActivate = 80;
extern int PercentageTrailBehindPrice = 30;
extern string Preceding_TP = "Setting TP to Precede Price by a certain number of pips.";
extern bool Use_Preceding_TP = TRUE;
extern int Preceding_TP_Pips = 50;
extern int Slippage = 3;
extern bool Show_Status = TRUE;
extern bool Broker_Allow_Micro_Lot_Size = FALSE;
int gi_352 = 1;
double gd_356;
bool gi_364;
double gd_368;
double gd_376;
double gd_384;
double gd_392;
double gd_400;
double gd_408;
double gd_416;
double gd_424;
double gd_432;
double gd_440;
double gd_448;
double gd_456;
double gd_464;
double gda_472[];
double gd_476 = 1001.0;
double gd_484 = 1001.0;
double gd_492 = 1001.0;
bool gi_500 = TRUE;
bool gi_504 = FALSE;
double gd_508;
double gd_516;
double gd_524;
double gd_532;
double gd_540;
double gd_548;
string gs_556;
string g_dbl2str_564;
string gs_572;
string g_dbl2str_580;
string gs_588;
string g_dbl2str_596;
string gs_604;
double gd_612;
double gd_620;
double gd_628;
double gd_636;
double gd_644;
double gd_652;
double gd_660;
double gd_668;
double gd_676;
bool gi_684 = TRUE;
int g_index_688;
int gi_692;
int g_datetime_696 = 0;
int g_timeframe_700 = 0;

int init() {
   gi_500 = TRUE;
   gi_364 = FALSE;
   gi_504 = FALSE;
   gd_476 = 1001;
   gd_484 = 1001;
   gd_492 = 1001;
   gi_684 = TRUE;
   if (Digits == 5 || Digits == 3) gi_352 = 10;
   Comment("");
   return (0);
}

int deinit() {
   Comment("");
   return (0);
}

int start() {
   if (Bars < 100 || IsTradeAllowed() == FALSE) return;
   Calculate_Pivot_SR();
   if (Show_1Daily_2FibonacciPivots == 1) {
      if (Include_Mid_Levels_SR) {
         ArrayResize(gda_472, 13);
         gda_472[0] = gd_408;
         gda_472[1] = (gd_408 + gd_400) / 2.0;
         gda_472[2] = gd_400;
         gda_472[3] = (gd_400 + gd_392) / 2.0;
         gda_472[4] = gd_392;
         gda_472[5] = (gd_392 + gd_368) / 2.0;
         gda_472[6] = gd_368;
         gda_472[7] = (gd_368 + gd_432) / 2.0;
         gda_472[8] = gd_432;
         gda_472[9] = (gd_432 + gd_440) / 2.0;
         gda_472[10] = gd_440;
         gda_472[11] = (gd_440 + gd_448) / 2.0;
         gda_472[12] = gd_448;
      } else {
         ArrayResize(gda_472, 7);
         gda_472[0] = gd_408;
         gda_472[1] = gd_400;
         gda_472[2] = gd_392;
         gda_472[3] = gd_368;
         gda_472[4] = gd_432;
         gda_472[5] = gd_440;
         gda_472[6] = gd_448;
      }
   } else {
      if (Show_1Daily_2FibonacciPivots == 2) {
         if (Include_Mid_Levels_SR) {
            ArrayResize(gda_472, 21);
            gda_472[0] = gd_424;
            gda_472[1] = (gd_424 + gd_416) / 2.0;
            gda_472[2] = gd_416;
            gda_472[3] = (gd_416 + gd_408) / 2.0;
            gda_472[4] = gd_408;
            gda_472[5] = (gd_408 + gd_400) / 2.0;
            gda_472[6] = gd_400;
            gda_472[7] = (gd_400 + gd_392) / 2.0;
            gda_472[8] = gd_392;
            gda_472[9] = (gd_392 + gd_368) / 2.0;
            gda_472[10] = gd_368;
            gda_472[11] = (gd_432 + gd_368) / 2.0;
            gda_472[12] = gd_432;
            gda_472[13] = (gd_440 + gd_432) / 2.0;
            gda_472[14] = gd_440;
            gda_472[15] = (gd_448 + gd_440) / 2.0;
            gda_472[16] = gd_448;
            gda_472[17] = (gd_456 + gd_448) / 2.0;
            gda_472[18] = gd_456;
            gda_472[19] = (gd_464 + gd_456) / 2.0;
            gda_472[20] = gd_464;
         } else {
            ArrayResize(gda_472, 11);
            gda_472[0] = gd_424;
            gda_472[1] = gd_416;
            gda_472[2] = gd_408;
            gda_472[3] = gd_400;
            gda_472[4] = gd_392;
            gda_472[5] = gd_368;
            gda_472[6] = gd_432;
            gda_472[7] = gd_440;
            gda_472[8] = gd_448;
            gda_472[9] = gd_456;
            gda_472[10] = gd_464;
         }
      }
   }
   if (Show_1Daily_2FibonacciPivots == 1 && Include_Mid_Levels_SR) gi_692 = 13;
   if (Show_1Daily_2FibonacciPivots == 1 && !Include_Mid_Levels_SR) gi_692 = 7;
   if (Show_1Daily_2FibonacciPivots == 2 && Include_Mid_Levels_SR) gi_692 = 21;
   if (Show_1Daily_2FibonacciPivots == 2 && !Include_Mid_Levels_SR) gi_692 = 11;
   if (CalculateCurrentOrders(Symbol()) == 0) CheckForOpen();
   else {
      CheckForClose();
      if (UseTrailPriceByPercentage && gi_504) TrailingByPercentage();
      else
         if (UseTrailiingStop) TrailingPositions();
   }
   return (0);
}

int CalculateCurrentOrders(string as_unused_0) {
   int l_count_8 = 0;
   for (int l_pos_12 = 0; l_pos_12 < OrdersTotal(); l_pos_12++) {
      if (OrderSelect(l_pos_12, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderSymbol() == Symbol()) l_count_8++;
   }
   return (l_count_8);
}

void CheckForOpen() {
   gi_500 = TRUE;
   gi_364 = FALSE;
   gi_504 = FALSE;
   gd_476 = 1001;
   gd_484 = 1001;
   gd_492 = 1001;
   gi_684 = TRUE;
   double ld_unused_0 = Ask;
   double ld_unused_8 = Bid;
   if (Show_Status) {
      Comment("THV CaveManager EA on " + AccountCompany() + " (" + Digits + " digits)" 
      + "\nWaiting for action ....");
   }
}

void CheckForClose() {
   bool li_8;
   double l_ord_open_price_16;
   int li_24;
   double ld_28;
   double ld_36;
   double ld_44;
   double ld_52;
   double ld_60;
   double ld_68;
   string ls_76;
   string ls_84;
   string ls_92;
   string ls_100;
   string ls_108;
   string ls_116;
   string l_dbl2str_124;
   string ls_132;
   string ls_140;
   string ls_148;
   string ls_156;
   string ls_164;
   string ls_172;
   int li_unused_0 = 0;
   int li_unused_4 = 0;
   for (int l_pos_12 = 0; l_pos_12 < OrdersTotal(); l_pos_12++) {
      if (OrderSelect(l_pos_12, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderSymbol() == Symbol()) {
         l_ord_open_price_16 = OrderOpenPrice();
         if (OrderStopLoss() == 0.0 || OrderTakeProfit() == 0.0) {
            if (OrderType() == OP_BUY) {
               if (StopLoss != 0 && TakeProfit != 0) OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice() - StopLoss * (Point * gi_352), OrderOpenPrice() + TakeProfit * (Point * gi_352), 0);
               if (StopLoss != 0 && TakeProfit == 0) OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice() - StopLoss * (Point * gi_352), 0, 0);
               if (StopLoss == 0 && TakeProfit != 0) OrderModify(OrderTicket(), OrderOpenPrice(), 0, OrderOpenPrice() + TakeProfit * (Point * gi_352), 0);
            }
            if (OrderType() == OP_SELL) {
               if (StopLoss != 0 && TakeProfit != 0) OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice() + StopLoss * (Point * gi_352), OrderOpenPrice() - TakeProfit * (Point * gi_352), 0);
               if (StopLoss != 0 && TakeProfit == 0) OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice() + StopLoss * (Point * gi_352), 0, 0);
               if (StopLoss == 0 && TakeProfit != 0) OrderModify(OrderTicket(), OrderOpenPrice(), 0, OrderOpenPrice() - TakeProfit * (Point * gi_352), 0);
            }
         }
         if (gi_684) {
            li_24 = 1;
            if (Broker_Allow_Micro_Lot_Size) li_24 = 2;
            gd_612 = NormalizeDouble(TP_1st_Lots_Percent / 100.0 * OrderLots(), li_24);
            gd_620 = NormalizeDouble(TP_2nd_Lots_Percent / 100.0 * OrderLots(), li_24);
            gd_628 = NormalizeDouble(TP_3rd_Lots_Percent / 100.0 * OrderLots(), li_24);
            gd_636 = NormalizeDouble(TP_1st_Batch_Lots_Percent / 100.0 * OrderLots(), li_24);
            gd_644 = NormalizeDouble(TP_2nd_Batch_Lots_Percent / 100.0 * OrderLots(), li_24);
            gd_652 = NormalizeDouble(TP_3rd_Batch_Lots_Percent / 100.0 * OrderLots(), li_24);
            gd_660 = NormalizeDouble(Loss_1st_Batch_Lots_Percent / 100.0 * OrderLots(), li_24);
            gd_668 = NormalizeDouble(Loss_2nd_Batch_Lots_Percent / 100.0 * OrderLots(), li_24);
            gd_676 = NormalizeDouble(Loss_3rd_Batch_Lots_Percent / 100.0 * OrderLots(), li_24);
            gd_508 = gd_636;
            gd_516 = gd_644;
            gd_524 = gd_652;
            gd_532 = gd_660;
            gd_540 = gd_668;
            gd_548 = gd_676;
            gi_684 = FALSE;
         }
         if (UseNoLossAfterPips) {
            if (OrderType() == OP_BUY) {
               if (!gi_364) gd_356 = l_ord_open_price_16 - StopLoss * gi_352 * Point;
               if (Bid - l_ord_open_price_16 >= NoLossAfterPips * gi_352 * Point && !gi_364) {
                  gd_356 = l_ord_open_price_16 + gi_352 * 2 * Point;
                  gi_364 = TRUE;
               }
               if (Bid <= gd_356 && gi_364) {
                  li_8 = orderclosebuy(l_pos_12, OrderLots());
                  if (!li_8) gi_364 = FALSE;
               }
            } else {
               if (OrderType() == OP_SELL) {
                  if (!gi_364) gd_356 = l_ord_open_price_16 + StopLoss * gi_352 * Point;
                  if (l_ord_open_price_16 - Ask >= NoLossAfterPips * gi_352 * Point && !gi_364) {
                     gd_356 = l_ord_open_price_16 - gi_352 * 2 * Point;
                     gi_364 = TRUE;
                  }
                  if (gd_356 <= Ask && gi_364) {
                     li_8 = orderclosesell(l_pos_12, OrderLots());
                     if (!li_8) gi_364 = FALSE;
                  }
               }
            }
         }
         if (UsePivots_for_TP) {
            if (gi_500 && OrderType() == OP_BUY && gd_476 == 1001.0) {
               for (g_index_688 = 0; g_index_688 <= gi_692; g_index_688++) {
                  if (Ask > gda_472[g_index_688]) {
                     gd_476 = gda_472[g_index_688 - 1];
                     gd_484 = gda_472[g_index_688 - 2];
                     gd_492 = gda_472[g_index_688 - 3];
                     if (gd_476 == 0.0) gd_476 = 5555;
                     if (gd_484 == 0.0) gd_484 = 5555;
                     if (gd_492 == 0.0) gd_492 = 5555;
                     g_index_688 = gi_692 + 1;
                     gi_500 = FALSE;
                  }
               }
            }
            if (gi_500 && OrderType() == OP_SELL && gd_476 == 1001.0) {
               for (g_index_688 = gi_692; g_index_688 >= 0; g_index_688--) {
                  if (Bid < gda_472[g_index_688]) {
                     gd_476 = gda_472[g_index_688 + 1];
                     gd_484 = gda_472[g_index_688 + 2];
                     gd_492 = gda_472[g_index_688 + 3];
                     if (gd_476 == 0.0) gd_476 = 5555;
                     if (gd_484 == 0.0) gd_484 = 5555;
                     if (gd_492 == 0.0) gd_492 = 5555;
                     g_index_688 = -1;
                     gi_500 = FALSE;
                  }
               }
            }
            if (OrderType() == OP_BUY) {
               if (Bid >= gd_476 && gd_476 < 1111.0 && gd_612 > 0.0) {
                  li_8 = orderclosebuy(l_pos_12, gd_612);
                  if (li_8) gd_476 = 1111;
               }
               if (Bid >= gd_484 && gd_484 < 1122.0 && gd_620 > 0.0) {
                  li_8 = orderclosebuy(l_pos_12, gd_620);
                  if (li_8) gd_484 = 1122;
               }
               if (Bid >= gd_492 && gd_492 < 1133.0 && gd_628 > 0.0) {
                  li_8 = orderclosebuy(l_pos_12, gd_628);
                  if (li_8) gd_492 = 1133;
               }
            } else {
               if (OrderType() == OP_SELL) {
                  if (Ask <= gd_476 && gd_476 < 2211.0 && gd_612 > 0.0) {
                     li_8 = orderclosesell(l_pos_12, gd_612);
                     if (li_8) gd_476 = 2211;
                  }
                  if (Ask <= gd_484 && gd_484 < 2222.0 && gd_620 > 0.0) {
                     li_8 = orderclosesell(l_pos_12, gd_620);
                     if (li_8) gd_484 = 2222;
                  }
                  if (Ask <= gd_492 && gd_492 < 2233.0 && gd_628 > 0.0) {
                     li_8 = orderclosesell(l_pos_12, gd_628);
                     if (li_8) gd_492 = 2233;
                  }
               }
            }
         }
         ld_28 = Bid - l_ord_open_price_16;
         ld_36 = l_ord_open_price_16 - Ask;
         if (OrderType() == OP_BUY && ld_28 / (gi_352 * Point) >= MinPipsToActivate) gi_504 = TRUE;
         if (OrderType() == OP_SELL && ld_36 / (gi_352 * Point) >= MinPipsToActivate) gi_504 = TRUE;
         if (UseTP_By_Batch) {
            if (OrderType() == OP_BUY && gd_508 > 0.0 && ld_28 >= TP_1st_Batch_Pips * gi_352 * Point) {
               li_8 = orderclosebuy(l_pos_12, gd_636);
               if (li_8) gd_508 = -1;
            } else {
               if (OrderType() == OP_BUY && gd_516 > 0.0 && ld_28 >= TP_2nd_Batch_Pips * gi_352 * Point) {
                  li_8 = orderclosebuy(l_pos_12, gd_644);
                  if (li_8) gd_516 = -2;
               } else {
                  if (OrderType() == OP_BUY && gd_524 > 0.0 && ld_28 >= TP_3rd_Batch_Pips * gi_352 * Point) {
                     li_8 = orderclosebuy(l_pos_12, gd_652);
                     if (li_8) gd_524 = -3;
                  } else {
                     if (OrderType() == OP_SELL && gd_508 > 0.0 && ld_36 >= TP_1st_Batch_Pips * gi_352 * Point) {
                        li_8 = orderclosesell(l_pos_12, gd_636);
                        if (li_8) gd_508 = -1;
                     } else {
                        if (OrderType() == OP_SELL && gd_516 > 0.0 && ld_36 >= TP_2nd_Batch_Pips * gi_352 * Point) {
                           li_8 = orderclosesell(l_pos_12, gd_644);
                           if (li_8) gd_516 = -2;
                        } else {
                           if (OrderType() == OP_SELL && gd_524 > 0.0 && ld_36 >= TP_3rd_Batch_Pips * gi_352 * Point) {
                              li_8 = orderclosesell(l_pos_12, gd_652);
                              if (li_8) gd_524 = -3;
                           }
                        }
                     }
                  }
               }
            }
         }
         ld_44 = Ask - l_ord_open_price_16;
         ld_52 = l_ord_open_price_16 - Bid;
         if (UseLoss_by_Batch) {
            if (OrderType() == OP_BUY && gd_532 > 0.0 && ld_52 >= Loss_1st_Batch_Pips * gi_352 * Point) {
               li_8 = orderclosebuy(l_pos_12, gd_660);
               if (li_8) gd_532 = -1;
            } else {
               if (OrderType() == OP_BUY && gd_540 > 0.0 && ld_52 >= Loss_2nd_Batch_Pips * gi_352 * Point) {
                  li_8 = orderclosebuy(l_pos_12, gd_668);
                  if (li_8) gd_540 = -2;
               } else {
                  if (OrderType() == OP_BUY && gd_548 > 0.0 && ld_52 >= Loss_3rd_Batch_Pips * gi_352 * Point) {
                     li_8 = orderclosebuy(l_pos_12, gd_676);
                     if (li_8) gd_548 = -3;
                  } else {
                     if (OrderType() == OP_SELL && gd_532 > 0.0 && ld_44 >= Loss_1st_Batch_Pips * gi_352 * Point) {
                        li_8 = orderclosesell(l_pos_12, gd_660);
                        if (li_8) gd_532 = -1;
                     } else {
                        if (OrderType() == OP_SELL && gd_540 > 0.0 && ld_44 >= Loss_2nd_Batch_Pips * gi_352 * Point) {
                           li_8 = orderclosesell(l_pos_12, gd_668);
                           if (li_8) gd_540 = -2;
                        } else {
                           if (OrderType() == OP_SELL && gd_548 > 0.0 && ld_44 >= Loss_3rd_Batch_Pips * gi_352 * Point) {
                              li_8 = orderclosesell(l_pos_12, gd_676);
                              if (li_8) gd_548 = -3;
                           }
                        }
                     }
                  }
               }
            }
         }
         if (Show_Status) {
            if (OrderType() == OP_BUY) gs_556 = Symbol() + " BOUGHT at " + DoubleToStr(OrderOpenPrice(), Digits);
            else gs_556 = Symbol() + " SOLD at " + DoubleToStr(OrderOpenPrice(), Digits);
            if (gd_476 != 1111.0 && gd_476 != 2211.0) {
               g_dbl2str_564 = DoubleToStr(gd_476, Digits);
               gs_572 = DoubleToStr(gd_612, 2) + " Lots at " + g_dbl2str_564 + " (waiting)";
            } else gs_572 = DoubleToStr(gd_612, 2) + " Lots at " + g_dbl2str_564 + " (target reached!)";
            if (gd_484 != 1122.0 && gd_484 != 2222.0) {
               g_dbl2str_580 = DoubleToStr(gd_484, Digits);
               gs_588 = DoubleToStr(gd_620, 2) + " Lots at " + g_dbl2str_580 + " (waiting)";
            } else gs_588 = DoubleToStr(gd_620, 2) + " Lots at " + g_dbl2str_580 + " (target reached!)";
            if (gd_492 != 1133.0 && gd_492 != 2233.0) {
               g_dbl2str_596 = DoubleToStr(gd_492, Digits);
               gs_604 = DoubleToStr(gd_628, 2) + " Lots at " + g_dbl2str_596 + " (waiting)";
            } else gs_604 = DoubleToStr(gd_628, 2) + " Lots at " + g_dbl2str_596 + " (target reached!)";
            if (OrderType() == OP_BUY) {
               ld_60 = ld_28 / (gi_352 * Point);
               ld_68 = ld_52 / (gi_352 * Point);
            } else {
               ld_60 = ld_36 / (gi_352 * Point);
               ld_68 = ld_44 / (gi_352 * Point);
            }
            if (gd_508 >= 0.0 && UseTP_By_Batch) ls_76 = DoubleToStr(gd_636, 2) + " lots / " + DoubleToStr(TP_1st_Batch_Pips, 0) + " pips" + " (" + DoubleToStr(ld_60, 2) + ")";
            else ls_76 = DoubleToStr(gd_636, 2) + " lots / " + DoubleToStr(TP_1st_Batch_Pips, 0) + " pips" + " (Yes!)";
            if (gd_516 >= 0.0 && UseTP_By_Batch) ls_84 = DoubleToStr(gd_644, 2) + " lots / " + DoubleToStr(TP_2nd_Batch_Pips, 0) + " pips" + " (" + DoubleToStr(ld_60, 2) + ")";
            else ls_84 = DoubleToStr(gd_644, 2) + " lots / " + DoubleToStr(TP_2nd_Batch_Pips, 0) + " pips" + " (Beautiful!)";
            if (gd_524 >= 0.0 && UseTP_By_Batch) ls_92 = DoubleToStr(gd_652, 2) + " lots / " + DoubleToStr(TP_3rd_Batch_Pips, 0) + " pips" + " (" + DoubleToStr(ld_60, 2) + ")";
            else ls_92 = DoubleToStr(gd_652, 2) + " lots / " + DoubleToStr(TP_3rd_Batch_Pips, 0) + " pips" + " (Fantastic! Go Go Go!)";
            if (gd_532 >= 0.0 && UseLoss_by_Batch) ls_100 = DoubleToStr(gd_660, 2) + " lots / " + DoubleToStr(Loss_1st_Batch_Pips, 0) + " pips" + " (" + DoubleToStr(ld_68, 2) + ")";
            else ls_100 = DoubleToStr(gd_660, 2) + " lots / " + DoubleToStr(Loss_1st_Batch_Pips, 0) + " pips" + " (Ouch!)";
            if (gd_540 >= 0.0 && UseLoss_by_Batch) ls_108 = DoubleToStr(gd_668, 2) + " lots / " + DoubleToStr(Loss_2nd_Batch_Pips, 0) + " pips" + " (" + DoubleToStr(ld_68, 2) + ")";
            else ls_108 = DoubleToStr(gd_668, 2) + " lots / " + DoubleToStr(Loss_2nd_Batch_Pips, 0) + " pips" + " (Oh Man!)";
            if (gd_548 >= 0.0 && UseLoss_by_Batch) ls_116 = DoubleToStr(gd_676, 2) + " lots / " + DoubleToStr(Loss_3rd_Batch_Pips, 0) + " pips" + " (" + DoubleToStr(ld_68, 2) + ")";
            else ls_116 = DoubleToStr(gd_676, 2) + " lots / " + DoubleToStr(Loss_3rd_Batch_Pips, 0) + " pips" + " (Sucks Big Time!)";
            if (gi_364 && UseNoLossAfterPips) l_dbl2str_124 = "Active";
            else l_dbl2str_124 = DoubleToStr(ld_60, 2);
            if (UseTP_By_Batch && gd_476 == 5555.0) ls_76 = "No level in sight";
            if (UseTP_By_Batch && gd_484 == 5555.0) ls_84 = "No level in sight";
            if (UseTP_By_Batch && gd_492 == 5555.0) ls_92 = "No level in sight";
            if (!UseTP_By_Batch) {
               ls_76 = "Disabled";
               ls_84 = "Disabled";
               ls_92 = "Disabled";
            }
            if (!UseLoss_by_Batch) {
               ls_100 = "Disabled";
               ls_108 = "Disabled";
               ls_116 = "Disabled";
            }
            if (!UsePivots_for_TP) {
               gs_572 = "Disabled";
               gs_588 = "Disabled";
               gs_604 = "Disabled";
            }
            if (!UseNoLossAfterPips) l_dbl2str_124 = "Disabled";
            if (UsePivots_for_TP) {
               ls_132 = "\n\nProfit by Pivot Target 1 = " + gs_572 
                  + "\nProfit by Pivot Target 2 = " + gs_588 
               + "\nProfit by Pivot Target 3 = " + gs_604;
            } else ls_132 = "";
            if (UseTP_By_Batch) {
               ls_140 = "\n\nProfit by Batch 1 = " + ls_76 
                  + "\nProfit by Batch 2 = " + ls_84 
               + "\nProfit by Batch 3 = " + ls_92;
            } else ls_140 = "";
            if (UseLoss_by_Batch) {
               ls_148 = "\n\nLoss by Batch 1 = " + ls_100 
                  + "\nLoss by Batch 2 = " + ls_108 
               + "\nLoss by Batch 3 = " + ls_116;
            } else ls_148 = "";
            if (UseNoLossAfterPips) ls_156 = "\n\nCapital Protection = " + NoLossAfterPips + " pips (" + l_dbl2str_124 + ")";
            else ls_156 = "";
            if (UseTrailiingStop && !gi_504) ls_164 = "\n\n@ Classic Trailing Stop = " + Trailing_Stop_Pips + " pips (" + DoubleToStr(ld_60, 2) + ")";
            else {
               if (UseTrailiingStop) ls_164 = "\n\nClassic Trailing Stop = " + Trailing_Stop_Pips + " pips (" + DoubleToStr(ld_60, 2) + ")";
               else ls_164 = "";
            }
            if (UseTrailPriceByPercentage && gi_504) ls_172 = "\n@ Advance Trailing Stop = " + PercentageTrailBehindPrice + "% of profit after " + MinPipsToActivate + " pips (" + DoubleToStr(ld_60, 2) + ")";
            else {
               if (UseTrailPriceByPercentage) ls_172 = "\nAdvance Trailing Stop = " + PercentageTrailBehindPrice + "% of profit after " + MinPipsToActivate + " pips (" + DoubleToStr(ld_60, 2) + ")";
               else ls_172 = "";
            }
            Comment("THV CaveManager EA on " + AccountCompany() + " (" + Digits + " digits)" 
            + "\nPosition: " + gs_556 + " (SL " + StopLoss + " pips ,TP " + TakeProfit + " pips)" + ls_132 + ls_140 + ls_148 + ls_156 + ls_164 + ls_172);
         }
      }
   }
}

int orderclosebuy(int a_pos_0, double a_ord_lots_4) {
   int l_ticket_20;
   double l_ord_lots_24;
   bool l_ord_close_32;
   double l_bid_36;
   int l_error_44;
   string l_symbol_12 = Symbol();
   if (OrderSelect(a_pos_0, SELECT_BY_POS, MODE_TRADES)) {
      if (a_ord_lots_4 > OrderLots()) a_ord_lots_4 = OrderLots();
      l_ticket_20 = OrderTicket();
      OrderSelect(l_ticket_20, SELECT_BY_TICKET, MODE_TRADES);
      l_ord_lots_24 = a_ord_lots_4;
      l_bid_36 = MarketInfo(l_symbol_12, MODE_BID);
      RefreshRates();
      l_ord_close_32 = OrderClose(l_ticket_20, l_ord_lots_24, l_bid_36, Slippage * gi_352, Blue);
      if (!l_ord_close_32) {
         l_error_44 = GetLastError();
         Print("Error closing order : (", l_error_44, ") ", ErrorDescription(l_error_44));
      }
   }
   return (l_ord_close_32);
}

int orderclosesell(int a_pos_0, double a_ord_lots_4) {
   int l_ticket_20;
   double l_ord_lots_24;
   bool l_ord_close_32;
   double l_ask_36;
   int l_error_44;
   string l_symbol_12 = Symbol();
   if (OrderSelect(a_pos_0, SELECT_BY_POS, MODE_TRADES)) {
      if (a_ord_lots_4 > OrderLots()) a_ord_lots_4 = OrderLots();
      l_ticket_20 = OrderTicket();
      OrderSelect(l_ticket_20, SELECT_BY_TICKET, MODE_TRADES);
      l_ord_lots_24 = a_ord_lots_4;
      l_ask_36 = MarketInfo(l_symbol_12, MODE_ASK);
      RefreshRates();
      l_ord_close_32 = OrderClose(l_ticket_20, l_ord_lots_24, l_ask_36, Slippage * gi_352, Red);
      if (!l_ord_close_32) {
         l_error_44 = GetLastError();
         Print("Error closing order : (", l_error_44, ") ", ErrorDescription(l_error_44));
      }
   }
   return (l_ord_close_32);
}

void TrailingPositions() {
   double l_price_4;
   for (int l_pos_0 = 0; l_pos_0 < OrdersTotal(); l_pos_0++) {
      if (OrderSelect(l_pos_0, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderSymbol() == Symbol()) {
         if (OrderType() == OP_BUY) {
            if (Trailing_Stop_Pips > 0) {
               if (Bid - OrderOpenPrice() > Point * gi_352 * Trailing_Stop_Pips) {
                  if (OrderStopLoss() < Bid - Point * gi_352 * Trailing_Stop_Pips) {
                     if (Use_Preceding_TP) l_price_4 = Bid + Preceding_TP_Pips * (Point * gi_352);
                     else l_price_4 = OrderTakeProfit();
                     OrderModify(OrderTicket(), OrderOpenPrice(), Bid - Point * gi_352 * Trailing_Stop_Pips, l_price_4, 0, CLR_NONE);
                     return;
                  }
               }
            }
         }
         if (OrderType() == OP_SELL) {
            if (Trailing_Stop_Pips > 0) {
               if (OrderOpenPrice() - Ask > Point * gi_352 * Trailing_Stop_Pips) {
                  if (OrderStopLoss() > Ask + Point * gi_352 * Trailing_Stop_Pips) {
                     if (Use_Preceding_TP) l_price_4 = Ask - Preceding_TP_Pips * (Point * gi_352);
                     else l_price_4 = OrderTakeProfit();
                     OrderModify(OrderTicket(), OrderOpenPrice(), Ask + Point * gi_352 * Trailing_Stop_Pips, l_price_4, 0, CLR_NONE);
                     return;
                  }
               }
            }
         }
      }
   }
}

void TrailingByPercentage() {
   double l_ord_open_price_4;
   double ld_12;
   double ld_20;
   double ld_28;
   double ld_36;
   bool l_bool_44;
   int l_error_48;
   double l_price_52;
   for (int l_pos_0 = 0; l_pos_0 < OrdersTotal(); l_pos_0++) {
      if (OrderSelect(l_pos_0, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderSymbol() == Symbol()) {
         l_ord_open_price_4 = OrderOpenPrice();
         ld_12 = Bid - l_ord_open_price_4;
         ld_20 = l_ord_open_price_4 - Ask;
         ld_28 = ld_12 / (gi_352 * Point);
         ld_36 = ld_20 / (gi_352 * Point);
         if (ld_28 >= MinPipsToActivate && OrderType() == OP_BUY) {
            if (OrderStopLoss() < Bid - PercentageTrailBehindPrice / 100.0 * ld_12) {
               if (Use_Preceding_TP) l_price_52 = Bid + Preceding_TP_Pips * (Point * gi_352);
               else l_price_52 = OrderTakeProfit();
               l_bool_44 = OrderModify(OrderTicket(), OrderOpenPrice(), NormalizeDouble(Bid - PercentageTrailBehindPrice / 100.0 * ld_12, Digits), l_price_52, 0, CLR_NONE);
               if (!l_bool_44) {
                  l_error_48 = GetLastError();
                  Print("Error closing order : (", l_error_48, ") ", ErrorDescription(l_error_48));
               }
            }
         }
         if (ld_36 >= MinPipsToActivate && OrderType() == OP_SELL) {
            if (OrderStopLoss() > Ask + PercentageTrailBehindPrice / 100.0 * ld_20) {
               if (Use_Preceding_TP) l_price_52 = Ask - Preceding_TP_Pips * (Point * gi_352);
               else l_price_52 = OrderTakeProfit();
               l_bool_44 = OrderModify(OrderTicket(), OrderOpenPrice(), NormalizeDouble(Ask + PercentageTrailBehindPrice / 100.0 * ld_20, Digits), l_price_52, 0, CLR_NONE);
               if (!l_bool_44) {
                  l_error_48 = GetLastError();
                  Print("Error closing order : (", l_error_48, ") ", ErrorDescription(l_error_48));
               }
            }
         }
      }
   }
}

void Calculate_Pivot_SR() {
   string ls_unused_84;
   datetime lt_unused_0 = 0;
   datetime lt_unused_4 = 0;
   int li_unused_8 = 0;
   int li_unused_12 = 0;
   double ld_16 = 0;
   double ld_24 = 0;
   double ld_unused_32 = 0;
   double ld_40 = 0;
   double l_open_48 = 0;
   double ld_56 = 0;
   double l_close_64 = 0;
   int li_72 = 0;
   int li_76 = 0;
   int li_80 = 0;
   g_timeframe_700 = Period();
   g_datetime_696 = TimeCurrent();
   if (Period() > PERIOD_D1) {
      Alert("Error - Chart period is greater than 1 day.");
      return;
   }
   ComputeDayIndices(Local__HrsServerTzFromGMT, Destination__HrsNewTZfromGMT, li_72, li_76, li_80);
   lt_unused_0 = Time[li_72];
   lt_unused_4 = Time[li_76];
   ld_40 = -99999;
   ld_56 = 99999;
   for (int li_100 = li_76; li_100 >= li_80; li_100--) {
      if (l_open_48 == 0.0) l_open_48 = Open[li_100];
      ld_40 = MathMax(High[li_100], ld_40);
      ld_56 = MathMin(Low[li_100], ld_56);
      l_close_64 = Close[li_100];
   }
   ld_unused_32 = Open[li_72];
   ld_16 = -99999;
   ld_24 = 99999;
   for (int li_104 = li_72; li_104 >= 0; li_104--) {
      ld_16 = MathMax(ld_16, High[li_104]);
      ld_24 = MathMin(ld_24, Low[li_104]);
   }
   gd_384 = ld_16 - ld_24;
   gd_376 = ld_40 - ld_56;
   gd_368 = (ld_40 + ld_56 + l_close_64) / 3.0;
   if (Show_1Daily_2FibonacciPivots == 1) {
      gd_392 = 2.0 * gd_368 - ld_56;
      gd_400 = gd_368 + (ld_40 - ld_56);
      gd_408 = 2.0 * gd_368 + (ld_40 - 2.0 * ld_56);
      gd_432 = 2.0 * gd_368 - ld_40;
      gd_440 = gd_368 - (ld_40 - ld_56);
      gd_448 = 2.0 * gd_368 - (2.0 * ld_40 - ld_56);
   }
   if (Show_1Daily_2FibonacciPivots == 2) {
      gd_392 = gd_368 + gd_376 / 2.0;
      gd_400 = gd_368 + 0.618 * gd_376;
      gd_408 = gd_368 + gd_376;
      gd_416 = gd_368 + 1.618 * gd_376;
      gd_424 = gd_368 + 2.618 * gd_376;
      gd_440 = gd_368 - 0.618 * gd_376;
      gd_432 = gd_368 - gd_376 / 2.0;
      gd_448 = gd_368 - gd_376;
      gd_456 = gd_368 - 1.618 * gd_376;
      gd_464 = gd_368 - 2.618 * gd_376;
   }
}

void ComputeDayIndices(int ai_0, int ai_4, int &ai_8, int &ai_12, int &ai_16) {
   int li_52;
   int li_60;
   int li_64;
   int li_20 = ai_0 - ai_4;
   int li_24 = 3600 * li_20;
   int li_28 = 1440;
   int li_32 = li_28 / Period();
   int l_day_of_week_36 = TimeDayOfWeek(Time[0] - li_24);
   int li_40 = -1;
   ai_8 = 0;
   ai_12 = 0;
   ai_16 = 0;
   switch (l_day_of_week_36) {
   case 6:
   case 0:
      li_40 = 5;
      break;
   case 1: break;
   default:
      li_40 = l_day_of_week_36 - 1;
   }
   for (int li_48 = 1; li_48 <= li_32 + 1; li_48++) {
      li_52 = Time[li_48] - li_24;
      if (TimeDayOfWeek(li_52) != l_day_of_week_36) {
         ai_8 = li_48 - 1;
         break;
      }
   }
   for (int l_count_56 = 0; l_count_56 <= li_32 * 2 + 1; l_count_56++) {
      li_60 = Time[li_48 + l_count_56] - li_24;
      if (TimeDayOfWeek(li_60) == li_40) {
         ai_16 = li_48 + l_count_56;
         break;
      }
   }
   for (l_count_56 = 1; l_count_56 <= li_32; l_count_56++) {
      li_64 = Time[ai_16 + l_count_56] - li_24;
      if (TimeDayOfWeek(li_64) != li_40) {
         ai_12 = ai_16 + l_count_56 - 1;
         return;
      }
   }
}
