#include "divergence-monitor.mqh"
#include "place-order-functions.mqh"
#include "lower-divergence-monitor.mqh"
#include "SMCMonitor.mqh"
#include "run-comment.mqh"
#include "SmmaIndicator.mqh"

void runComment(){
     Comment(
     "0 means no divergence:" , isDivergence, "\n",
     "0 means no lower-divergence:" , isLowerDivergence, "\n",
     "Time now is Hour:", currentHour, "and Minute:", currentMinute, "\n",
     "0 means no isSmmaBull:",isSmmaBull, "\n",
     "0 means no isSmmaBear:",isSmmaBear);

     Print("21:", oneSmma);
     Print("50:", twoSmma);
     Print("200:", threeSmma);
     
}