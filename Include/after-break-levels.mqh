#include <session-levels-marker.mqh>
#include <engulfing-detector.mqh>

//double lastHighestPeak [];

int afterBreakLevelsTimeframe;
double bullishBreakPriceArrays [];
bool isBullBreak;
bool isBearBreak;
int initialAfterBreakLevelsArray = 0;
int initialHighestPeakAray = 0;
int lastHighestPeakIndex = 0;
double lastHighestPeakValue;



//push bullishBreakPriceArrays Function
double pushBullishBreakPriceArrays (){
   if(isBullBreak && isTradingTime) {
      double newPriceAfterBreak = iOpen(Symbol(),afterBreakLevelsTimeframe,1);
      ArrayResize(bullishBreakPriceArrays, initialAfterBreakLevelsArray);
      ArrayFill(bullishBreakPriceArrays,initialAfterBreakLevelsArray-1,1,newPriceAfterBreak);
   }
}


double establishLastHighestPeak(){
   //Establish the last highest peak
   if(currentHour == 14 && currentMinute <= 31 && isBullBreak){    
         lastHighestPeakIndex = ArrayMaximum(bullishBreakPriceArrays, WHOLE_ARRAY, 0);
         lastHighestPeakValue = bullishBreakPriceArrays[lastHighestPeakIndex];
   } 
}

double updateLastHigh(){
   lastHighestPeakIndex = ArrayMaximum(bullishBreakPriceArrays, WHOLE_ARRAY, 0);
   lastHighestPeakValue = bullishBreakPriceArrays [lastHighestPeakIndex];
   
}


bool checkForBreaks (){

   if (iOpen(Symbol(),afterBreakLevelsTimeframe,1) > sessionResistance && currentHour >=14 && currentHour <= 23){
      Print("isBullishBreak");
      initialAfterBreakLevelsArray++;
      return isBullBreak = true;
   } else {
      return isBullBreak =false;
   }

   if (iOpen(Symbol(),afterBreakLevelsTimeframe,1) < sessionSupport && currentHour >=14 && currentHour <= 23){
      Print("isBearishBreak");
      return isBearBreak = true;
      initialAfterBreakLevelsArray++;
   } else {
      return isBearBreak = false;
   }
}


double resetTheAfterBreakLevels(){
   initialAfterBreakLevelsArray = 0;
   ArrayFree(bullishBreakPriceArrays);
   lastHighestPeakValue = 0;
}