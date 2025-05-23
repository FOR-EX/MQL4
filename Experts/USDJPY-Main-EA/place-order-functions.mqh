#include "after-break-levels.mqh"
#include "session-levels-marker.mqh"
#include "engulfing-detector.mqh"

double riskedAmount;
int placeOrderTimeframe;
double takeProfitMultiplier;
//bullOrderVariables
double bullStopLoss;
double bullTakeProfit;
double bullLotSize;

//bearOrderVariables
double bearStopLoss;
double bearTakeProfit;
double bearLotSize;

//vars for fibo...
double Level100;
double Level0;
double Level50;
double Level61_8;
double Level161_8;
double NegativeLevel2; //x2 if the  sl is 161.8 from fibo
double NegativeLevel1_39; //x1.39 if the  sl is 161.8 from fibo


void placeBullishOrder(){
    double currentNumberofOrder = OrdersTotal();
    double currentSpreadValue =  Ask-Bid;
    double stopLossinPips;
    double riskPerPips;
    double contractSize = SymbolInfoDouble(Symbol(), SYMBOL_TRADE_CONTRACT_SIZE);

    if((contractSize == 100000) || (contractSize==1)){
        contractSize = 1000;
    }

    if (!currentNumberofOrder){
        createBullishFibo();
        
        bullStopLoss = Level161_8 - currentSpreadValue;
        stopLossinPips = (Ask - bullStopLoss)*100;
        bullTakeProfit = stopLossinPips/100 * takeProfitMultiplier + Ask;
        riskPerPips = riskedAmount/stopLossinPips;
        bullLotSize = NormalizeDouble(((riskPerPips*Ask)/contractSize),2); //1 if us100 2if usdjpy
        Print("riskPerPips:", riskPerPips);
        Print ("bullLotSize is:", bullLotSize);
        Print("bullTakeProfit:", bullTakeProfit);
        Print("bullStopLoss:",bullStopLoss);
        Print("stopLossinPips:",stopLossinPips);
        Print("currentSpreadValue:",currentSpreadValue);
        Print("Allowed stop level is:", MarketInfo(Symbol(),MODE_STOPLEVEL));
        Print("Minimum Lot Allowed:", MarketInfo(Symbol(),MODE_MINLOT));
        Print("About lot size:", MarketInfo(Symbol(),MODE_LOTSIZE));
        OrderSend(Symbol(),OP_BUY,bullLotSize,Ask,3,bullStopLoss,bullTakeProfit,NULL,0,0,clrAquamarine);
    }
    
}

void createBullishFibo(){
    double startPoint = iClose(Symbol(), placeOrderTimeframe, 2); // You can modify this based on your preference
    double endPoint = iClose(Symbol(), placeOrderTimeframe, 1); // You can modify this based on your preference
    
    ObjectCreate(0, "FibonacciRetracement", OBJ_FIBO, 0, Time[2], startPoint, Time[1], endPoint);

    //get the level values
    Level100 = ObjectGetDouble(0,"FibonacciRetracement", OBJPROP_PRICE, 0);
    Level0 = ObjectGetDouble(0,"FibonacciRetracement", OBJPROP_PRICE, 1);
    Level50=((Level0+Level100)/2);
    Level61_8 = Level0 + (0.618 * (Level100 - Level0));
    Level161_8 = Level0 + (1.618 * (Level100 - Level0));
    NegativeLevel2 = Level0 - (2.0 * (Level161_8 - Level0)); //x2 if the  sl is 161.8 from fibo
    NegativeLevel1_39 = Level0 - (1.39 * (Level161_8 - Level0)); //x1.39 if the  sl is 161.8 from fibo

    Print("Level 0:", Level0 + "\n",
        "Level 50:", Level50 + "\n",
        "Level 100:", Level100 + "\n",
        "Level 161.8:", Level161_8 + "\n",
        "NegativeLevel2:", NegativeLevel2 + "\n",
        "NegativeLevel1_39:",NegativeLevel1_39);
}

void placeBearishOrder(){
    int currentNumberofOrder = OrdersTotal();
    double currentSpreadValue =  Ask-Bid;
    double stopLossinPips;
    double riskPerPips;
    double contractSize = SymbolInfoDouble(Symbol(), SYMBOL_TRADE_CONTRACT_SIZE);

    if((contractSize == 100000) || (contractSize==1)){
        contractSize = 1000;
    }

    if (!currentNumberofOrder){
        createBearishFibo();
        
        bearStopLoss = Level161_8 + currentSpreadValue;
        stopLossinPips = NormalizeDouble(((bearStopLoss - Bid)*100),1);
        bearTakeProfit = (Bid - ((stopLossinPips/100) * takeProfitMultiplier));
        riskPerPips = riskedAmount/stopLossinPips;
        bearLotSize =  NormalizeDouble(((riskPerPips*Bid)/contractSize),2);//1 if us100 2if usdjpy
        Print("riskPerPips:", riskPerPips);
        Print ("bearLotSize is:", bearLotSize);
        Print("bearTakeProfit:", bearTakeProfit);
        Print("bearStopLoss:",bearStopLoss);
        Print("stopLossinPips:",stopLossinPips);
        Print("EntryPrice:", Bid);
        Print("currentSpreadValue:",currentSpreadValue);
        Print("Allowed stop level is:", MarketInfo(Symbol(),MODE_STOPLEVEL));
        Print("Minimum Lot Allowed:", MarketInfo(Symbol(),MODE_MINLOT));
        Print("About lot size:", MarketInfo(Symbol(),MODE_LOTSIZE));
        OrderSend(Symbol(),OP_SELL,bearLotSize,Bid,3,bearStopLoss,bearTakeProfit,NULL,0,0,clrAquamarine);
    }
    
}

void createBearishFibo(){
    double startPoint = iClose(Symbol(), placeOrderTimeframe, 2); // You can modify this based on your preference
    double endPoint = iClose(Symbol(), placeOrderTimeframe, 1); // You can modify this based on your preference
    
    ObjectCreate(0, "FibonacciRetracement", OBJ_FIBO, 0, Time[2], startPoint, Time[1], endPoint);

    //get the level values
    Level100 = ObjectGetDouble(0,"FibonacciRetracement", OBJPROP_PRICE, 0);
    Level0 = ObjectGetDouble(0,"FibonacciRetracement", OBJPROP_PRICE, 1);
    Level50=((Level0+Level100)/2);
    Level61_8 = Level0 + (0.618 * (Level100 - Level0));
    Level161_8 = Level0 + (1.618 * (Level100 - Level0));
    NegativeLevel2 = Level0 - (2.0 * (Level161_8 - Level0)); //x2 if the  sl is 161.8 from fibo
    NegativeLevel1_39 = Level0 - (1.39 * (Level161_8 - Level0)); //x1.39 if the  sl is 161.8 from fibo

    Print("Level 0:", Level0 + "\n",
        "Level 50:", Level50 + "\n",
        "Level 100:", Level100 + "\n",
        "Level61_8", Level61_8 + "\n",
        "Level 161.8:", Level161_8 + "\n",
        "NegativeLevel2:", NegativeLevel2 + "\n",
        "NegativeLevel1_39:",NegativeLevel1_39);
}

void deleteFibo(){
    double currentNumberofOrder = OrdersTotal();
    if(!currentNumberofOrder){
        ObjectDelete(0,"FibonacciRetracement");
    }
}

//This is a lotsize calculator
   // double stOpinPips = span*100;
   // double riskPerpips = (riskInUsd/stOpinPips);
   // double lOtz = riskInUsd/stOpinPips*Ask/normalLot;