    int sessionLevelTimeFrame;
//  On Start
    int currentHour = TimeHour(TimeCurrent());
    int currentMinute = TimeMinute(TimeCurrent());
    int currentDay = TimeDay(TimeCurrent());
    int resistanceLevelCreationTime = currentDay;
    int supportLevelCreationTime = currentDay;

    bool isTradingTime = false;
// custom functions variables
    double sessionResistanceArray [];
    double sessionSupportArray [];
    double sessionResistance = 0;
    double sessionSupport = 999999;
   
// Custom functions

int runningTime(){
    currentHour = TimeHour(TimeCurrent());
    currentMinute = TimeMinute(TimeCurrent());
    currentDay = TimeDay(TimeCurrent());
}

double findSessionResistance(){

   //This is the level reset condition
   if (resistanceLevelCreationTime != currentDay){
      ArrayFree(sessionResistanceArray);
      resistanceLevelCreationTime = currentDay;
      sessionResistance = 0;
   }

   if (currentHour == 14){
      for (int i = 1 ; i <= 5; i++){
         double indexValue = iHigh(Symbol(),sessionLevelTimeFrame,i);
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
         double indexValue = iLow(Symbol(),sessionLevelTimeFrame,i);
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
   if (currentHour >=14 && currentHour < 22){
      if (currentHour == 14 && currentMinute <= 30){
         return isTradingTime = false;
      }
      return isTradingTime = true;
   } else {
      return isTradingTime = false;
   }
}