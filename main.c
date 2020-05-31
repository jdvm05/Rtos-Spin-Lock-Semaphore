#include "osKernel.h"
#include "TM4C123_RTOS_BSP.h"
#define QUANTA 1

int32_t semaphore1, semaphore2, count1, count2;

void Task0(void){
	while(1){
	}
}

void Task1(void){
	while(1){
		osSignalWait(&semaphore2);
		ST7735_DrawString(3,7,"This is THREAD 1",GREEN);
		count1++;
		osSignalSet(&semaphore1);
	}
}

void Task2(void){
	while(1){
		osSignalWait(&semaphore1);
		ST7735_DrawString(3,5,"This is THREAD 2",GREEN);
		count2++;
		osSignalSet(&semaphore2);
	}
}


int main(void){
	osSemaphoreInit(&semaphore1,1);
	osSemaphoreInit(&semaphore2,0);
	Probe_Init();
	ST7735_Init();
	osKernelInit();
	osKernelAddThreads(&Task0, &Task1, &Task2);
	osKernelLaunch(QUANTA);
}

