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
     Print("���� #12470 ���۸�", OrderOpenPrice());
     Print("���� #12470 ���̼۸� ", OrderClosePrice());
    }
  else
    Print("OrderSelect ���صĴ��� ",GetLastError());



   
//----
   return(0);
  }
//+------------------------------------------------------------------+