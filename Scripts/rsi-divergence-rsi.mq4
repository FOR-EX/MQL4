
int timeFrame = 60; //60 minutes
int initialArray = 100;
int initialRsiPeaksArray = 1;
int startingRsiIndex = 0;
double lastHighestRsi = 50;  //this is the initial highest Rsi
double lastLowestRsi = 50;    //this is the initial lowest Rsi
double rsiArray[];
double bullishRsiArray[];
double bearishRsiArray[];
double newRsiPeak;
double newRsiLow; 
double bullRsiPeaks [];
double bearRsiPeaks [];
double thirdRsi;
double lastRsi;
double newRsi;
double indexValueRsi;
//Price vars
double indexValuePrice;
double priceArray [];
int initialPricePeaksArray = 1;
int startingPriceIndex = 0;

double bullishPriceArray[];
double bearishPriceArray[];
double newPricePeak;
double newPriceLow; 
double bullPricePeaks [];
double bearPricePeaks [];
double thirdPrice;
double lastPrice;
double newPrice;



void OnStart() {

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
         resetBearishRsiArray();                           
         //Impliment a function that pushes an bullishRsiArray...
         addBullishRsiArray();
         //function that pushes a bullishPriceArray...
         addBullishPriceArray();  
      }

      if (isBullish){
         //This the condition for newRsiPeaks...
         if(lastRsi > thirdRsi && newRsi < lastRsi){
            newRsiPeak = lastRsi;
            newPricePeak = lastPrice;
         //Impliment a function that pushes bullRsiPeaks...            
            addBullRsiPeaks();
         //Impliment a function that pushes bullPricePeaks...
            addBullPricePeaks();
         //Impliment a function that checks if it's a new high...
            IsNewRsiHigh();
            IsNewPriceHigh();
         }
         
      }
      
      if (newRsi < 50) {
         bullishReset = true;
         bearishReset = false;
         isBullish =false;
         isBearish = true;
         //Impliment a function that deletes previous bullishArray's...
         resetBullishRsiArray();
         //Impliment a function that pushes an bearishArray...
         addBearishRsiArray();
      }
      
      if (isBearish){
         ////This the condition for newRsiLows...
         if(lastRsi<thirdRsi && newRsi > lastRsi){
            newRsiLow = lastRsi;
         //Impliment a function that pushes bearRsiPeaks...
            addBearRsiPeaks();
         //Impliment a function that checks if it's a new low...
            isNewRsiLow();

         }
      }
   }    
}


//CUSTOM FUNCTIONS
bool IsNewPriceHigh(){
   //if(bullPricePeaks[startingPriceIndex] > las)
}

bool IsNewRsiHigh(){
   if(bullRsiPeaks[startingRsiIndex] > lastHighestRsi){
      lastHighestRsi = bullRsiPeaks[startingRsiIndex];
      Print("This is the last highest:", lastHighestRsi);
      return true;      
   } else {
      Print(bullRsiPeaks[startingRsiIndex], "- is not a new  high...");
      return false;
   }
}

bool isNewRsiLow(){
   if(bearRsiPeaks[startingRsiIndex] < lastLowestRsi){
      lastLowestRsi = bearRsiPeaks[startingRsiIndex];
      Print("This is the last lowest", lastLowestRsi);
      return true;
   } else {
      Print(bearRsiPeaks[startingRsiIndex], "- is not a new low");
      return false;
   }
}

double addBullPricePeaks(){
   ArrayResize(bullPricePeaks, initialPricePeaksArray);
   ArrayFill(bullPricePeaks, startingPriceIndex, 1, newPricePeak);
   initialPricePeaksArray = initialPricePeaksArray++;
   startingPriceIndex = startingPriceIndex++;
}

double addBullRsiPeaks(){

   ArrayResize(bullRsiPeaks,initialRsiPeaksArray);
   ArrayFill(bullRsiPeaks,startingRsiIndex,1,newRsiPeak);
   //Print("bullRsiPeaks are" , bullRsiPeaks[startingRsiIndex]); 
   initialRsiPeaksArray = initialRsiPeaksArray++;
   startingRsiIndex = startingRsiIndex++;
}

double addBearRsiPeaks(){
   ArrayResize(bearRsiPeaks, initialArray);
   ArrayFill(bearRsiPeaks, startingRsiIndex, 1, newRsiLow);
   //Print("bearRsiPeaks are" , bearRsiPeaks[startingRsiIndex]);
   initialRsiPeaksArray = initialRsiPeaksArray++;
   startingRsiIndex = startingRsiIndex++;
}

double addBullishPriceArray(){
   for (int i=0; i<100 ; i++){
      indexValuePrice = newPrice;
      ArrayResize(bullishPriceArray, initialArray);
      ArrayFill(bullishPriceArray, i, 1,indexValuePrice);
      Print(indexValuePrice);
   }
}

double addBullishRsiArray(){
   for (int i=0; i<100 ;i++){
      indexValueRsi = newRsi;
      ArrayResize(bullishRsiArray,initialArray);
      ArrayFill(bullishRsiArray,i,1,indexValueRsi);
   }
}

double addBearishRsiArray(){
   for (int i=0; i<100 ;i++){
      indexValueRsi = newRsi;
      ArrayResize(bearishRsiArray, initialArray);
      ArrayFill(bearishRsiArray,i,1,indexValueRsi);
   }
}

double resetBullishRsiArray () {
       ArrayFree(bullishRsiArray);
       lastHighestRsi = 50;
       startingRsiIndex = 0;
       initialRsiPeaksArray = 1;
       //Alert("Reset Sucessful"); 
   }

double resetBearishRsiArray () {
      ArrayFree(bearishRsiArray);
      lastLowestRsi = 50;
      startingRsiIndex = 0;
      initialRsiPeaksArray = 1;
   }
