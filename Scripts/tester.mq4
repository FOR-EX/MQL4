

int initialArray = 100;
double rsiArray[];
double bullishRsiArray[];
double bearishRsiArray[];
double thirdRsi;
double lastRsi;
double newRsi;
double indexValue;


void OnStart() {
      for (int i=0; i<100;i++){
         indexValue = iRSI(Symbol(),60,14,PRICE_CLOSE,(i+1));
         ArrayResize(rsiArray,initialArray);
         ArrayFill(rsiArray,i,1,indexValue);
                 
   } 
         for (int j=100; j>=0; j--){
            thirdRsi = rsiArray[j+2];
            lastRsi = rsiArray[j+1];
            newRsi = rsiArray[j];
            double lastHighest;
            double newPeak;
            double newLow;            
            bool newPeakNewHighest;
            bool isBullish = false;
            bool isBearish = false;
            bool bullishReset = false;
            bool bearishReset = false;
            
            if(newRsi >= 50){              
               bearishReset = true;
               bullishReset = false;
               isBearish = false;
               isBullish = true;
                           
               //empliment a function that pushes an bullishArray
               addBullishArray();    
            }

            if (isBullish){
               if(lastRsi > thirdRsi && newRsi < lastRsi){
                  newPeak = lastRsi;
                  
               }
               Print("Bearish Reset - RSI is now Bullish. New RSI is", newRsi);
            }
            
            if (newRsi < 50) {
               bullishReset = true;
               bearishReset = false;
               isBullish =false;
               isBearish = true;
               resetBullishArray();

         }
            if(isBearish){
               
            }
      }    
}


//CUSTOM FUNCTIONS

double addBullishArray(){
   for (int i=0; i<100 ;i++){
      indexValue = newRsi;
      ArrayResize(bullishRsiArray,initialArray);
      ArrayFill(bullishRsiArray,i,1,indexValue);
   }
}


double printAllArray(){
   for (int i=0; i<100 ;i++){
      Alert(bullishRsiArray[i]);
   }
}

double addBearishArray(){
   for (int i=0; i<=1 ;i++){
      indexValue = newRsi;
      ArrayResize(bearishRsiArray, initialArray);
      ArrayFill(bullishRsiArray,i,1,indexValue);
   }
}

double resetBullishArray () {
       ArrayFree(bullishRsiArray);
       Alert("Reset Sucessful");
   }

double resetBearishArray () {
      for (int i=0; i<100;i++){
      ArrayFree(bearishRsiArray);
      } 
   }
