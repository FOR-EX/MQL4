#include <divergence-monitor.mqh>
#include <session-levels-marker.mqh>
#include <engulfing-detector.mqh>
#include <after-break-levels.mqh>

void OnTick() {
   engulferTimeFrame = 1; //Update the timeframe from engulferTimeFrame
   afterBreakLevelsTimeframe = engulferTimeFrame;
   divergenceMonitorTimeFrame =60; //Update the timeframe from divergenceMonitor
   sessionLevelTimeFrame = 60; //Update the timeframe from sessionLevelMarker
   double lastMinute = currentMinute;

   // update the date&time vars on each tick...
   runningTime();

   //This is to make codes reiterate only once per minute - making the code efficient.
   if (currentMinute != lastMinute){
      //run this to see if there is uncleared rsiDivergence....
      runDivergenceMonitor(); 

      //run this to see if it is tradingtime....
      checkTradingTime();
      
      //run the sessionLevelsFinder
      findSessionResistance();
      findSessionSupport();
      
      
      if (isBullishEngulfing()){
         Print ("there is a bullish engulfing going on and the base is:", bullishEngulfingBase);
      }
      if (isBearishEngulfing()){
         Print ("there is a bearish engulfing going on and the head is:", bearishEngulfingHead);
      }

      checkForBullBreaks ();
      checkForBearBreaks();

      pushBullishBreakPriceArrays();
      pushBearishBreakPriceArrays ();

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
      if(!isDivergence && isTradingTime){
         //this is the condition for placing order during bullish conditions
         if (isBullishEngulfing() && bullishEngulfingBase > lastHighestPeakValue && isBullBreak){
            //placeBullishOrder();
            Print("Bullish Order Placed");
            updateLastHigh();
            } 
            
            //condition to update last high if no orderplaced
         if (isBullishEngulfing() && bullishEngulfingBase < lastHighestPeakValue) {
            updateLastHigh();
         }
         
         // -------------------------------------------------------------------//

         //this is the condition for placing order during bearish conditions
         if(isBearishEngulfing() && bearishEngulfingHead < lastLowestLowValue && isBearBreak){
            //placeBearishOrder();
            Print("Bearish Order Placed");
            updateLastLow();
         }
         if(isBearishEngulfing() && bearishEngulfingHead > lastLowestLowValue){
            updateLastLow();
         }
      }     
      
      lastMinute = currentMinute;
   }

}
//Custom Function


//This is a lotsize calculator
   // double stOpinPips = span*100;
   // double riskPerpips = (riskInUsd/stOpinPips);
   // double lOtz = riskInUsd/stOpinPips*Ask/normalLot;