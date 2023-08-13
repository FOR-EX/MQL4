/*
#include "fibo-creator.mqh"

bool isOn = true;
datetime fibonacciCreationTime = 0; // Time when the Fibonacci object was created
string fiboDescription;


void OnTick()
{
    // Check if Fibonacci Retracement is turned on
    if (isOn)
    {
        // Check if the Fibonacci object is not created yet
        if (fibonacciObject == -1)
        {   
            
            createFibo();
            iRSIOnArray([], )
            Print(iBars(Symbol(), 60));

            if (fibonacciObject != -1) 
            {
                // Store the creation time of the Fibonacci object
                fibonacciCreationTime = TimeCurrent();
            }
            else
            {
                Print("Failed to create Fibonacci Retracement object.");
                return;
            }
        }
        else
        {
            // Check if 5 seconds have elapsed since the Fibonacci object creation
            if (TimeCurrent() - fibonacciCreationTime >= 5)
            {
                // Delete the Fibonacci Retracement object
                ObjectDelete(0, "FibonacciRetracement");
                fibonacciObject = -1;
            }
        }
    }
    else
    {
        // If isOn is false, delete the Fibonacci Retracement object if it exists
        if (fibonacciObject != -1)
        {
            ObjectDelete(0, "FibonacciRetracement");
            fibonacciObject = -1;
        }
    }

    // Rest of your code here...
   
    
}
*/ 


void OnTick(){

  

}