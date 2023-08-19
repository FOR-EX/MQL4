#include <divergence-monitor.mqh>
#include <session-levels-marker.mqh>

double newPriceOpening = iOpen(Symbol(), timeFrame, 1);

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

   Print("Resistance is:",sessionResistanceArray[0],"Created on:",resistanceLevelCreationTime);
   Print("Support is:",sessionSupportArray[0], "Created on:",supportLevelCreationTime);

   //Print("0 means no divergence:" , isDivergence);
   Print("0 means not time to trade", isTradingTime);
   
   //Condition to place an order
   if(!isDivergence && isTradingTime){

      //this is the condition for placing order during bullish conditions
      /*if(newPriceOpening > sessionResistance && isbullishEngulfing && bullishEngulfingBase > highestHighonBullBreak){
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

// bool isBullishEngulfing(){
//    bool lastCandleIsBear;
//    bool newCandleisBull;
//    bool newCloseisEngulfer;
//    if(lastCandleIsBear && newCandleisBull && newCloseisEngulfer){
//       return true;
//    } else {
//       return false;
//    }
// }

//This is a lotsize calculator
   // double stOpinPips = span*100;
   // double riskPerpips = (riskInUsd/stOpinPips);
   // double lOtz = riskInUsd/stOpinPips*Ask/normalLot;