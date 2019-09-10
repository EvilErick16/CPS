//Erick Juarez
//CPSC 240 - Random Answer generator (Hwk06.cpp)
//Visual Studio 2015 Community
//This program has 11 differnt answers to yes/no questions
//ask it anything and it will generate a random answer!
#include <iostream>
#include <Windows.h>
#include <mmsystem.h>
#include <string>
#include <ctime>
using namespace std;
#pragma comment(lib, "Winmm.lib")

int randomNum(int seed, int iterator);
int smallGenerator(int num);

int main()
{
    char * soundfiles_ptr[] = { "c:\\Public\\Public Documents\\Hwk4\\AnythingIsPossible.wav",
         "c:\\Public\\Public Documents\\Hwk4\\Definitely.wav" ,
         "c:\\Public\\Public Documents\\Hwk4\\DefinitelyNot.wav" ,
         "c:\\Public\\Public Documents\\Hwk4\\IThinkItIsLikely.wav" ,
         "c:\\Public\\Public Documents\\Hwk4\\IThinkNot.wav" ,
         "c:\\Public\\Public Documents\\Hwk4\\IThinkThatTimeWillTell.wav" ,
         "c:\\Public\\Public Documents\\Hwk4\\ItIsNotCertain.wav" ,
         "c:\\Public\\Public Documents\\Hwk4\\ItIsTooSoonToTell.wav" ,
         "c:\\Public\\Public Documents\\Hwk4\\MaybeNot.wav" ,
         "c:\\Public\\Public Documents\\Hwk4\\WithoutADoubt.wav" ,
         "c:\\Public\\Public Documents\\Hwk4\\YouMustBeJoking.wav" , };
    string question;                                    // place for the user to ask the question 
    int smallNum, ranNum;                            // loop counter and random number 
    int curTime = static_cast<int> (time(NULL));        //get the current system time 
    char files[132];

    smallNum = smallGenerator(curTime);   //generate a small number, 1-256 based on system time                                   
    cout << "Welcome to the magic 8 ball program :)" << endl;       // display welcome message 
    cout << "==============================================================" << endl;
    cout << "Ask a yes or no question: "; 
    getline(cin, question);                     //read question from user 

    curTime = static_cast<int> (time(NULL));    //get the current time after the question is asked 
    ranNum = randomNum(curTime, smallNum);      //generate a random number using two seeds 

    cout << "==============================================================" << endl;
    //cout << soundfiles_ptr[ranNum] << endl;
    strcpy_s(files, soundfiles_ptr[ranNum]);    
    PlaySoundA(files, NULL, SND_FILENAME);

  
    return 0;
}

//Generates a small numbser 1-256 based on the current time in seconds
int smallGenerator(int num)
{
    int smallNum;
    __asm {
        xor eax, eax      //clear eax register 
        mov bl, byte PTR num    // cast the lowest byte into the bl register 
        movzx eax, bl           // zero extend the byte into eax
        mov smallNum, eax    //move the number into the variable
        inc smallNum     //increment the value by 1. 
    }   
    return smallNum;     //function returns the loop counter generated 
}

//generates a rendom number based on the two seeds gshfs jfhs hfjsh
int randomNum(int seed, int smallNum)
{
    int rNum = 2;
    __asm {
        pushad 
        mov ecx, smallNum       //move small number to ecx
        mov ebx, smallNum        //copy small number to ebx
        mov eax, seed           //move seed to eax
        add ebx, ecx           // add small number to itself
        mul ebx             //multiply seed by small number squared 
                                        
        mov ecx, 11         //move 11 to ecx
        xor edx,edx         //clear edx register
        div ecx           //divide by 11, we want a remainder between 0-10
        mov rNum, edx       // move the remainder of the division to the variable
        popad
    }       
    return rNum;        //return random number
}
