//+------------------------------------------------------------------+
//|           AsctrendBuySellExpert_v1.4.mq4  code by Newdigital     |
//|                                     http://www.forex-tsd.com     |
//|                using Gordago software http://www.gordago.com     |
//| - Asctrend code for this EA was taken from                       |
//|   AscTrend_NonLag EA coded by of Igorad.                         |
//| - "Non-Trading Hours" on the screen fixing code by Locutus       |
//|   from Updated DayTradingMM EA                                   |
//+------------------------------------------------------------------+
#property copyright "newdigital"
#property link      "http://www.forex-tsd.com"

extern int MAGIC  = 100111;

extern string PARAMETERS_EXPERT = "PARAMETERS EXPERT";
extern color clOpenBuy = Blue;
extern color clCloseBuy = Aqua;
extern color clOpenSell = Red;
extern color clCloseSell = Violet;
extern color clModiBuy = Blue;
extern color clModiSell = Red;
extern string Name_Expert = "AsctrendBuySellExpert";
extern bool UseSound = False;
extern string NameFileSound = "alert.wav";

extern string PARAMETERS_FILTER = "PARAMETERS FILTER";
extern bool UseHourTrade = False;
extern int FromHourTrade = 8;
extern int ToHourTrade = 18;


extern string PARAMETERS_TRADE = "PARAMETERS TRADE";
extern double Lots = 1;
extern int Slippage = 4;
extern double lStopLoss = 1000;
extern double sStopLoss = 1000;
extern double lTakeProfit = 70;
extern double sTakeProfit = 70;
extern double lTrailingStop = 1000;
extern double sTrailingStop = 1000;

extern string PARAMETERS_INDICATOR_ONE  = "ASCTrend";
extern bool    UseASCtrend    = True;
extern int     RISK           = 12;

extern string PARAMETERS_INDICATOR_TWO  = "Parabolic SAR";
extern double    Step=0.005;
extern double    Maximum=0.02;

extern string PARAMETERS_INDICATOR_THREE = "Stochastic";
extern int KPeriod=14;
extern int DPeriod=5;
extern int Slowing=5;

extern string PARAMETERS_INDICATOR_FOUR = "PriceChannel_Stop";
extern int    ChannelPeriod=     9; //Price Channel Period
extern double Risk         =  0.30; //Channel narrowing factor (0...0,5)
extern int    TrailingMode =     0;

int asctrend,asctrend1;
int ASCtrend,ASCtrend1;

void deinit() {
   Comment("");
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start(){
   if (UseHourTrade){
   if((Hour()>=FromHourTrade)&&(Hour()<=ToHourTrade))
      Comment("Trading Hours");
   else
     {
      Comment("Non-trading Hours");
      return(0);
     }
   }
   if(Bars<100){
      Print("bars less than 100");
      return(0);
   }
   if(lStopLoss<10){
      Print("StopLoss less than 10");
      return(0);
   }
   if(lTakeProfit<10){
      Print("TakeProfit less than 10");
      return(0);
   }
   if(sStopLoss<10){
      Print("StopLoss less than 10");
      return(0);
   }
   if(sTakeProfit<10){
      Print("TakeProfit less than 10");
      return(0);
   }
   
   if (UseASCtrend)
{
ASCtrend = ASCTrend(RISK);
bool ASCtrendBuy  = ASCtrend>0 && ASCtrend1<0;  
bool ASCtrendSell = ASCtrend<0 && ASCtrend1>0;
} 
else {ASCtrendBuy = true; ASCtrendSell = true;}

   double diSAR6=iSAR(NULL,0,Step,Maximum,1);
   double diSAR7=iSAR(NULL,0,Step,Maximum,0);
   double diStochastic4=iStochastic(NULL,0,KPeriod,DPeriod,Slowing,MODE_EMA,PRICE_CLOSE,MODE_MAIN,0);
   double diStochastic5=iStochastic(NULL,0,KPeriod,DPeriod,Slowing,MODE_EMA,PRICE_CLOSE,MODE_SIGNAL,0);
   double d22=(30);
   double d23=(70);
   if(TrailingMode > 0){
   double pcTrend = iCustom(NULL,0,"PriceChannel_Stop_v1.3",ChannelPeriod,Risk,0,0,0,0,6,1);
   double UpStop = iCustom(NULL,0,"PriceChannel_Stop_v1.3",ChannelPeriod,Risk,0,0,0,0,0,1);
   double DnStop = iCustom(NULL,0,"PriceChannel_Stop_v1.3",ChannelPeriod,Risk,0,0,0,0,1,1);}
   
   if(AccountFreeMargin()<(1000*Lots)){
      Print("We have no money. Free Margin = ", AccountFreeMargin());
      return(0);
   }
   if (!ExistPositions()){

      if ((ASCtrendBuy) && diSAR6<diSAR7 && diStochastic4<d23){
         OpenBuy();
         return(0);
      }

      if ((ASCtrendSell && diSAR6>diSAR7 && diStochastic4>d22)){
         OpenSell();
         return(0);
      }
   }
   if (ExistPositions()){
      if(OrderType()==OP_BUY){

         if ((ASCtrendSell)){
            CloseBuy();
            return(0);
         }
      }
      if(OrderType()==OP_SELL){

         if ((ASCtrendBuy)){
            CloseSell();
            return(0);
         }
      }
   }
   if(TrailingMode>0){
   TrailingPositionsBuy(UpStop);
   TrailingPositionsSell(DnStop);}
   else {
   TrailingPositionsBuy(lTrailingStop);
   TrailingPositionsSell(sTrailingStop);}
   ASCtrend1=ASCtrend;
   return (0);
}

bool ExistPositions() {
	for (int i=0; i<OrdersTotal(); i++) {
		if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
			if (OrderSymbol()==Symbol() && OrderMagicNumber()==MAGIC) {
				return(True);
			}
		} 
	} 
	return(false);
}
void TrailingPositionsBuy(double trailingStop) { 

   for (int i=0; i<OrdersTotal(); i++) { 
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) { 
         if (OrderSymbol()==Symbol() && OrderMagicNumber()==MAGIC) { 
            if (OrderType()==OP_BUY) {
            double minstop = MarketInfo(Symbol(),MODE_STOPLEVEL)+5;
            if(TrailingMode > 0) double ts = trailingStop;
            else ts = Bid-trailingStop*Point;    
            ts = NormalizeDouble(ts,Digits);
               if(ts <  Bid && ts > Bid - minstop*Point) {ts = Bid - minstop*Point;}
               else if(ts > Bid) ts = OrderStopLoss();
               if (OrderOpenPrice()<ts) { 
               //Print("TS=",ts," Bid=",Bid," minTS=", Bid - minstop*Point," min=",minstop);
                  if (OrderStopLoss()<ts) 
                     ModifyStopLoss(ts); 
               } 
            } 
         } 
      } 
   } 
} 
void TrailingPositionsSell(double trailingStop) {

   for (int i=0; i<OrdersTotal(); i++) { 
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) { 
         if (OrderSymbol()==Symbol() && OrderMagicNumber()==MAGIC) { 
            if (OrderType()==OP_SELL) {
            double minstop = MarketInfo(Symbol(),MODE_STOPLEVEL)+5; 
            if(TrailingMode > 0) double ts = trailingStop;
            else ts = Ask+trailingStop*Point;       
            ts = NormalizeDouble(ts,Digits);
               if(ts > Ask && ts < Ask + minstop*Point) {ts = Ask + minstop*Point;}
               else if(ts < Ask) ts = OrderStopLoss();  
               if (OrderOpenPrice()>ts) {
               //Print("TS=",ts," ASK=",Ask," minTS=", Ask + minstop*Point," min=",minstop); 
                  if (OrderStopLoss()>ts)  
                     ModifyStopLoss(ts); 
               } 
            } 
         } 
      } 
   } 
} 
void ModifyStopLoss(double ldStopLoss) { 
   bool fm;
   fm = OrderModify(OrderTicket(),OrderOpenPrice(),ldStopLoss,OrderTakeProfit(),0,CLR_NONE); 
   if (fm && UseSound) PlaySound(NameFileSound); 
} 

