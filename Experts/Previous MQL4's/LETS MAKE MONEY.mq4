//============================================================================
//==============================FOR USDJPY 1M================================
//=====================5% RISK PER TRADE FROM CAPITAL========================
//===========================THIS IS A 1 MONTH RUN============================= 
// THE GOAL IS TO GAIN AT LEAST 39% BY THE END OF THE MONTH.  
//THE FOLLOWING MONTHS CAPITAL SHOULD BE (PREVIOUS CAPITAL + EOM PROFIT).    
//THIS IS A GET RICH QUICK STYLE (BUT SLOWLY STYLE)                          
//============================================================================
bool errOr = false;
int ticket;
int startIndex = 0;

bool orderPlaced = false;
bool orderClosed = true;

bool conSec = false;
bool conSec4 = false;
bool conSec5 = false;

bool conSec6 = false;
bool conSec7 = false;
bool conSec8 = false;
bool distance = false;

double riskInUsd = 1;
double normalLot = 10; //1000 if normallot 10 if microlot


double spanS = .06; //.06 for USDJPY1M; .0004 for AUDUSD
double spanG = .07; //.07 for USDJPY1M;.0005 for AUDUSD
double endTime = 10;  //10 if 1M 50 if 5M
int shipt = 5;





void OnTick() 

