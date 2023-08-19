int engulferTimeFrame;

//bearish-engulfing-detector
bool isBearishEngulfing (){
   
   if (isLastCandleBull() && isNewCandleBear() && isNewCandleBearishEngulfer()){
      return true;
   } else {
      return false;
   }
}

bool isNewCandleBearishEngulfer(){
   double lastOpeningCandle = iOpen(Symbol(), engulferTimeFrame,2);
   double newClosingCandle = iClose(Symbol(),engulferTimeFrame,1);

   if(newClosingCandle < lastOpeningCandle){
      return true;
   } else {
      return false;
   }
}

bool isLastCandleBull(){
   double lastOpeningCandle = iOpen(Symbol(), engulferTimeFrame,2);
   double lastClosingCandle = iClose(Symbol(),engulferTimeFrame,2);
   
   if (lastClosingCandle > lastOpeningCandle){
      return true;
   } else {
      return false;
   }
}

bool isNewCandleBear(){
   double newOpeningCandle = iOpen(Symbol(), engulferTimeFrame,1);
   double newClosingCandle = iClose(Symbol(),engulferTimeFrame,1);
   if(newClosingCandle < newOpeningCandle){
      return true;
   } else {
      return false;
   }
}


