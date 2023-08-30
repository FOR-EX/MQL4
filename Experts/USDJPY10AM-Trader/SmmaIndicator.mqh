int smmaTimeFrame;
int smmaShift = 4;

double oneSmma;
double twoSmma;
double threeSmma;

bool isSmmaBear = false;
bool isSmmaBull = false;

bool checkBullSmma(){
    if (oneSmma > twoSmma && twoSmma > threeSmma){
       return isSmmaBull = true;
    } else {
       return isSmmaBull = false;
    }
}

bool checkBearSmma(){
    if (oneSmma < twoSmma && twoSmma < threeSmma){
       return isSmmaBear = true;
    } else {
       return isSmmaBear = false;
    }
}

void runSmmaMonitor(){
    oneSmma = iMA(Symbol(), smmaTimeFrame,21, 0, MODE_SMMA, PRICE_CLOSE, smmaShift);
    twoSmma = iMA(Symbol(), smmaTimeFrame,50, 0, MODE_SMMA, PRICE_CLOSE, smmaShift); 
    threeSmma = iMA(Symbol(), smmaTimeFrame,200, 0, MODE_SMMA, PRICE_CLOSE, smmaShift);
        checkBullSmma();
        checkBearSmma();
}