#include <after-break-levels.mqh>
#include <session-levels-marker.mqh>
#include <engulfing-detector.mqh>

int placeOrderTimeframe;

//This is a lotsize calculator
   // double stOpinPips = span*100;
   // double riskPerpips = (riskInUsd/stOpinPips);
   // double lOtz = riskInUsd/stOpinPips*Ask/normalLot;
double bullStopLoss;
double bullTakeProfit;
double bullLotSize;


void calculateBullLotSize(){
    bullLotSize = 0;
}

void placeBullishOrder(){
    //OrderSend(Symbol(),OP_BUY,bullLotSize,Ask,1,bullStopLoss,bullTakeProfit,NULL,0,0,clrAquamarine);
}

void createBullishFibo(){
    double startPoint = iClose(Symbol(), placeOrderTimeframe, 2); // You can modify this based on your preference
    double endPoint = iClose(Symbol(), placeOrderTimeframe, 1); // You can modify this based on your preference
    ObjectCreate(0, "FibonacciRetracement", OBJ_FIBO, 0, Time[2], startPoint, Time[1], endPoint);
}

// void deleteBullishFibo(){

// }