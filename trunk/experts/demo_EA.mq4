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
int errorcode;
int Error = OrderSend(Symbol(), OP_BUY, 1, Ask, 3, 0, 0, "M1", 3300221, 0, Blue);
            if (Error < 0) {
               errorcode = GetLastError();
               Print("Error BUY (", errorcode, ") : ", ErrorDescription(errorcode));
            } else {
               PlaySound("alert.wav");
               Print("**** BUY LastQQECross = ");
             
            }
   
//----
   return(0);
  }
//+------------------------------------------------------------------+