void CloseBuy() { 
   bool fc; 
   fc=OrderClose(OrderTicket(), OrderLots(), Bid, Slippage, clCloseBuy); 
   if (fc && UseSound) PlaySound(NameFileSound); 
} 
void CloseSell() { 
   bool fc; 
   fc=OrderClose(OrderTicket(), OrderLots(), Ask, Slippage, clCloseSell); 
   if (fc && UseSound) PlaySound(NameFileSound); 
} 
void OpenBuy() { 
   double ldLot, ldStop, ldTake; 
   string lsComm; 
   ldLot = GetSizeLot(); 
   ldStop = GetStopLossBuy(); 
   ldTake = GetTakeProfitBuy(); 
   lsComm = GetCommentForOrder(); 
   OrderSend(Symbol(),OP_BUY,ldLot,Ask,Slippage,ldStop,ldTake,lsComm,MAGIC,0,clOpenBuy); 
   if (UseSound) PlaySound(NameFileSound); 
} 
void OpenSell() { 
   double ldLot, ldStop, ldTake; 
   string lsComm; 

   ldLot = GetSizeLot(); 
   ldStop = GetStopLossSell(); 
   ldTake = GetTakeProfitSell(); 
   lsComm = GetCommentForOrder(); 
   OrderSend(Symbol(),OP_SELL,ldLot,Bid,Slippage,ldStop,ldTake,lsComm,MAGIC,0,clOpenSell); 
   if (UseSound) PlaySound(NameFileSound); 
} 
string GetCommentForOrder() { 	return(Name_Expert); } 
double GetSizeLot() { 	return(Lots); } 
double GetStopLossBuy() { 	return (Bid-lStopLoss*Point);} 
double GetStopLossSell() { 	return(Ask+sStopLoss*Point); } 
double GetTakeProfitBuy() { 	return(Ask+lTakeProfit*Point); } 
double GetTakeProfitSell() { 	return(Bid-sTakeProfit*Point); }

int ASCTrend( int risk )
{

   double smin, smax, bsmin, bsmax;
   int len = 3 + 2*risk;
   
   smin=Low[Lowest(NULL,0,MODE_LOW,len,1)]; 
   smax=High[Highest(NULL,0,MODE_HIGH,len,1)];

   bsmax = smax-(smax - smin)*(33.0-risk)/100.0;
   bsmin = smin+(smax - smin)*(33.0-risk)/100.0;

   asctrend = asctrend1;
   
   if(Close[1]>bsmax)  asctrend= 1; 
   if(Close[1]<bsmin)  asctrend=-1;
   
   asctrend1 = asctrend;
  return(asctrend);
}    

