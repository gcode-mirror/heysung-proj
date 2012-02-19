//+------------------------------------------------------------------+
//|                                               Moving Average.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#define MAGICMA  20050610

extern double Lots               = 0.1;
extern double MaximumRisk        = 0.02;
extern double DecreaseFactor     = 3;

extern double MovingShift        = 0;
extern double  PeriodFast        =10;
extern double   PeriodSlow       =25;
extern double   PeriodFilter     =120;

bool       bEntry=False;
double      Cycle =  4;
int         handle=-1;

//+------------------------------------------------------------------+
//| Calculate open positions                                         |
//+------------------------------------------------------------------+
int PrintLog(int _handle)
{
}
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
   double uptrend_shift1,uptrend_shift2;
   double dntrend_shift1,dntrend_shift2;
   double   MAFast,MASlow,MAFilter,dev;
   int    res;
   
   int    i,shift, counted_bars,limit;
   Print("error is " ,GetLastError());
     
   MAFast=iMA(NULL,0,PeriodFast,MovingShift,MODE_SMMA,PRICE_CLOSE,1);
   MASlow=iMA(NULL,0,PeriodSlow,MovingShift,MODE_SMMA,PRICE_CLOSE,1);
   MAFilter=iMA(NULL,0,PeriodFilter,MovingShift,MODE_SMA,PRICE_CLOSE,1);
   dev=MathAbs( MAFast-MASlow);
   
   
      
      FileSeek(handle,0,SEEK_END);
      FileWrite(handle,TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS),TimeToStr(TimeLocal(),TIME_DATE|TIME_SECONDS),
                uptrend_shift1,uptrend_shift2,dntrend_shift1,dntrend_shift2);
     
     
      if( MAFast>MASlow&&dev>0.00002)
      {
         for(i=0;i<OrdersTotal();i++)
         {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)        break;
            if(OrderMagicNumber()!=MAGICMA || OrderSymbol()!=Symbol()) continue;
    
         }
         if(bEntry&&OrderType()==OP_SELL)
         {
            OrderClose(OrderTicket(),OrderLots(),Ask,1,White);
            bEntry=False;
         }
        
         
         if(!bEntry&&Close[1]>MAFilter)
         {
            res=OrderSend(Symbol(),OP_BUY,1,Ask,1,0,0,"",MAGICMA,0,Blue);
            bEntry=true;
         }
         
         return;
	   } 
	   
	   if( MAFast<MASlow &&dev>0.00002)
//      if( uptrend_shift1==EMPTY_VALUE&&uptrend_shift2!=EMPTY_VALUE )
      {
         for( i=0;i<OrdersTotal();i++)
         {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)        break;
            if(OrderMagicNumber()!=MAGICMA || OrderSymbol()!=Symbol()) continue;
         }
            
         if(bEntry&&OrderType()==OP_BUY)
         {
            OrderClose(OrderTicket(),OrderLots(),Bid,1,White);
             bEntry=False;
         }
         if(!bEntry&&Close[1]<MAFilter)   
         {
            res=OrderSend(Symbol(),OP_SELL,1,Bid,1,0,0,"",MAGICMA,0,Red);
            bEntry=true;
         }
         
         return;
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
     handle=FileOpen("mydata.txt",FILE_CSV|FILE_READ|FILE_WRITE,",");
   if(handle<1) 
   {
      Print("can't find file!",GetLastError());
      return (false);
   }
   FileWrite(handle,1,2,3);
   Print("current is 2");
 //  if(CalculateCurrentOrders(Symbol())==0) 
   CheckForOpen();
   
    FileFlush(handle);  
    FileClose(handle);


  }
//+------------------------------------------------------------------+