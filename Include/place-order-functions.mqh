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


double calculateBullLotSize(){
    bullLotSize = 0;
}

double placeBullishOrder(){
    OrderSend(Symbol(),OP_BUY,bullLotSize,Ask,1,bullStopLoss,bullTakeProfit,NULL,0,0,clrAquamarine);
}