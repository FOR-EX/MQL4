double highestHighonBullBreak = 0;
double lowestLowonBearBreak = 999999;
   
double highestAfterBreak(){  
double newPrice = iClose(Symbol(),engulferTimeFrame,1);
   if(newPrice > highestHighonBullBreak){
      highestHighonBullBreak = newPrice;
   } 
}

double lowestAfterBreak(){
double newPrice = iClose(Symbol(),engulferTimeFrame,1);
   if(newPrice < lowestLowonBearBreak){
      lowestLowonBearBreak = newPrice;
   }
}

double resetTheAfterBreakLevels(){
   if (!isTradingTime){
      highestHighonBullBreak = 0;
      lowestLowonBearBreak = 999999;
   }
}