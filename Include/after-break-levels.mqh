#include <session-levels-marker.mqh>
#include <engulfing-detector.mqh>

double lastHighestPeak [];
double newHighestPeak [];
double lastLowestLow = 999999;
int afterBreakLevelsTimeframe;
double bullishBreakPriceArrays [];
bool isBullBreak;
bool isBearBreak;
int initialAfterBreakLevelsArray = 0;
int initialHighestPeakAray = 0;
int lastHighestPeakIndex = 0;
double lastHighestPeakValue;
int newHighestPeakIndex;


//push bullishBreakPriceArrays Function
double pushBullishBreakPriceArrays (){
   if(isBullBreak) {
      double newPriceAfterBreak = iClose(Symbol(),afterBreakLevelsTimeframe,1);
      ArrayResize(bullishBreakPriceArrays, initialAfterBreakLevelsArray);
      ArrayFill(bullishBreakPriceArrays,initialAfterBreakLevelsArray-1,1,newPriceAfterBreak);
   }
}

double establishLastHighestPeak(){
   //Establish the last highest peak
   if(currentHour == 14 && currentMinute <= 30 && isBullBreak){    
         lastHighestPeakIndex = ArrayMaximum(bullishBreakPriceArrays, WHOLE_ARRAY, 0);
         lastHighestPeakValue = bullishBreakPriceArrays[lastHighestPeakIndex];
   } 
}

double updateNewHighestPeak () {
   if(isBullBreak) {
      newHighestPeakIndex = ArrayMaximum(bullishBreakPriceArrays, WHOLE_ARRAY, 0);
      double newHighestPeakValue = bullishBreakPriceArrays[newHighestPeakIndex];
      if (newHighestPeakValue > newHighestPeak[initialHighestPeakAray]){
         initialHighestPeakAray ++;
         ArrayResize(newHighestPeak,initialHighestPeakAray);
         ArrayFill(newHighestPeak,initialHighestPeakAray-1,1,newHighestPeakValue);
      }

   }
   
}

// double updateLastHigh(){
//    if(newHighestPeak > lastHighestPeak) {
//       lastHighestPeak = newHighestPeak;
//    }
// }


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
   if (currentHour < 14 && currentHour > 23){
      initialAfterBreakLevelsArray = 0;
      //lastHighestPeak = 0;
      ArrayFree(bullishBreakPriceArrays);
   }
}