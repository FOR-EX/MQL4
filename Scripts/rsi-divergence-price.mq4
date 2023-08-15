int timeFrame = 60; //60 minutes
int initialArray = 100;
double indexValue;
double priceArray [];
double thirdPrice;
double lastPrice;
double newPrice;

void OnStart (){

    for (int i=0; i<100;i++){        
        indexValue = iClose(Symbol(), 60, (i+1));
        ArrayResize(priceArray,initialArray);
        ArrayFill(priceArray,i,1,indexValue);                       
    }

    for (int j=100; j>=0; j--){
      thirdPrice = priceArray[j+2];
      lastPrice = priceArray[j+1];
      newPrice = priceArray[j];
      Print(priceArray[j]);  
    }

    //We need a function that deletes previous bearishPricesArray(s)...
    //We need a function that pushes an bullishPricesArray...
}