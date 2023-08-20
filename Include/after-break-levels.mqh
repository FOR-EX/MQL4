#include <session-levels-marker.mqh>
#include <engulfing-detector.mqh>

double newHighestHighonBullBreak = 0;
double lowestLowonBearBreak = 999999;
int afterBreakLevelsTimeframe;
double afterBreakPriceArrays [];
bool isBullBreak;
bool isBearBreak;
int initialAfterBreakLevelsArray = 0;

double runAfterBreakLevels(){
   isBreak();

   double newPriceAfterBreak = iClose(Symbol(),afterBreakLevelsTimeframe,1);
   if(isBullBreak) {
      //push afterBreakPriceArrays
      ArrayResize(afterBreakPriceArrays, initialAfterBreakLevelsArray);
      ArrayFill(afterBreakPriceArrays,initialAfterBreakLevelsArray-1,1,newPriceAfterBreak);

   }
}





bool isBreak (){

   if (iOpen(Symbol(),engulferTimeFrame,1) > sessionResistance){
      Print("isBreak");
      initialAfterBreakLevelsArray++;
      return isBullBreak = true;
   } else {
      return isBullBreak =false;
   }

   if (iOpen(Symbol(),engulferTimeFrame,1) < sessionSupport){
      Print("isBreak");
      return isBearBreak = true;
      initialAfterBreakLevelsArray++;
   } else {
      return isBearBreak = false;
   }
   if (!isBearBreak && !isBullBreak){
      initialAfterBreakLevelsArray = 0;
      ArrayFree(afterBreakPriceArrays);
   }
}


double resetTheAfterBreakLevels(){
   if (!isTradingTime){
      newHighestHighonBullBreak = 0;
      lowestLowonBearBreak = 999999;
   }
}