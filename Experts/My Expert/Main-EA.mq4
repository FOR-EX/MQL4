#include <divergence-monitor.mqh>
#include <session-levels-marker.mqh>
#include <engulfing-detector.mqh>

void OnTick() {
   engulferTimeFrame = 60; //Update the timeframe from engulferTimeFrame
   divergenceMonitorTimeFrame =60; //Update the timeframe from divergenceMonitor
   sessionLevelTimeFrame = 60; //Update the timeframe from sessionLevelMarker

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
   if (isBullishEngulfing()){
      Print ("there is a bullish engulfing going on and the base is:", bullishEngulfingBase);
   }
   if (isBearishEngulfing()){
      Print ("there is a bearish engulfing going on and the head is:", bearishEngulfingHead);
   }
   
   //Condition to place an order
   if(!isDivergence && isTradingTime){
      double newPriceOpening = iOpen(Symbol(), engulferTimeFrame, 1);
      //this is the condition for placing order during bullish conditions
      /*if(newPriceOpening > sessionResistance && isBullishEngulfing() && bullishEngulfingBase > highestHighonBullBreak){
         placeBullishOrder();
         }      
      */
      //this is the condition for placing order during bullish conditions
      /*if(newPriceOpening < sessionSupport && isBearishEngulfing && bearishEngulfingHead < lowestLowonBearBreak){
         placeBearishOrder();
         }
      
      */
   }     
}

//This is a lotsize calculator
   // double stOpinPips = span*100;
   // double riskPerpips = (riskInUsd/stOpinPips);
   // double lOtz = riskInUsd/stOpinPips*Ask/normalLot;