#include "divergence-monitor.mqh"
#include "lower-divergence-monitor.mqh"

void runComment(){
       Comment(
            "0 means no divergence:" , isDivergence, "\n",
            "0 means no lower-divergence:" , isLowerDivergence);
}