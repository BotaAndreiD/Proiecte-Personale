#include<reg51.h>
#include<stdio.h>
#include<string.h>
#include <stdlib.h>
#include "LCD16x2_4bit.h"

sbit DHT22=P2^1;

unsigned int I_RH, D_RH, I_Temp, D_Temp, CheckSum;

void timer_delay20ms() {	
	TMOD = 0x01;
	TH0 = 0xB8;	
	TL0 = 0x0C;	
	TR0 = 1;					
	while(TF0 == 0);
	TR0 = 0;					
	TF0 = 0;					
}

void timer_delay50us() { 
	TMOD = 0x01;
	TH0 = 0xFF;	
	TL0 = 0xF1;	
	TR0 = 1;					
	while(TF0 == 0);
	TR0 = 0;					
	TF0 = 0;					
}

void Request() {
	DHT22 = 0;		 		
	timer_delay20ms();
	DHT22 = 1;				
}

void Response() {
	while(DHT22 == 1);
	while(DHT22 == 0);
	while(DHT22 == 1);
}

int Receive_data() {
	int q, c = 0;	
	for (q = 0; q < 8; q++) {
		while(DHT22 == 0);
		timer_delay50us();
		if(DHT22 == 1)			
			c = (c << 1) | (0x01);	
		else							
			c = (c << 1);
		while(DHT22 == 1);
	}
	return c;
}

void main() {
	char dat[20];
	float temperature, humidity;
	LCD_Init();							
	
	while(1) {		
		Request();
		Response();
		
		I_RH = Receive_data();	
		D_RH = Receive_data();	
		I_Temp = Receive_data();
		D_Temp = Receive_data();
		CheckSum = Receive_data();

		if ((I_RH + D_RH + I_Temp + D_Temp) != CheckSum) {
			LCD_String_xy(0,0,"Error");
		} else {
			humidity = ((I_RH << 8) | D_RH) / 10.0;
			temperature = ((I_Temp << 8) | D_Temp) / 10.0;
			
			sprintf(dat, "H: %.1f%%", humidity);
			LCD_String_xy(0,0,dat);
			sprintf(dat, "T: %.1f", temperature);   
			LCD_String_xy(1,0,dat);
			LCD_Char(0xDF);
			LCD_String("C");
		}		
		delay(100);
	}	
}