{
      
    startIndex = Bars - 1;
    if (orderPlaced) {
        if (OrderSelect(ticket, SELECT_BY_TICKET)) {
            if (OrderCloseTime() != 0) {
            
                
                orderPlaced = false;
                orderClosed = true;
               
                errOr = true;
                
                ObjectDelete("fibo");
                
            }
        }  
    }
    
    
    if (!orderPlaced)
   double rsi =  iRSI(Symbol(),15,14,PRICE_CLOSE,2);
  {      
    
        if (Close[5]>Open[5] && Close[4]< Open[4] && Close[3] < Open[3] && Close[2] < Open[2] && Close[1] > Open[1] && 
        Open[3] < iMA(Symbol(),5,21,0,MODE_SMMA, PRICE_CLOSE,0)  && iMA(Symbol(),0,21,0,MODE_SMMA, PRICE_CLOSE,shipt) < iMA(Symbol(), 0,50,0,MODE_SMMA, PRICE_CLOSE, shipt)&&
        iMA(Symbol(),0,50,0,MODE_SMMA, PRICE_CLOSE,shipt) < iMA(Symbol(), 0,200,0,MODE_SMMA, PRICE_CLOSE,shipt)&&!orderPlaced && rsi > 30
       && (Hour()< 22) && (Period() == 1)  )
        
       
          //  iMA(Symbol(),5,21,0,MODE_SMMA, PRICE_CLOSE,0) < iMA(Symbol(), 5,50,0,MODE_SMMA, PRICE_CLOSE,0)   
          // Close [2] to [22] > rSi 29 level
          // trading time2:00-3:00, 10:00-11:00 , 16:00-17:00(us), 
          // if last 20 candles has not reached overbought or oversold
         
        
        {
            conSec = true;
            
            if(conSec)
           
            {
               
                  
              
             
                
                ObjectCreate("fibo", OBJ_FIBO, 0, Time[4], Open[4], Time[2], Close[2]);
                
                  double price1= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE1),Digits);
                Print("1", price1);
                double price2= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE2),Digits);
                Print("2",price2);
                  double span=NormalizeDouble(price1-price2,Digits);
                 
                  
                  double level0618 = NormalizeDouble(span*.618,Digits);
                 
                  double levelprice1 = NormalizeDouble(level0618+price2,Digits);
                Print("Level 618 is",levelprice1);
                  double level120 = NormalizeDouble(span* 1.618,Digits);
                  
                   double levelprice2 = NormalizeDouble(level120+price2,Digits);
                  Print("Level 120 is",levelprice2);
                  double levelneg13 = NormalizeDouble(span*-1.55,Digits);
                  
                   double levelprice3 = NormalizeDouble(levelneg13+price2,Digits);
                   Print("Level -.13 is",levelprice3);
                   
                   double levelneg14 = NormalizeDouble(span*-.14,Digits);
                   
                   double levelprice4 = NormalizeDouble(levelneg14+price2,Digits);
                   Print("Level -.14 is",levelprice3);
                    
              

            }
            
          
            
            
                // check if trade context is available before placing an order
                if (IsTradeContextBusy() == false) {
                    // place a sell order with 150 point stoploss and takeprofit
                    double minstoplevel = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    double stoploss = NormalizeDouble(Ask - minstoplevel, Digits);
                    double takeprofit = NormalizeDouble(Ask + minstoplevel * 2, Digits);

                    // Make sure the stoploss and takeprofit values are not less than the minimum allowed by your broker
                    if (stoploss < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      stoploss = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    if (takeprofit < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      takeprofit = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                      
                      
                      double stOpinPips = span*100;
                     double riskPerpips = (riskInUsd/stOpinPips);
                     double lOtz = riskInUsd/stOpinPips*Ask/normalLot;
                    
                      
                      if (span < spanS)
                      
                      {
                      ObjectDelete("fibo");
                       errOr = true;
                      }
                      
                      else
                      
                      if (span >= spanG)
                      {

                     // Place the order 
                    double time_expiration = TimeCurrent() + endTime * 60;
                     
                ticket = OrderSend(Symbol(), OP_SELLLIMIT, lOtz, levelprice1, 3, levelprice2, levelprice3, "My EA", 0,time_expiration, Red);
                orderPlaced = true;
                
              
                 if (ticket < 0)
                          
                           
                        {
  
                 if (GetLastError())
                 errOr = true;
                 orderPlaced = false;
                 
                 {
                 Print("Error placing sell order : ", GetLastError());
                 Print("span is", span);
                 Print ("lots is", lOtz);
                 Print ("rsi is", rsi);
                 }    
                 
                 }
                    
                 
                 else {
                    Print("Sell order placed successfully. Ticket number: ", ticket);
                    Print("span is", span);
                    Print ("lots is", lOtz);
                    Print ("rsi is", rsi);  
                    orderPlaced = true;
 
                 }     

                    
         }
               
                       
         }
                
                      
                
                 
            } 
            
            
        
        }
      
 
 
    {
    
        if (Close[6]>Open[6] && Close[5]<Open[5] && Close[4]< Open[4] && Close[3] < Open[3] && Close[2] < Open[2] &&
         Close[1] > Open[1] && Open[4] < iMA(Symbol(),5,21,0,MODE_SMMA, PRICE_CLOSE,0)  && iMA(Symbol(),0,21,0,MODE_SMMA, PRICE_CLOSE,shipt) < iMA(Symbol(), 0,50,0,MODE_SMMA, PRICE_CLOSE,shipt)&&
        iMA(Symbol(),0,50,0,MODE_SMMA, PRICE_CLOSE,shipt) < iMA(Symbol(), 0,200,0,MODE_SMMA, PRICE_CLOSE,shipt)&& !orderPlaced && rsi > 30 
       && (Hour()< 22) && (Period() == 1)   ) 
       
               
        
        {
            conSec4 = true;
            if(conSec4)
            {
               
                  
                
             
                
                ObjectCreate("fibo", OBJ_FIBO, 0, Time[5], Open[5], Time[2], Close[2]);
                
                  
                 double price1B= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE1),Digits);
                Print("1", price1B);
                double price2B= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE2),Digits);
                Print("2",price2B);
                  double spanB=NormalizeDouble(price1B-price2B,Digits);
                  
                  
                  double level0618B = NormalizeDouble(spanB*.618,Digits);
                 
                  double levelprice1B = NormalizeDouble(level0618B+price2B,Digits);
                Print("Level 618 is",levelprice1B);
                  double level120B = NormalizeDouble(spanB* 1.618,Digits);
                  
                   double levelprice2B = NormalizeDouble(level120B+price2B,Digits);
                  Print("Level 120 is",levelprice2B);
                  double levelneg13B = NormalizeDouble(spanB*-1.55,Digits);
                  
                   double levelprice3B = NormalizeDouble(levelneg13B+price2B,Digits);
                   Print("Level -.13 is",levelprice3B);
                   
                   double levelneg14B = NormalizeDouble(spanB*-.14,Digits);
                   
                   double levelprice4B = NormalizeDouble(levelneg14B+price2B,Digits);
                   Print("Level -.14 is",levelprice3B);
                    
              

            }
            
          
            
            
                // check if trade context is available before placing an order
                if (IsTradeContextBusy() == false) {
                    // place a sell order with 150 point stoploss and takeprofit
                    double minstoplevelB = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    double stoplossB = NormalizeDouble(Ask - minstoplevelB, Digits);
                    double takeprofitB = NormalizeDouble(Ask + minstoplevelB * 2, Digits);
                    
                    
                    // Make sure the stoploss and takeprofit values are not less than the minimum allowed by your broker
                    if (stoplossB < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      stoplossB = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    if (takeprofitB < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      takeprofitB = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                      
                      double stOpinPipsB = spanB*100;
                     double riskPerpipsB = (riskInUsd/stOpinPipsB);
                     double lOtzB = riskInUsd/stOpinPipsB*Ask/normalLot;
                      
                      if (spanB < spanS)
                      
                      {
                      
                     ObjectDelete("fibo");
                      errOr = true;
                      }
                      
                     else
                      
                      
                      if (spanB >=spanG)  
                      
                     
                      
                      {
                      
                      
                     // Place the order 
                  
                     double time_expirationB = TimeCurrent() + endTime * 60;
                ticket = OrderSend(Symbol(), OP_SELLLIMIT, lOtzB, levelprice1B, 3, levelprice2B, levelprice3B, "My EA", 0,time_expirationB, Red);
                        orderPlaced = true;
                        
                      
                      
                       if (ticket < 0)
                          
                           
                        {
  
                 if (GetLastError())
                 errOr = true;
                 orderPlaced = false;
                 
                 {
                 Print("Error placing sell order : ", GetLastError());
                 Print("span is", spanB);
                 Print ("lots is", lOtzB);
                 Print ("rsi is", rsi);
                 }    
                 
                 }
                    
                 
                 else {
                    Print("Sell order placed successfully. Ticket number: ", ticket);
                    Print("span is", spanB);
                    Print ("lots is", lOtzB);
                    Print ("rsi is", rsi);  
                    orderPlaced = true;
 
                 }     

                    
         }
                
                     
                         
               

                
                 
            } 
            
            
        
        }
        
        
      
    }
    
            
        {
    
        if (Close[7]>Open[7] && Close[6]<Open[6] && Close[5]<Open[5] && Close[4]< Open[4] && Close[3] < Open[3] && Close[2] < Open[2] &&
         Close[1] > Open[1] &&  Open[5] < iMA(Symbol(),5,21,0,MODE_SMMA, PRICE_CLOSE,0)  && iMA(Symbol(),0,21,0,MODE_SMMA, PRICE_CLOSE,shipt) < iMA(Symbol(), 0,50,0,MODE_SMMA, PRICE_CLOSE,shipt)&&
        iMA(Symbol(),0,50,0,MODE_SMMA, PRICE_CLOSE,shipt) < iMA(Symbol(), 0,200,0,MODE_SMMA, PRICE_CLOSE,shipt)&& !orderPlaced && rsi > 30 
       && (Hour()< 22) && (Period() == 1)   )
       
               
        
        {
            conSec5 = true;
            if(conSec5)
            {
               
                  
                
             
                
                ObjectCreate("fibo", OBJ_FIBO, 0, Time[6], Open[6], Time[2], Close[2]);
                
                  
                 double price1C= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE1),Digits);
                Print("1", price1C);
                double price2C= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE2),Digits);
                Print("2",price2C);
                  double spanC=NormalizeDouble(price1C-price2C,Digits);
                  
                  
                  double level0618C = NormalizeDouble(spanC*.618,Digits);
                 
                  double levelprice1C = NormalizeDouble(level0618C+price2C,Digits);
                Print("Level 618 is",levelprice1C);
                  double level120C = NormalizeDouble(spanC* 1.618,Digits);
                  
                   double levelprice2C = NormalizeDouble(level120C+price2C,Digits);
                  Print("Level 120 is",levelprice2C);
                  double levelneg13C = NormalizeDouble(spanC*-1.55,Digits);
                  
                   double levelprice3C = NormalizeDouble(levelneg13C+price2C,Digits);
                   Print("Level -.13 is",levelprice3C);
                   
                   double levelneg14C = NormalizeDouble(spanC*-.14,Digits);
                   
                   double levelprice4C = NormalizeDouble(levelneg14C+price2C,Digits);
                   Print("Level -.14 is",levelprice3C);
                    
              

            }
            
          
            
            
                // check if trade context is available before placing an order
                if (IsTradeContextBusy() == false) {
                    // place a sell order with 150 point stoploss and takeprofit
                    double minstoplevelC = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    double stoplossC = NormalizeDouble(Ask - minstoplevelC, Digits);
                    double takeprofitC = NormalizeDouble(Ask + minstoplevelC * 2, Digits);
                    
                    
                    // Make sure the stoploss and takeprofit values are not less than the minimum allowed by your broker
                    if (stoplossC < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      stoplossC = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    if (takeprofitC < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      takeprofitC = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                      
                      double stOpinPipsC = spanC*100;
                     double riskPerpipsC = (riskInUsd/stOpinPipsC);
                     double lOtzC = riskInUsd/stOpinPipsC*Ask/normalLot;
                      
                      if (spanC < spanS)
                      
                      {
                      
                     ObjectDelete("fibo");
                      errOr = true;
                      }
                      
                     else
                      
                      
                      if (spanC >= spanG)  
                      
                     
                      
                      {
                      
                      
                     // Place the order 
                  
                     double time_expirationC = TimeCurrent() + endTime * 60;
                ticket = OrderSend(Symbol(), OP_SELLLIMIT, lOtzC, levelprice1C, 3, levelprice2C, levelprice3C, "My EA", 0,time_expirationC, Red);
                        orderPlaced = true;
                        
                     
                      
                      
                       if (ticket < 0)
                          
                           
                        {
  
                 if (GetLastError())
                 errOr = true;
                 orderPlaced = false;
                 
                 {
                 Print("Error placing sell order : ", GetLastError());
                 Print("span is", spanC);
                 Print ("lots is", lOtzC);
                 Print ("rsi is", rsi);
                 }    
                 
                 }
                    
                 
                 else {
                    Print("Sell order placed successfully. Ticket number: ", ticket);
                    Print("span is", spanC);
                    Print ("lots is", lOtzC);
                    Print ("rsi is", rsi);
                    orderPlaced = true;
 
                 }     

                    
         }
                
                     
                         
               

                
                 
            } 
            
            
        
        }
        
        
      
    }
                    
  //=======================BUY ORDERS=============================
  
  
  {
    
        if (Close[5]<Open[5] && Close[4]> Open[4] && Close[3] > Open[3] && Close[2] > Open[2] && Close[1] < Open[1] && 
        Open[3] > iMA(Symbol(),5,21,0,MODE_SMMA, PRICE_CLOSE,0)  && iMA(Symbol(),0,21,0,MODE_SMMA, PRICE_CLOSE,shipt) > iMA(Symbol(), 0,50,0,MODE_SMMA, PRICE_CLOSE,shipt)&&
        iMA(Symbol(),0,50,0,MODE_SMMA, PRICE_CLOSE,shipt) > iMA(Symbol(), 0,200,0,MODE_SMMA, PRICE_CLOSE,shipt)&& !orderPlaced && rsi < 70 
       && (Hour()< 22) && (Period() == 1)   )
       
               
        
        {
            conSec6 = true;
            if(conSec6)
            {
               
                  
                
             
                
                ObjectCreate("fibo", OBJ_FIBO, 0, Time[4], Open[4], Time[2], Close[2]);
                
                  double price1D= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE2),Digits);
                Print("1", price1D);
                double price2D= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE1),Digits);
                Print("2",price2D);
                  double spanD=NormalizeDouble(price1D-price2D,Digits);
                  
                  
                  double level0618D = NormalizeDouble(spanD*.382,Digits);
                 
                  double levelprice1D = NormalizeDouble(level0618D+price2D,Digits);
                Print("Level 618 is",levelprice1D);
                  double level120D = NormalizeDouble(spanD* -.618,Digits);
                  
                   double levelprice2D = NormalizeDouble(level120D+price2D,Digits);
                  Print("Level 120 is",levelprice2D);
                  double levelneg13D = NormalizeDouble(spanD*2.50,Digits);
                  
                   double levelprice3D = NormalizeDouble(levelneg13D+price2D,Digits);
                   Print("Level -.13 is",levelprice3D);
                   
                   double levelneg14D = NormalizeDouble(spanD*-.14,Digits);
                   
                   double levelprice4D = NormalizeDouble(levelneg14D+price2D,Digits);
                   Print("Level -.14 is",levelprice3D);
                    
              

            }
            
          
            
            
                // check if trade context is available before placing an order
                if (IsTradeContextBusy() == false) {
                    // place a sell order with 150 point stoploss and takeprofit
                    double minstoplevelD = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    double stoplossD = NormalizeDouble(Ask - minstoplevelD, Digits);
                    double takeprofitD = NormalizeDouble(Ask + minstoplevelD * 2, Digits);

                    // Make sure the stoploss and takeprofit values are not less than the minimum allowed by your broker
                    if (stoplossD < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      stoplossD = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    if (takeprofitD < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      takeprofitD = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                      
                      double stOpinPipsD = spanD*100;
                     double riskPerpipsD = (riskInUsd/stOpinPipsD);
                     double lOtzD = riskInUsd/stOpinPipsD*Ask/normalLot;
                      
                      if (spanD < spanS)
                      
                      {
                      ObjectDelete("fibo");
                       errOr = true;
                      }
                      
                      else
                      
                      if (spanD >= spanG)
                      
                     
               
                      {
                      
                      
                     // Place the order 
                    double time_expirationD = TimeCurrent() + endTime * 60;
                     
                ticket = OrderSend(Symbol(), OP_BUYLIMIT, lOtzD, levelprice1D, 3, levelprice2D, levelprice3D, "My EA", 0,time_expirationD, Red);
                orderPlaced = true;
                
                
                
               
                 if (ticket < 0)
                          
                           
                        {
  
                 if (GetLastError())
                 errOr = true;
                 orderPlaced = false;
                 
                 {
                 Print("Error placing sell order : ", GetLastError());
                 Print("span is", spanD);
                 Print ("lots is", lOtzD);
                 Print ("rsi is", rsi);
                 }    
                 
                 }
                    
                 
                 else {
                    Print("Sell order placed successfully. Ticket number: ", ticket);
                    Print("span b is", spanD);
                    Print ("lots is", lOtzD);
                    Print ("rsi is", rsi);
                    orderPlaced = true;
 
                 }     

                    
         }
               
                       
         }
                
                      
                
                 
            } 
            
            
        
        }
      
 
 
    {
    
        if (Close[6]<Open[6] && Close[5]>Open[5] && Close[4]> Open[4] && Close[3] > Open[3] && Close[2] > Open[2] &&
         Close[1] < Open[1] && Open[4] > iMA(Symbol(),5,21,0,MODE_SMMA, PRICE_CLOSE,0)  && iMA(Symbol(),0,21,0,MODE_SMMA, PRICE_CLOSE,shipt) > iMA(Symbol(), 0,50,0,MODE_SMMA, PRICE_CLOSE,shipt)&&
        iMA(Symbol(),0,50,0,MODE_SMMA, PRICE_CLOSE,shipt) > iMA(Symbol(), 0,200,0,MODE_SMMA, PRICE_CLOSE,shipt)&& !orderPlaced && rsi < 70 
       && (Hour()< 22)  && (Period() == 1)     )
        
               
        
        {
            conSec7 = true;
            if(conSec7)
            {
               
                  
                
             
                
                ObjectCreate("fibo", OBJ_FIBO, 0, Time[5], Open[5], Time[2], Close[2]);
                
                  
                 double price1E= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE2),Digits);
                Print("1", price1E);
                double price2E= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE1),Digits);
                Print("2",price2E);
                  double spanE=NormalizeDouble(price1E-price2E,Digits);
                  
                  
                  double level0618E = NormalizeDouble(spanE*.382,Digits);
                 
                  double levelprice1E = NormalizeDouble(level0618E+price2E,Digits);
                Print("Level 618 is",levelprice1E);
                  double level120E = NormalizeDouble(spanE* -.618,Digits);
                  
                   double levelprice2E = NormalizeDouble(level120E+price2E,Digits);
                  Print("Level 120 is",levelprice2E);
                  double levelneg13E = NormalizeDouble(spanE*2.50,Digits);
                  
                   double levelprice3E = NormalizeDouble(levelneg13E+price2E,Digits);
                   Print("Level -.13 is",levelprice3E);
                   
                   double levelneg14E = NormalizeDouble(spanE*-.14-.24,Digits);
                   
                   double levelprice4E = NormalizeDouble(levelneg14E+price2E,Digits);
                   Print("Level -.14 is",levelprice3E);
                    
              

            }
            
          
            
            
                // check if trade context is available before placing an order
                if (IsTradeContextBusy() == false) {
                    // place a sell order with 150 point stoploss and takeprofit
                    double minstoplevelE = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    double stoplossE = NormalizeDouble(Ask - minstoplevelE, Digits);
                    double takeprofitE = NormalizeDouble(Ask + minstoplevelE * 2, Digits);
                    
                    
                    // Make sure the stoploss and takeprofit values are not less than the minimum allowed by your broker
                    if (stoplossE < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      stoplossE = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    if (takeprofitE < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      takeprofitE = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                      
                      double stOpinPipsE = spanE*100;
                     double riskPerpipsE = (riskInUsd/stOpinPipsE);
                     double lOtzE = riskInUsd/stOpinPipsE*Ask/normalLot;
                      
                      if (spanE < spanS)
                      
                      {
                      
                     ObjectDelete("fibo");
                      errOr = true;
                      }
                      
                     else
                      
                      
                      if (spanE >= spanG)  
                      
                     
                      
                      {
                      
                      
                     // Place the order 
                  
                     double time_expirationE = TimeCurrent() + endTime * 60;
                ticket = OrderSend(Symbol(), OP_BUYLIMIT, lOtzE, levelprice1E, 3, levelprice2E, levelprice3E, "My EA", 0,time_expirationE, Red);
                        orderPlaced = true;
                        
                      
                      
                      
                       if (ticket < 0)
                          
                           
                        {
  
                 if (GetLastError())
                 errOr = true;
                 orderPlaced = false;
                 
                 {
                 Print("Error placing sell order : ", GetLastError());
                 Print("span is", spanE);
                 Print ("lots is", lOtzE);
                 Print ("rsi is", rsi);
                 }    
                 
                 }
                    
                 
                 else {
                    Print("Sell order placed successfully. Ticket number: ", ticket);
                    Print("span b is", spanE);
                    Print ("lots is", lOtzE);
                    Print ("rsi is", rsi); 
                    orderPlaced = true;
 
                 }     

                    
         }
                
                     
                         
               

                
                 
            } 
            
            
        
        }
        
        
      
    }
    
            
        {
    
        if (Close[7]<Open[7] && Close[6]>Open[6] && Close[5]>Open[5] && Close[4]> Open[4] && Close[3] > Open[3] && Close[2] > Open[2] &&
         Close[1] < Open[1] && Open[5] > iMA(Symbol(),5,21,0,MODE_SMMA, PRICE_CLOSE,0)  && iMA(Symbol(),0,21,0,MODE_SMMA, PRICE_CLOSE,shipt) > iMA(Symbol(), 0,50,0,MODE_SMMA, PRICE_CLOSE,shipt)&&
        iMA(Symbol(),0,50,0,MODE_SMMA, PRICE_CLOSE,shipt) > iMA(Symbol(), 0,200,0,MODE_SMMA, PRICE_CLOSE,shipt) && !orderPlaced && rsi < 70 
         && (Hour()< 22) && (Period() == 1)   )
        
               
        
        {
            conSec8 = true;
            if(conSec8)
            {
               
                  
                
             
                
                ObjectCreate("fibo", OBJ_FIBO, 0, Time[6], Open[6], Time[2], Close[2]);
                
                  
                 double price1F= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE2),Digits);
                Print("1", price1F);
                double price2F= NormalizeDouble(ObjectGet("fibo",OBJPROP_PRICE1),Digits);
                Print("2",price2F);
                  double spanF=NormalizeDouble(price1F-price2F,Digits);
                  
                  
                  double level0618F = NormalizeDouble(spanF*.382,Digits);
                 
                  double levelprice1F = NormalizeDouble(level0618F+price2F,Digits);
                Print("Level 618 is",levelprice1F);
                  double level120F = NormalizeDouble(spanF*-.618,Digits);
                  
                   double levelprice2F = NormalizeDouble(level120F+price2F,Digits);
                  Print("Level 120 is",levelprice2F);
                  double levelneg13F = NormalizeDouble(spanF*2.50,Digits);
                  
                   double levelprice3F = NormalizeDouble(levelneg13F+price2F,Digits);
                   Print("Level -.13 is",levelprice3F);
                   
                   double levelneg14F = NormalizeDouble(spanF*-.14,Digits);
                   
                   double levelprice4F = NormalizeDouble(levelneg14F+price2F,Digits);
                   Print("Level -.14 is",levelprice3F);
                    
              

            }
            
          
            
            
                // check if trade context is available before placing an order
                if (IsTradeContextBusy() == false) {
                    // place a sell order with 150 point stoploss and takeprofit
                    double minstoplevelF = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    double stoplossF = NormalizeDouble(Ask - minstoplevelF, Digits);
                    double takeprofitF = NormalizeDouble(Ask + minstoplevelF * 2, Digits);
                    
                    
                    // Make sure the stoploss and takeprofit values are not less than the minimum allowed by your broker
                    if (stoplossF < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      stoplossF = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                    if (takeprofitF < MarketInfo(Symbol(), MODE_STOPLEVEL) * Point)
                      takeprofitF = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
                      
                      double stOpinPipsF = spanF*100;
                     double riskPerpipsF = (riskInUsd/stOpinPipsF);
                     double lOtzF = riskInUsd/stOpinPipsF*Ask/normalLot;
                      
                      if (spanF < spanS)
                      
                      {
                      
                     ObjectDelete("fibo");
                      errOr = true;
                      }
                      
                     else
                      
                      
                      if (spanF >= spanG)  
                      
                     
                      
                      {
                      
                      
                     // Place the order 
                  
                     double time_expirationF = TimeCurrent() + endTime * 60;
                ticket = OrderSend(Symbol(), OP_BUYLIMIT, lOtzF, levelprice1F, 3, levelprice2F, levelprice3F, "My EA", 0,time_expirationF, Red);
                        orderPlaced = true;
                        
                                
                      
                      
                       if (ticket < 0)
                          
                           
                        {
  
                 if (GetLastError())
                 errOr = true;
                 orderPlaced = false;
                 
                 {
                 Print("Error placing sell order : ", GetLastError());
                 Print("span is", spanF);
                 Print ("lots is", lOtzF);
                 Print ("rsi is", rsi);
                 }    
                 
                 }
                    
                 
                 else {
                    Print("Sell order placed successfully. Ticket number: ", ticket);
                    Print("span b is", spanF);
                    Print ("lots is", lOtzF);
                    Print ("rsi is", rsi);
                    orderPlaced = true;
 
                 }     

                    
         }
                
                     
                         
               

                
                 
            } 
            
            
        
        }
        
        
      
    }
       
}



