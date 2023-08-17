#include <divergence-monitor.mqh>

void OnStart() {

   runDivergenceMonitor();
   
   Print(isDivergence);
   //Condition to place an order
   if(!isDivergence){
      //this is the condition for placing order during bullish conditions
      /*if(newOpeningPrice > sessionResistance && bullishEngulfing && bullishEngulfingBase > highestHighonBullBreak){
         placeBullishOrder();
         }      
      */
      //this is the condition for placing order during bullish conditions
      /*if(newOpeningPrice < sessionSupport && bearishEngulfing && bearishEngulfingHead < lowestLowonBearBreak){
         placeBearishOrder();
         }
      
      */
   }    
}



