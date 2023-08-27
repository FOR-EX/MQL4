int startIndex = 0;

bool orderPlaced = false;
bool orderClosed = true;
int ticket;

double riskInUsd = AccountBalance()*.277;
double normalLot = 1000; //1000 if normallot 10 if microlot
int shipt = 3;


datetime lastOrderTime;

void OnTick() 
{
    // Check if at least 7 hours have passed since the last trade
    datetime currentTime = TimeCurrent();
    int hoursSinceLastOrder = (currentTime - lastOrderTime) / (60 * 60);
    if (hoursSinceLastOrder < 1) {
        return;
    }

    startIndex = Bars - 1;
    if (orderPlaced) {
        if (OrderSelect(ticket, SELECT_BY_TICKET)) {
            if (OrderCloseTime() != 0) {
                orderPlaced = false;
                orderClosed = true;
                
            }
        }
    }
    
    double stapLossB = iMA(Symbol(), 5, 200, 0, MODE_SMMA, PRICE_CLOSE, shipt)-.010;
    double takeProfitB = ((Ask - stapLossB) * 3.34) + Ask;
    double stOpinPips = Ask - stapLossB;
    double riskPerpips = (riskInUsd / stOpinPips);
    double lotSize = riskPerpips*Ask/normalLot;
    double rsi =  iRSI(Symbol(),2,14,PRICE_CLOSE,2); //2,2 = 11,12(THE BEST SETTING//15,1 =13,20//5,1= 15,18
    
    
    
   //FOR BUY OPPOURTUNITIES
    if (!orderPlaced) {
        if (Hour() > 10 && !orderPlaced && rsi < 70 && Close[3]<Open[3] && Close [2]< Open[2] && Close[1] > Open[1] && Close[1] > Open[2] && Open[1] > iMA(Symbol(), 5, 21, 0, MODE_SMMA, PRICE_CLOSE, 0) && iMA(Symbol(), 0, 21, 0, MODE_SMMA, PRICE_CLOSE, shipt) > iMA(Symbol(), 0, 50, 0, MODE_SMMA, PRICE_CLOSE, shipt) && iMA(Symbol(), 0, 50, 0, MODE_SMMA, PRICE_CLOSE, shipt) > iMA(Symbol(), 0, 200, 0, MODE_SMMA, PRICE_CLOSE, shipt)
            && iMA(Symbol(),15, 21,0,MODE_SMMA,PRICE_CLOSE,0) > iMA(Symbol(),15, 50,0,MODE_SMMA,PRICE_CLOSE,0)&& iMA(Symbol(),15, 50,0,MODE_SMMA,PRICE_CLOSE,0) > iMA(Symbol(),15, 200,0,MODE_SMMA,PRICE_CLOSE,0) 
            && iMA(Symbol(),60, 21,0,MODE_SMMA,PRICE_CLOSE,0) > iMA(Symbol(),60, 50,0,MODE_SMMA,PRICE_CLOSE,0)&& iMA(Symbol(),60, 50,0,MODE_SMMA,PRICE_CLOSE,0) > iMA(Symbol(),60, 200,0,MODE_SMMA,PRICE_CLOSE,0)) {
            ticket = OrderSend(Symbol(), OP_BUY, lotSize, Ask, 3, stapLossB, takeProfitB, "My EA", 0, 0, Red);
            orderPlaced = true;
            lastOrderTime = TimeCurrent(); // Update the time of the last trade
            Print("lotz is", lotSize);
            Print ("Entry is", Ask);
            Print("TPB is", takeProfitB);
            Print("SLB is", stapLossB);
            if (ticket < 0) {
                orderPlaced = false;
   
            }
        }
    }
   
    
    double stapLossS = iMA(Symbol(), 5, 200, 0, MODE_SMMA, PRICE_CLOSE, shipt)+.010;
    double stOpinPipsS = stapLossS - Bid;
    double takeProfitS = Bid - (stOpinPipsS * 3.34) ;    
    double riskPerpipsS = (riskInUsd / stOpinPipsS);
    double lotSizeS = riskPerpipsS*Bid/normalLot;
    //FOR SELL OPPOURTUNITIES
    if (!orderPlaced) {
        if (Hour() > 10 && !orderPlaced && rsi > 30 && Close[3] > Open[3] && Close[2]>Open[2] && Close[1]<Open[1] && Close[1] < Open[2] && Open[1] < iMA(Symbol(), 5, 21, 0, MODE_SMMA, PRICE_CLOSE, 0)&& iMA(Symbol(), 0, 21, 0, MODE_SMMA, PRICE_CLOSE, shipt) < iMA(Symbol(), 0, 50, 0, MODE_SMMA, PRICE_CLOSE, shipt) && iMA(Symbol(), 0, 50, 0, MODE_SMMA, PRICE_CLOSE, shipt) < iMA(Symbol(), 0, 200, 0, MODE_SMMA, PRICE_CLOSE, shipt)
            && iMA(Symbol(),15, 21,0,MODE_SMMA,PRICE_CLOSE,0) < iMA(Symbol(),15, 50,0,MODE_SMMA,PRICE_CLOSE,0)&& iMA(Symbol(),15, 50,0,MODE_SMMA,PRICE_CLOSE,0) < iMA(Symbol(),15, 200,0,MODE_SMMA,PRICE_CLOSE,0)
            && iMA(Symbol(),60, 21,0,MODE_SMMA,PRICE_CLOSE,0) < iMA(Symbol(),60, 50,0,MODE_SMMA,PRICE_CLOSE,0)&& iMA(Symbol(),60, 50,0,MODE_SMMA,PRICE_CLOSE,0) < iMA(Symbol(),60, 200,0,MODE_SMMA,PRICE_CLOSE,0)) {
            ticket = OrderSend(Symbol(), OP_SELL, lotSizeS, Bid, 3, stapLossS, takeProfitS, "My EA", 0, 0, Red);
            orderPlaced = true;
            lastOrderTime = TimeCurrent(); // Update the time of the last trade
            Print("lotz is", lotSizeS);
            Print ("Entry is", Bid);
            Print("TPS is", takeProfitS);
            Print("SLS is", stapLossS);
            Print("stop pips", stOpinPipsS);
            if (ticket < 0) {
                orderPlaced = false;    
            }
        }
    }          
}
