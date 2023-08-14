
int initialArray = 100;
int initialPeaksArray = 1;
int startingIndex = 0;
double lastHighest = 50;  //this is the initial highest
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
double indexValue;

void OnTick() {
   for (int i=0; i<100;i++){
      indexValue = iRSI(Symbol(),60,14,PRICE_CLOSE,(i+1));
      ArrayResize(rsiArray,initialArray);
      ArrayFill(rsiArray,i,1,indexValue);
               
   }

   for (int j=100; j>=0; j--){
      thirdRsi = rsiArray[j+2];
      lastRsi = rsiArray[j+1];
      newRsi = rsiArray[j];         
      bool isBullish = false;
      bool isBearish = false;
      bool bullishReset = false;
      bool bearishReset = false;

      if(newRsi >= 50){              
         bearishReset = true;
         bullishReset = false;
         isBearish = false;
         isBullish = true;                           
         //Impliment a function that pushes an bullishArray...
         addBullishArray();   
      }

      if (isBullish){
         //This the condition for newPeaks...
         if(lastRsi > thirdRsi && newRsi < lastRsi){
            newPeak = lastRsi;
            addPeaks();
         //Impliment a function that checks if it's a new high...
            rsi_IsNewHigh();
         }
         
      }
      
      if (newRsi < 50) {
         bullishReset = true;
         bearishReset = false;
         isBullish =false;
         isBearish = true;
         resetBullishArray();
      }
      
      if (isBearish){

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
      Print(bullPeaks[startingIndex], "is not a new  high...");
      return false;
   }
}


double addPeaks(){

   ArrayResize(bullPeaks,initialPeaksArray);
   ArrayFill(bullPeaks,startingIndex,1,newPeak);
   //Print("bullPeaks are" , bullPeaks[startingIndex]); 
   initialPeaksArray = initialPeaksArray++;
   startingIndex = startingIndex++;
}

double addBullishArray(){
   for (int i=0; i<100 ;i++){
      indexValue = newRsi;
      ArrayResize(bullishRsiArray,initialArray);
      ArrayFill(bullishRsiArray,i,1,indexValue);
   }
}

double addBearishArray(){
   for (int i=0; i<=1 ;i++){
      indexValue = newRsi;
      ArrayResize(bearishRsiArray, initialArray);
      ArrayFill(bullishRsiArray,i,1,indexValue);
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
       //Alert("Reset Sucessful"); 
   }

double resetBearishArray () {
      for (int i=0; i<100;i++){
      ArrayFree(bearishRsiArray);
      } 
   }
