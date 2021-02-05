#include <iostream>
#define MAX_SIZE 100

using namespace std;

/*
I wrote it to find if a subset of array elements can sum up to the target num. 
If not possible then returns 0, otherwise returns 1.
*/

int CheckSumPossibility(int num, int arr[] ,int arraySize)
{

    if (num == 0){ // if target value is equal to zero then returns 1
        return 1;
    }
    if (arraySize == 0)
        return 0; 


    if (arr[arraySize - 1] > num){
        return CheckSumPossibility(num, arr, arraySize - 1); //recursive call
    }

	// recursive call. I also added "cout" at the end of the return part to implement bonus part in my assembly code. 	
    return  CheckSumPossibility(num,arr,arraySize - 1)
           || CheckSumPossibility(num - arr[arraySize - 1],arr,arraySize - 1) /*&& cout << arr[arraySize - 1] << " "*/;    
}
 

int main()
{
        int arraySize;
        int arr[MAX_SIZE];
        int num;
        int returnVal;
        cin >> arraySize;
        cin >> num;       // to get target value
	// array is filled by user
        for(int i = 0; i < arraySize; ++i)
        {
            cin >> arr[i];
        }
        returnVal = CheckSumPossibility(num,arr,arraySize);  // recursion part
        
        if(returnVal == 1)
        {
          cout << "Possible!" << endl;
        }
        else
        {
            cout << "Not possible!" << endl;
        }
        return 0;
}