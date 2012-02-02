//+------------------------------------------------------------------+
//|                                               Moving Average.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#define MAGICMA  20050610

extern double Lots               = 0.1;
extern double MaximumRisk        = 0.02;
extern double DecreaseFactor     = 3;
//input parameters for custom indicator nonlagdat.ex4
extern int     CountBars      =158;
extern int     Price          = 0;
extern int     Length         = 60;
extern int     Displace       = 0;
extern int     Filter         = 5;
extern int     Color          = 1;
extern int     ColorBarBack   = 0;
extern double  Deviation      = 0;    

bool       bEntry=False;
double      Cycle =  4;
int      handle=-1;

//+------------------------------------------------------------------+
//| Calculate open positions                                         |
//+------------------------------------------------------------------+
int CalculateCurrentOrders(string symbol)
  {
   int buys=0,sells=0;
//----
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MAGICMA)
        {
         if(OrderType()==OP_BUY)  buys++;
         if(OrderType()==OP_SELL) sells++;
        }
     }
//---- return orders volume
   if(buys>0) return(buys);
   else       return(-sells);
  }
//+------------------------------------------------------------------+
//| Calculate optimal lot size                                       |
//+------------------------------------------------------------------+
double LotsOptimized()
  {
   double lot=Lots;
   int    orders=HistoryTotal();     // history orders total
   int    losses=0;                  // number of losses orders without a break
//---- select lot size
   lot=NormalizeDouble(AccountFreeMargin()*MaximumRisk/1000.0,1);
//---- calcuulate number of losses orders without a break
   if(DecreaseFactor>0)
     {
      for(int i=orders-1;i>=0;i--)
        {
         if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false) { Print("Error in history!"); break; }
         if(OrderSymbol()!=Symbol() || OrderType()>OP_SELL) continue;
         //----
         if(OrderProfit()>0) break;
         if(OrderProfit()<0) losses++;
        }
      if(losses>1) lot=NormalizeDouble(lot-lot*losses/DecreaseFactor,1);
     }
//---- return lot size
   if(lot<0.1) lot=0.1;
   return(lot);
  }
//+------------------------------------------------------------------+
//| Check for open order conditions                                  |
//+------------------------------------------------------------------+
void CheckForOpen()
  {
   double trend_shift1,trend_shift2;
   int    res;
   
   int    i,shift, counted_bars=IndicatorCounted(),limit;
   double alfa, beta, t, Sum, Weight, step,g;
   double pi = 3.1415926535;

   double Coeff =  3*pi;
   int Phase = Length-1;
   double Len = Length*Cycle + Phase;  
       FileWriteInteger(handle,shift);

   
//   if (CountBars>=158) CountBars=158;
   
   if ( counted_bars > 0 )  limit=CountBars-counted_bars;
   if ( counted_bars < 0 )  return(0);
   if ( counted_bars ==0 )  limit=CountBars-Len-1; 
   if ( counted_bars < 1 ) 
   {
  
   }
   
   for(shift=limit;shift>=0;shift--) 
   {	
      trend_shift1=iCustom(NULL,0,"nonlagdot",Price,Length,Displace,Filter,Color,ColorBarBack,Deviation,1,i+1);
      trend_shift2=iCustom(NULL,0,"nonlagdot",Price,Length,Displace,Filter,Color,ColorBarBack,Deviation,2,i+2);
      
      FileWriteInteger(handle,shift);
      if( trend_shift2<0 && trend_shift1>0 )
      {
	     //   Message = " "+Symbol()+" M"+Period()+": Signal for BUY";
	     //   if ( SoundAlertMode>0 ) Alert (Message); 
        //	 UpTrendAlert=true; DownTrendAlert=false;
         for(i=0;i<OrdersTotal();i++)
         {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)        break;
            if(OrderMagicNumber()!=MAGICMA || OrderSymbol()!=Symbol()) continue;
    
         }
         if(bEntry&&(OrderType()==OP_SELL))
         {
            OrderClose(OrderTicket(),OrderLots(),Bid,3,White);
         }
         res=OrderSend(Symbol(),OP_BUY,1,Ask,3,0,0,"",MAGICMA,0,Blue);
         bEntry=true;
         return;
	   } 
	   
      if( trend_shift2>0 && trend_shift1<0 )
      {
         for( i=0;i<OrdersTotal();i++)
         {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)        break;
            if(OrderMagicNumber()!=MAGICMA || OrderSymbol()!=Symbol()) continue;
         }
            
         if(bEntry&&(OrderType()==OP_BUY))
         {
            OrderClose(OrderTicket(),OrderLots(),Bid,3,White);
         }
            
         res=OrderSend(Symbol(),OP_SELL,1,Bid,3,0,0,"",MAGICMA,0,Red);
         bEntry=true;
         return;
      } 	         
   }
}
//+------------------------------------------------------------------+
//| Check for close order conditions                                 |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Start function                                                   |
//+------------------------------------------------------------------+
void start()
  {
     handle=FileOpen("mydata",FILE_BIN|FILE_WRITE);
   if(handle<1) 
   {
      Print("can't find file!",GetLastError());
      return (false);
   }
 //  if(CalculateCurrentOrders(Symbol())==0) 
   CheckForOpen();
   
    FileFlush(handle);  
    FileClose(handle);


  }
//+------------------------------------------------------------------+