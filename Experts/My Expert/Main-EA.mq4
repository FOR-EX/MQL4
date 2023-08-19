#include <divergence-monitor.mqh>

double newPriceOpening = iOpen(Symbol(), timeFrame, 1);
int currentHour = TimeHour(TimeCurrent());
int currentMinute = TimeMinute(TimeCurrent());
int currentDay = TimeDay(TimeCurrent());
int resistanceLevelCreationTime = currentDay;
int supportLevelCreationTime = currentDay;

bool isTradingTime = false;

void OnTick() {

   currentHour = TimeHour(TimeCurrent());
   currentMinute = TimeMinute(TimeCurrent());
   currentDay = TimeDay(TimeCurrent());
   //run this to see if there is uncleared rsiDivergence....
   runDivergenceMonitor(); 

   //run this to see if it is tradingtime....
   checkTradingTime();
   
   //run the sessionLevelsFinder
   findSessionResistance();
   findSessionSupport();
   Print("This is the current hour:", TimeHour(TimeCurrent()));

   Print("Resistance is:",sessionResistanceArray[0],"Created on:",resistanceLevelCreationTime);
   Print("Support is:",sessionSupportArray[0], "Created on:",supportLevelCreationTime);

   // Print(isDivergence);
   // Print(isTradingTime);
   
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
// custom functions variables
   double sessionResistanceArray [];
   double sessionSupportArray [];
   double sessionResistance = 0;
   double sessionSupport = 999999;
   
// Custom functions

double findSessionResistance(){

   //This is the level reset condition
   if (resistanceLevelCreationTime != currentDay){
      ArrayFree(sessionResistanceArray);
      resistanceLevelCreationTime = currentDay;
      sessionResistance = 0;
   }

   if (currentHour == 14){
      for (int i = 1 ; i <= 5; i++){
         double indexValue = iHigh(Symbol(),timeFrame,i);
         if(indexValue > sessionResistance){
            sessionResistance = indexValue;
         }
         ArrayResize(sessionResistanceArray,1);
         ArrayFill(sessionResistanceArray,0,1,sessionResistance);  
         resistanceLevelCreationTime = currentDay;
      }  
   }
} 

double findSessionSupport(){

   //This is the level reset condition
   if (supportLevelCreationTime != currentDay){
      ArrayFree(sessionSupportArray);
      supportLevelCreationTime = currentDay;
      sessionSupport = 999999;
   }

   if (currentHour == 14){
      for (int i = 1 ; i <= 5; i++){
         double indexValue = iLow(Symbol(),timeFrame,i);
         if(indexValue < sessionSupport){
            sessionSupport = indexValue;
         }
         ArrayResize(sessionSupportArray,1);
         ArrayFill(sessionSupportArray,0,1,sessionSupport);  
         supportLevelCreationTime = currentDay;
      } 
   }
} 

bool checkTradingTime(){
   if (currentHour > 15 && currentHour < 23){
      return isTradingTime = true;
   } else {
      return isTradingTime = false;
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