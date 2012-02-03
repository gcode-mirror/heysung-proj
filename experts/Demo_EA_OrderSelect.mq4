//+------------------------------------------------------------------+
//|                                                      demo_EA.mq4 |
//|                       Copyright ?2011, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+

#include <stdlib.mqh>
#property copyright "Copyright ?2011, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
//----
if(OrderSelect(12470, SELECT_BY_TICKET)==true)
    {
     Print("定单 #12470 开价格", OrderOpenPrice());
     Print("定单 #12470 收盘价格 ", OrderClosePrice());
    }
  else
    Print("OrderSelect 返回的错误 ",GetLastError());



   
//----
   return(0);
  }
//+------------------------------------------------------------------+