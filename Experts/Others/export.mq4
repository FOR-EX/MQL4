
int timeFrame = 1; //60 minutes
int initialArray = 100;
int initialPeaksArray = 1;
int startingIndex = 0;
double lastHighest = 50;  //this is the initial highest
double lastLowest = 50;    //this is the initial lowest
double rsiArray[];
double bullishRsiArray[];
double bearishRsiArray[];
double newPeak;
double newLow; 
double bullPeaks [];
double bearPeaks [];
double thirdRsi;
double lastRsi;
double newRsi;
double indexValueRsi;
//Price vars
double indexValuePrice;
double priceArray [];
double thirdPrice;
double lastPrice;
double newPrice;



void OnTick() {

   for (int i=0; i<100;i++){
      //This is to push rsiArray
      indexValueRsi = iRSI(Symbol(),timeFrame,14,PRICE_CLOSE,(i+1));
         ArrayResize(rsiArray,initialArray);
         ArrayFill(rsiArray,i,1,indexValueRsi);
      //This is to push priceArray
      indexValuePrice = iClose(Symbol(), timeFrame, (i+1));
         ArrayResize(priceArray,initialArray);
         ArrayFill(priceArray,i,1,indexValuePrice);
               
   }

   for (int j=100; j>=0; j--){
      //for RSI
      thirdRsi = rsiArray[j+2];
      lastRsi = rsiArray[j+1];
      newRsi = rsiArray[j];
      //for PRICE
      thirdPrice = priceArray[j+2];
      lastPrice = priceArray[j+1];
      newPrice = priceArray[j];

      bool isBullish = false;
      bool isBearish = false;
      bool bullishReset = false;
      bool bearishReset = false;

      if(newRsi >= 50){              
         bearishReset = true;
         bullishReset = false;
         isBearish = false;
         isBullish = true;
         //Impliment a function that deletes previous bearishArray's...
         resetBearishArray();                           
         //Impliment a function that pushes an bullishArray...
         addBullishArray();   
      }

      if (isBullish){
         //This the condition for newPeaks...
         if(lastRsi > thirdRsi && newRsi < lastRsi){
            newPeak = lastRsi;
         //Impliment a function that pushes bullPeaks...
            addBullPeaks();
         //Impliment a function that checks if it's a new high...
            rsi_IsNewHigh();
         }
         
      }
      
      if (newRsi < 50) {
         bullishReset = true;
         bearishReset = false;
         isBullish =false;
         isBearish = true;
         //Impliment a function that deletes previous bullishArray's...
         resetBullishArray();
         //Impliment a function that pushes an bearishArray...
         addBearishArray();
      }
      
      if (isBearish){
         ////This the condition for newLows...
         if(lastRsi<thirdRsi && newRsi > lastRsi){
            newLow = lastRsi;
         //Impliment a function that pushes bearPeaks...
            addBearPeaks();
         //Impliment a function that checks if it's a new low...
            rsi_isNewLow();

         }
      }
   }    
}


//CUSTOM FUNCTIONS

bool rsi_IsNewHigh(){
   if(bullPeaks[startingIndex] > lastHighest){
      lastHighest = bullPeaks[startingIndex];
      Print("This is the last highest:", lastHighest);
      return true;      
   } else {
      Print(bullPeaks[startingIndex], "- is not a new  high...");
      return false;
   }
}

bool rsi_isNewLow(){
   if(bearPeaks[startingIndex] < lastLowest){
      lastLowest = bearPeaks[startingIndex];
      Print("This is the last lowest", lastLowest);
      return true;
   } else {
      Print(bearPeaks[startingIndex], "- is not a new low");
      return false;
   }
}


double addBullPeaks(){

   ArrayResize(bullPeaks,initialPeaksArray);
   ArrayFill(bullPeaks,startingIndex,1,newPeak);
   //Print("bullPeaks are" , bullPeaks[startingIndex]); 
   initialPeaksArray = initialPeaksArray++;
   startingIndex = startingIndex++;
}

double addBearPeaks(){
   ArrayResize(bearPeaks, initialArray);
   ArrayFill(bearPeaks, startingIndex, 1, newLow);
   //Print("bearPeaks are" , bearPeaks[startingIndex]);
   initialPeaksArray = initialPeaksArray++;
   startingIndex = startingIndex++;
}

double addBullishArray(){
   for (int i=0; i<100 ;i++){
      indexValueRsi = newRsi;
      ArrayResize(bullishRsiArray,initialArray);
      ArrayFill(bullishRsiArray,i,1,indexValueRsi);
   }
}

double addBearishArray(){
   for (int i=0; i<100 ;i++){
      indexValueRsi = newRsi;
      ArrayResize(bearishRsiArray, initialArray);
      ArrayFill(bearishRsiArray,i,1,indexValueRsi);
   }
}

double printAllArray(){
   for (int i=0; i<100 ;i++){
      Alert(bullishRsiArray[i]);
   }
}

double resetBullishArray () {
       ArrayFree(bullishRsiArray);
       lastHighest = 50;
       startingIndex = 0;
       initialPeaksArray = 1;
       //Alert("Reset Sucessful"); 
   }

double resetBearishArray () {
      ArrayFree(bearishRsiArray);
      lastLowest = 50;
      startingIndex = 0;
      initialPeaksArray = 1;
   }
