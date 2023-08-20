#include <divergence-monitor.mqh>
#include <session-levels-marker.mqh>
#include <engulfing-detector.mqh>
#include <after-break-levels.mqh>

void OnTick() {
   engulferTimeFrame = 1; //Update the timeframe from engulferTimeFrame
   afterBreakLevelsTimeframe = engulferTimeFrame;
   divergenceMonitorTimeFrame =60; //Update the timeframe from divergenceMonitor
   sessionLevelTimeFrame = 60; //Update the timeframe from sessionLevelMarker

   // update the date&time vars on each tick...
   runningTime();

   //run this to see if there is uncleared rsiDivergence....
   runDivergenceMonitor(); 

   //run this to see if it is tradingtime....
   checkTradingTime();

   //resets the After Break Levels if !tradingTime
   resetTheAfterBreakLevels();
   
   //run the sessionLevelsFinder
   findSessionResistance();
   findSessionSupport();
   
   
   Comment("Resistance is:",sessionResistanceArray[0],"Created on:",resistanceLevelCreationTime, "\n",
            "Support is:",sessionSupportArray[0], "Created on:",supportLevelCreationTime, "\n",
            "0 means no divergence:" , isDivergence, "\n",
            "0 means not time to trade:", isTradingTime);


   // if (isBullishEngulfing()){
   //    Print ("there is a bullish engulfing going on and the base is:", bullishEngulfingBase);
   // }
   // if (isBearishEngulfing()){
   //    Print ("there is a bearish engulfing going on and the head is:", bearishEngulfingHead);
   // }
   checkForBreaks ();

   pushBullishBreakPriceArrays();

   //establish the last highes peak...
   establishLastHighestPeak();
   
   
   Print("LastbullishBreakPriceArrays is:",bullishBreakPriceArrays[initialAfterBreakLevelsArray-1]);
   Print("Last highest peak is:", lastHighestPeak[lastHighestPeakIndex]);
   //Condition to place a bullish order
   if(!isDivergence && isTradingTime){
      //this is the condition for placing order during bullish conditions
      if (isBullishEngulfing() && bullishEngulfingBase > lastHighestPeak[lastHighestPeakIndex]){
         //placeBullishOrder();
         Print("Bullish Order Placed");
         updateNewHighestPeak ();
         } 
         
         
      if (bullishEngulfingBase < lastHighestPeak[lastHighestPeakIndex]) {
         // updateLastHigh();
      }
      }     
   }
//Custom Function


//This is a lotsize calculator
   // double stOpinPips = span*100;
   // double riskPerpips = (riskInUsd/stOpinPips);
   // double lOtz = riskInUsd/stOpinPips*Ask/normalLot;