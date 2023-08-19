int engulferTimeFrame;

bool isBullishEngulfing (){
   
   if (isLastCandleBear() && isNewCandleBull() && isNewCandleEngulfer()){
      return true;
   } else {
      return false;
   }
}

bool isNewCandleEngulfer(){
   double lastOpeningCandle = iOpen(Symbol(), engulferTimeFrame,2);
   double newClosingCandle = iClose(Symbol(),engulferTimeFrame,1);

   if(newClosingCandle > lastOpeningCandle){
      return true;
   } else {
      return false;
   }
}

bool isLastCandleBear(){
   double lastOpeningCandle = iOpen(Symbol(), engulferTimeFrame,2);
   double lastClosingCandle = iClose(Symbol(),engulferTimeFrame,2);
   
   if (lastClosingCandle < lastOpeningCandle){
      return true;
   } else {
      return false;
   }
}

bool isNewCandleBull(){
   double newOpeningCandle = iOpen(Symbol(), engulferTimeFrame,1);
   double newClosingCandle = iClose(Symbol(),engulferTimeFrame,1);
   if(newClosingCandle > newOpeningCandle){
      return true;
   } else {
      return false;
   }
}
