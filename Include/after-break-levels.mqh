#include <session-levels-marker.mqh>
#include <engulfing-detector.mqh>

//double lastHighestPeak [];

int afterBreakLevelsTimeframe;
bool isBullBreak;
bool isBearBreak;

double bullishBreakPriceArrays [];
int initialAfterBullBreakLevelsArray = 0;
int lastHighestPeakIndex = 0;
double lastHighestPeakValue;

double bearishBreakPriceArrays [];
int initialAfterBearBreakLevelsArray = 0;
int lastLowestLowIndex = 0;
double lastLowestLowValue = 999999;

//push bullishBreakPriceArrays Function
double pushBullishBreakPriceArrays (){
   if(isBullBreak) {
      double newPriceAfterBreak = iOpen(Symbol(),afterBreakLevelsTimeframe,1);
      ArrayResize(bullishBreakPriceArrays, initialAfterBullBreakLevelsArray);
      ArrayFill(bullishBreakPriceArrays,initialAfterBullBreakLevelsArray-1,1,newPriceAfterBreak);
   }
}

   //Establish the last highest peak
double establishLastHighestPeak(){
   if(currentHour == 14 && currentMinute <= 31 && isBullBreak){    
         lastHighestPeakIndex = ArrayMaximum(bullishBreakPriceArrays, WHOLE_ARRAY, 0);
         lastHighestPeakValue = bullishBreakPriceArrays[lastHighestPeakIndex];
   } 
}

   //Update the last high
double updateLastHigh(){
   lastHighestPeakIndex = ArrayMaximum(bullishBreakPriceArrays, WHOLE_ARRAY, 0);
   lastHighestPeakValue = bullishBreakPriceArrays [lastHighestPeakIndex];
   
}


bool checkForBullBreaks (){
   if (iOpen(Symbol(),afterBreakLevelsTimeframe,1) > sessionResistance && currentHour >=14 && currentHour <= 22){
      Print("isBullishBreak");
      initialAfterBullBreakLevelsArray++;
      return isBullBreak = true;
   } else {
      return isBullBreak =false;
   }
}
bool checkForBearBreaks(){
   if (iOpen(Symbol(),afterBreakLevelsTimeframe,1) < sessionSupport && currentHour >=14 && currentHour <= 22){
      Print("isBearishBreak");
      initialAfterBearBreakLevelsArray++;
      return isBearBreak = true;
   } else {
      return isBearBreak = false;
   }   
}

//push bearishBreakPriceArrays Function
double pushBearishBreakPriceArrays (){
   if(isBearBreak) {
      double newPriceAfterBreak = iOpen(Symbol(),afterBreakLevelsTimeframe,1);
      ArrayResize(bearishBreakPriceArrays, initialAfterBearBreakLevelsArray);
      ArrayFill(bearishBreakPriceArrays,initialAfterBearBreakLevelsArray-1,1,newPriceAfterBreak);
   }
}

//Establish the last lowest low
double establishLastLastLowestLow(){
   if(isBearBreak){    
         lastLowestLowIndex = ArrayMinimum(bearishBreakPriceArrays, WHOLE_ARRAY, 0);
         lastLowestLowValue = bearishBreakPriceArrays[lastLowestLowIndex];
   } 
}

//Update the last low
double updateLastLow(){
   lastLowestLowIndex = ArrayMinimum(bearishBreakPriceArrays, WHOLE_ARRAY, 0);
   lastLowestLowValue = bearishBreakPriceArrays[lastLowestLowIndex];
   
}


double resetTheAfterBreakLevels(){
   initialAfterBullBreakLevelsArray = 0;
   ArrayFree(bullishBreakPriceArrays);
   lastHighestPeakValue = 0;

   initialAfterBearBreakLevelsArray = 0;
   ArrayFree(bearishBreakPriceArrays);
   lastLowestLowValue = 999999;
}