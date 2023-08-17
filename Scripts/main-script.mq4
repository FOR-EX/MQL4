#include <divergence-monitor.mqh>

double newPriceOpening = iOpen(Symbol(), timeFrame, 1);
int currentHour = TimeHour(TimeCurrent());
int currentMinute = TimeMinute(TimeCurrent());

void OnStart() {
   //check if there is an unsettled divergence in the past...
   runDivergenceMonitor();
   
   
   Print(isDivergence);
   //Condition to place an order
   if(!isDivergence){
      //this is the condition for placing order during bullish conditions
      /*if(newPriceOpening > sessionResistance && bullishEngulfing && bullishEngulfingBase > highestHighonBullBreak){
         placeBullishOrder();
         }      
      */
      //this is the condition for placing order during bullish conditions
      /*if(newPriceOpening < sessionSupport && bearishEngulfing && bearishEngulfingHead < lowestLowonBearBreak){
         placeBearishOrder();
         }
      
      */
   }    
}



