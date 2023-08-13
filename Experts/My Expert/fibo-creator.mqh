int fibonacciObject = -1; // Object's identifier

void createFibo(){
// Calculate the starting and ending points for the Fibonacci Retracement
            double startPoint = iClose(Symbol(), 0, 10); // You can modify this based on your preference
            double endPoint = iClose(Symbol(), 0, 1); // You can modify this based on your preference

            // Create the Fibonacci Retracement object
            fibonacciObject = ObjectCreate(0, "FibonacciRetracement", OBJ_FIBO, 0, Time[10], startPoint, Time[1], endPoint);
            
            
            double Level100 = ObjectGetDouble(0,"FibonacciRetracement", OBJPROP_PRICE, 0);
            double Level0 = ObjectGetDouble(0,"FibonacciRetracement", OBJPROP_PRICE, 1);
            double Level50=((Level0+Level100)/2);
            double Level61_8 = Level0 + (0.618 * (Level100 - Level0));
            double Level161_8 = Level0 + (1.618 * (Level100 - Level0));
            double NegativeLevel2 = Level0 - (2.0 * (Level100 - Level0));
            Print(NegativeLevel2);
            
            
            Comment (
               "Level 0:", Level0 + "\n",
               "Level 50:", Level50 + "\n",
               "Level 100:", Level100 + "\n"
            );
}