#include <divergence-monitor.mqh>
#include <session-levels-marker.mqh>
#include <bullish-engulfing-detector.mqh>

int divergenceMonitorTimeFrame = 60; //60 minutes
int sessionLevelTimeFrame = 60;
int engulferTimeFrame = 2; //What engulferTimeFrame - 2minutes

void OnTick() {
   // update the date&time vars on each tick...
   runningTime();

   //run this to see if there is uncleared rsiDivergence....
   runDivergenceMonitor(); 

   //run this to see if it is tradingtime....
   checkTradingTime();
   
   //run the sessionLevelsFinder
   findSessionResistance();
   findSessionSupport();

   // Print("Resistance is:",sessionResistanceArray[0],"Created on:",resistanceLevelCreationTime);
   // Print("Support is:",sessionSupportArray[0], "Created on:",supportLevelCreationTime);

   //Print("0 means no divergence:" , isDivergence);
   //Print("0 means not time to trade", isTradingTime);

   Print ("there is a bullish enguulfing going on:", isBullishEngulfing());

   //Condition to place an order
   if(!isDivergence && isTradingTime){
      double newPriceOpening = iOpen(Symbol(), engulferTimeFrame, 1);
      //this is the condition for placing order during bullish conditions
      /*if(newPriceOpening > sessionResistance && isbBullishEngulfing() && bullishEngulfingBase > highestHighonBullBreak){
         placeBullishOrder();
         }      
      */
      //this is the condition for placing order during bullish conditions
      /*if(newPriceOpening < sessionSupport && isbearishEngulfing && bearishEngulfingHead < lowestLowonBearBreak){
         placeBearishOrder();
         }
      
      */
   }     
}

//This is a lotsize calculator
   // double stOpinPips = span*100;
   // double riskPerpips = (riskInUsd/stOpinPips);
   // double lOtz = riskInUsd/stOpinPips*Ask/normalLot;