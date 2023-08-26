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

    int namE;
    int intSessionSupportlabelCreated = 0;
    int intSessionRessistancelabelCreated = 0;
    
   
// Custom functions

void runningTime(){
    currentHour = TimeHour(TimeCurrent());
    currentMinute = TimeMinute(TimeCurrent());
    currentDay = TimeDay(TimeCurrent());
}

void findSessionResistance(){

   //This is the level reset condition
   if (resistanceLevelCreationTime != currentDay){
      ArrayFree(sessionResistanceArray);
      resistanceLevelCreationTime = currentDay;
      sessionResistance = 0;
   }

   if (currentHour == 14 && currentMinute == 0){
      for (int i = 1 ; i <= 5; i++){
         double indexValue = iHigh(Symbol(),sessionLevelTimeFrame,i);
         if(indexValue > sessionResistance){
            sessionResistance = indexValue;
            int index = i;
         }
         ArrayResize(sessionResistanceArray,1);
         ArrayFill(sessionResistanceArray,0,1,sessionResistance);
         resistanceLevelCreationTime = currentDay;
         namE = NormalizeDouble((sessionResistance*Bid),1);
         Print(namE);
         string SessionRessistancelabelCreated = IntegerToString(namE,0);
      }
      ObjectCreate(0,SessionRessistancelabelCreated, OBJ_ARROW_RIGHT_PRICE, 0, Time[index], sessionResistance); 
   }
} 

void findSessionSupport(){

   //This is the level reset condition
   if (supportLevelCreationTime != currentDay){
      ArrayFree(sessionSupportArray);
      supportLevelCreationTime = currentDay;
      sessionSupport = 999999;
      
   }

   if (currentHour == 14 && currentMinute == 0){
      for (int i = 1 ; i <= 5; i++){
         double indexValue = iLow(Symbol(),sessionLevelTimeFrame,i);
         if(indexValue < sessionSupport){
            sessionSupport = indexValue;
            int index = i;
         }
         ArrayResize(sessionSupportArray,1);
         ArrayFill(sessionSupportArray,0,1,sessionSupport);
         supportLevelCreationTime = currentDay;
         namE = NormalizeDouble((sessionSupport*Bid),1);
         Print(namE);
         string SessionSupportlabelCreated = IntegerToString(namE,0);
       
      }
      ObjectCreate(0,SessionSupportlabelCreated, OBJ_ARROW_RIGHT_PRICE, 0, Time[index], sessionSupport);    
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