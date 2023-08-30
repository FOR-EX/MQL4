#include "divergence-monitor.mqh"
#include "place-order-functions.mqh"
#include "lower-divergence-monitor.mqh"
#include "SMCMonitor.mqh"
#include "run-comment.mqh"
#include "SmmaIndicator.mqh"

void OnTick() {
   riskedAmount = 200; //risked money in USD
   takeProfitMultiplier = 2; //
   smcTimeFrame = 1; //Update the timeframe from engulferTimeFrame
   placeOrderTimeframe = smcTimeFrame;
   divergenceMonitorTimeFrame = 5; //Update the timeframe from divergenceMonitor
   smmaTimeFrame = divergenceMonitorTimeFrame;
   lower_divergenceMonitorTimeFrame = smcTimeFrame;

   double lastMinute = currentMinute;

   //manage existing pending order...
   manageExistingOrder();

   // update the date&time vars on each tick...
   runningTime();

   //This is to make codes reiterate only once per minute - making the code efficient.
   if (currentMinute != lastMinute){
      
      //run this to see if there is uncleared rsiDivergence....
      runDivergenceMonitor();
      runLowerDivergenceMonitor(); 

      // run SMC detector
      runSMCMonitor();

      //run the Smma Monitor
      runSmmaMonitor();

      //runComment for debugging purposes
      runComment();

      //10am trader logic for bull orders
      if (currentHour == 10 && !isDivergence && !isLowerDivergence && isSmmaBull && isBullishSMCHere){
         placeBullishOrder();
      }
      //10am trader logic for sell orders
      if (currentHour == 10 && !isDivergence && !isLowerDivergence && isSmmaBear && isBearishSMCHere){
         placeBearishOrder();
      }
      
      //update the lastMinute
      lastMinute = currentMinute;
   }
}
