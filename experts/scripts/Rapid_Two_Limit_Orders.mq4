//+------------------------------------------------------------------+
//|                                       Rapid Two Limit Orders.mq4 |
//|                                                          Dhalsim |
//|                                      http://hi.baidu.com/dhalsim |
//+------------------------------------------------------------------+
#include <stdlib.mqh>
#property copyright "Dhalsim"
#property link      "http://hi.baidu.com/dhalsim"
extern string EnterPriceAndLots = "==== Enter Order Price And Lots Below ====";
extern double OrderPrice;
extern double  OrderLotSize  = 0.1;
extern string TakeProfitByPips = "==== TakeProfit by Pips ====";
extern int TakeProfit1=40;
extern int TakeProfit2=0;
extern string TakeProfitByPrice = "==== TakeProfit by Price ====";
extern double TPLevel1=0;
extern double TPLevel2=0;
extern string StopLossByPips = "==== StopLoss by Pips ====";
extern int StopLoss=40;
#property show_inputs
double SL, TP1, TP2;
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
//----
   int ticket;
//----

if (OrderPrice<Ask)
{
   while(true)
     {
      if (TPLevel1==0 && TakeProfit1!=0) TP1=OrderPrice+TakeProfit1*Point;
      else TP1=TPLevel1;

      if (TPLevel2==0 && TakeProfit2!=0) TP2=OrderPrice+TakeProfit2*Point;
      else TP2=TPLevel2;
      
      ticket=OrderSend(Symbol(),OP_BUYLIMIT,OrderLotSize,OrderPrice,3,OrderPrice-StopLoss*Point,TP1,"Rapid Two Limit Orders",19540123,0,Blue);
      Sleep(500);
      
      ticket=OrderSend(Symbol(),OP_BUYLIMIT,OrderLotSize,OrderPrice,3,OrderPrice-StopLoss*Point,TP2,"Rapid Two Limit Orders",19540123,0,Blue);
      Sleep(500);
      if(ticket<=0)
        {
         int error=GetLastError();
         Print("Error = ",ErrorDescription(error));
         if(error==134) break;            // Account balance is too low
         if(error==135) RefreshRates();   // Prices have changed above the slippage
         break;
        }
      //---- De-init break statement an resume
      else { OrderPrint(); break; }
      //---- 10 seconds wait
      Sleep(10000);
     }
} 

if (OrderPrice>Bid)
{
   while(true)
     {
      if (TPLevel1==0 && TakeProfit1!=0) TP1=OrderPrice-TakeProfit1*Point;
      else TP1=TPLevel1;

      if (TPLevel2==0 && TakeProfit2!=0) TP2=OrderPrice-TakeProfit2*Point;
      else TP2=TPLevel2;

      ticket=OrderSend(Symbol(),OP_SELLLIMIT,OrderLotSize,OrderPrice,3,OrderPrice+StopLoss*Point,TP1,"Rapid Two Limit Orders",19540123,0,Blue);
      Sleep(500);
      ticket=OrderSend(Symbol(),OP_SELLLIMIT,OrderLotSize,OrderPrice,3,OrderPrice+StopLoss*Point,TP2,"Rapid Two Limit Orders",19540123,0,Blue);
      Sleep(500);
      if(ticket<=0)
        {
         error=GetLastError();
         Print("Error = ",ErrorDescription(error));
         if(error==134) break;            // Account balance is too low
         if(error==135) RefreshRates();   // Prices have changed above the slippage
         break;
        }
      //---- De-init break statement an resume
      else { OrderPrint(); break; }
      //---- 10 seconds wait
      Sleep(10000);
     }
} 

//----
   return(0);
  }
//+------------------------------------------------------------------+