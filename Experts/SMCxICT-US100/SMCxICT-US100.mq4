#include "divergence-monitor.mqh"
#include "us100-session-levels-marker.mqh"
#include "place-order-functions.mqh"
#include "lower-divergence-monitor.mqh"
#include "SMCMonitor.mqh"
#include "after-break-levels.mqh"

void OnTick() {

   // Day-light-saving-time-days means you will trade an hour earlier than days that are not in day light saving time.
   
   riskedAmount = 200; //risked money in USD
   takeProfitMultiplier = 2; //
   smcTimeFrame = 1; //Update the timeframe from engulferTimeFrame
   placeOrderTimeframe = smcTimeFrame;
   divergenceMonitorTimeFrame = 5; //Update the timeframe from divergenceMonitor
   lower_divergenceMonitorTimeFrame = smcTimeFrame;
   afterBreakLevelsTimeframe = smcTimeFrame;
   sessionLevelTimeFrame = 1; //Update the timeframe from sessionLevelMarker 
   double lastMinute = currentMinute;

   //manage existing pending order...
   managePendingOrder();

   // update the date&time vars on each tick...
   runningTime();

   //This is to make codes reiterate only once per minute - making the code efficient.
   if (currentMinute != lastMinute){
      //run this to see if there is uncleared rsiDivergence....
      runDivergenceMonitor();
      runLowerDivergenceMonitor(); 

      //run this to see if it is tradingtime....
      checkTradingTime();
      
      //run the sessionLevelsFinder
      findSessionResistance();
      findSessionSupport();

      checkForBullBreaks();
      checkForBearBreaks();

      pushBullishBreakPriceArrays();
      pushBearishBreakPriceArrays();

      //establish the last highes peak and last lowest low...
      establishLastHighestPeak();
      establishLastLastLowestLow();

      //resets the After Break Levels if !tradingTime
      if (currentHour > 22){
         resetTheAfterBreakLevels();
      }
   
      Comment("Resistance is:",sessionResistanceArray[0],"Created on:",resistanceLevelCreationTime, "\n",
            "Support is:",sessionSupportArray[0], "Created on:",supportLevelCreationTime, "\n",
            "0 means no divergence:" , isDivergence, "\n",
            "0 means not time to trade:", isTradingTime, "\n",
            "LastbullishBreakPriceArrays is:",bullishBreakPriceArrays[initialAfterBullBreakLevelsArray-1], "\n",
            "Last highest peak is:", lastHighestPeakValue, "\n",
            "LastbearishBreakPriceArrays is:",bearishBreakPriceArrays[initialAfterBearBreakLevelsArray-1], "\n",
            "Last lowest low is:", lastLowestLowValue);
            
      
      //Condition to place a bullish order
      if(!isDivergence && isTradingTime && !isLowerDivergence){

         runSMCMonitor();
         //this is the condition for placing order during bullish conditions
         if (isBullishSMCHere && isBullBreak && newCandle > lastHighestPeakValue){
            placeBullishOrder();
            Print("Bullish Order Placed");
            updateLastHigh();
            } 
         // -------------------------------------------------------------------//

         //this is the condition for placing order during bearish conditions
         if(isBearishSMCHere && isBearBreak && (newCandle < lastLowestLowValue)){
            placeBearishOrder();
            Print("Bearish Order Placed");
            updateLastLow();
         }
      }

      //Things to do if divergent and isTradingTime
      if ((isDivergence && isTradingTime) || (isLowerDivergence && isTradingTime)){
         runSMCMonitor();
         if (isBullishSMCHere && isBullBreak){
            count = 0;
            updateLastHigh();
            isBullishSMC = false;
            isBullishSMCHere = false;
         }
         if(isBearishSMCHere && isBearBreak){
            count = 0;
            updateLastLow();
            isBearishSMC = false;
            isBearishSMCHere = false;
         }
      }

      //another condition to updating the afterbreak levels
      if(isTradingTime && isBullBreak && (newCandle < secondCandle) && (secondCandle > thirdCandle)){
         updateLastHigh();
      }

      if(isTradingTime && isBearBreak && (newCandle > secondCandle) && (secondCandle < thirdCandle)){
         updateLastLow();
      }

      // if (isBullishSMCHere && isBullBreak || OrdersTotal == 0)
      
      lastMinute = currentMinute;
      deleteFibo();
   }
}

// Custom Function