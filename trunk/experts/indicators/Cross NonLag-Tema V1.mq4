//+------------------------------------------------------------------+
//|                                            Cross NonLag-TEMA.mq4 |
//|                                        Copyright © 2010, IND-PC  |
//|                                        http://www.IND-PC.com     |
//+------------------------------------------------------------------+
#property copyright "Aaron Peterson - IND-PC 2010"
#property link      "http://www.ind-pc.com"

extern   int        TEMAPeriod=14;
extern   double     LotSize = 0.5;
extern   int        Magic = 1010;

static int step = 0;
static double fallBack = 0.0;

string upperComment = "";
int numOfBars = 0;
datetime lastTime=0;
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   
//----
   start();  

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
   
//----

string lastTimeString = TimeToStr(lastTime, TIME_SECONDS);
upperComment = "";
double NoLag = iCustom(NULL, 0, "NonLagMA", 0,0);
double NoLagPrev = iCustom(NULL, 0, "NonLagMA", 0, 1);
double Tema = iCustom(NULL, 0, "TEMA", TEMAPeriod, 0, 0);
double NoLagUp = iCustom(NULL, 0, "NonLagMA", 1, 0);
double NoLagDown = iCustom(NULL, 0, "NonLagMA", 2, 0);
//double SSLUp = iCustom(NULL, 0, "SSL", LookBack, 0, LBTimeFrame, 0, 0);
//double SSLDn = iCustom(NULL, 0, "SSL", LookBack, 0, LBTimeFrame, 1, 0);

int ticket, found = 0;
double orderSize;

CheckFallBack();

if(Tema > NoLag)
{
   if(NoLagUp == NoLag && Ask > NoLag && NoLagPrev < NoLag)// && SSLUp != EMPTY_VALUE)
   {
      //Buy
      
      for(int i=0; i<OrdersTotal(); i++)
      {
         if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == true && OrderMagicNumber() == Magic)
         {
            if(OrderSymbol()== Symbol())
            {
               found++;
               ticket = OrderTicket();
               orderSize = OrderLots();
               if(OrderType() == 1)
               {
                  OrderClose(ticket, orderSize, Bid, 2);
               }
            }
         }
      }
      if(found==0)
      {
         if(lastTime == iTime(Symbol(), 60, 1))
         {
            return(0);
         }
         int tickBuy = OrderSend(Symbol(), OP_BUY, LotSize, Ask, 3, 0, 0,"Buy", Magic, 0, Red);
         if(tickBuy < 0)
         {
            Print("Order Buy Failed");
         }
         
      } 
      
      upperComment = upperComment + "Buy" + " : LastBarTime = " + lastTimeString + " : FallBack = $" + fallBack;  
   }   
   else
   {
      //Close Positions
     // CloseOrders();      
   }
}
else if(Tema < NoLag )
{
   if(NoLagDown == NoLag && NoLag > Bid && NoLagPrev > NoLag)// && SSLDn != EMPTY_VALUE)
   {
      //Sell
      found = 0;
      for(i=0; i<OrdersTotal(); i++)
      {
        if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == true && OrderMagicNumber() == Magic)
        {
            if(OrderSymbol()== Symbol())
            {
              found++;
              ticket = OrderTicket();
              orderSize = OrderLots();
              if(OrderType() ==0)
              {
                OrderClose(ticket, orderSize, Ask, 2);
              }
            }
         }
       }
       if(found == 0)
       {
       if(lastTime == iTime(Symbol(), 60, 1))
      {
         return(0);
      }
         int tickSell = OrderSend(Symbol(), OP_SELL,LotSize, Bid, 3, 0, 0, "Sell", Magic, 0, Blue);
         if(tickSell < 0)
         {
            Print("Order Sell Failed");
         }
         
       }
       upperComment = upperComment + "Sell" + " : LastBarTime = " + lastTimeString + " : FallBack = $" + fallBack;
   }
   else
   {
     //Close Positions 
     //CloseOrders();
     fallBack = 0.0;
   }
}
   //Alert(GetLastError());
   Comment(upperComment);
   lastTime = iTime(Symbol(), 60, 1);
   return(0);
  }
//+------------------------------------------------------------------+

void CloseOrders()
{
for(int i=0; i<OrdersTotal(); i++)
      {
         if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == true && OrderMagicNumber() == Magic)
         {
            if(OrderSymbol()!= Symbol())
            {
               continue;
            }
            int ticket = OrderTicket();
            double orderSize = OrderLots();
            
            switch (OrderType())
            {
               case 0:
                  OrderClose(ticket, orderSize, Bid, 2);
                  break;
                  
               case 1:
                  OrderClose(ticket, orderSize, Ask, 2);
                  break;
            }
            upperComment  = upperComment + " : " + "Close";
             
         }
      }
}

void CheckFallBack()
{

   for(int i=0; i<OrdersTotal(); i++)
      {
        if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == true && OrderMagicNumber() == Magic)
        {
            if(OrderSymbol()== Symbol())
            {
               if(fallBack > 0.0)
               {
                  if(OrderProfit() <= fallBack)
                  {
                     CloseOrders();
                     fallBack = 0.0;
                     return(0);
                  }
               }
              double checkFallBack = (MathFloor(OrderProfit()/(OrderLots() * 100)) - 1) * (OrderLots() * 100);
              if(checkFallBack > fallBack)
              {
               fallBack = checkFallBack;
              }
            }
         }
       }
}