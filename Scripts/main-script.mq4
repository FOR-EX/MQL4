#include <divergence-monitor.mqh>

double newPriceOpening = iOpen(Symbol(), timeFrame, 1);
int currentHour = TimeHour(TimeCurrent());
int currentMinute = TimeMinute(TimeCurrent());

bool isTradingTime = false;

void OnStart() {
   //check if there is an unsettled divergence in the past...

   //runDivergenceMonitor(); //run this to see if there is uncleared rsiDivergence....
   checkTradingTime(); //run this to see if it is tradingtime....
   //run the sessionLevelsFinder

   findSessionResistance();
   findSessionSupport();

   // Print(isDivergence);
   // Print(isTradingTime);
   
   //Condition to place an order
   if(!isDivergence && isTradingTime){

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

// Custom functions

double findSessionResistance(){
   double indexValue;
   double sessionResistance = 0;
   if (currentHour == 9){
      for (int i = 1 ; i <= 7; i++){
         indexValue = iHigh(Symbol(),timeFrame,i);
         Print("index value",i,"is:",indexValue);
         if(indexValue > sessionResistance){
            sessionResistance = indexValue;
         }
      } 
   }
   Print("session Resistance is:",sessionResistance);
} 

double findSessionSupport(){
   double indexValue;
   double sessionSupport = 999999;
   if (currentHour == 9){
      for (int i = 1 ; i <= 7; i++){
         indexValue = iLow(Symbol(),timeFrame,i);
         Print("index value",i,"is:",indexValue);
         if(indexValue < sessionSupport){
            sessionSupport = indexValue;
         }
      } 
   }
   Print("session Support is:",sessionSupport);
} 



bool checkTradingTime(){
   if (currentHour > 15 && currentHour < 23){
      return isTradingTime = true;
   } else {
      return isTradingTime = false;
   }
}
