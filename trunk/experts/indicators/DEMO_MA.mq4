//+------------------------------------------------------------------+
//|                                                      DEMO_MA.mq4 |
//|                       Copyright ?2011, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright ?2011, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window

#property indicator_buffers 1
#property indicator_color1 Red

 
  double ma[];


int init()
  {
   SetIndexStyle(0,DRAW_LINE,0,2);
   SetIndexBuffer(0,ma);   
 
}
void showid()
{
 double tyujik[10];
    tyujik[0]=tyujik[0]+1;
  Print("Series Array is ",tyujik[0]);
  }
  
int start()
  { 
   showid();
  
  
 //  ma[0] =iMAOnArray(t, 0, 3, 0, MODE_SMA, 0);
 //  ma[1] =iMAOnArray(t, 0, 3, 0, MODE_SMA, 1);
 //  ma[2] =iMAOnArray(t, 0, 3, 0, MODE_SMA, 2);
   return(0);
  }


