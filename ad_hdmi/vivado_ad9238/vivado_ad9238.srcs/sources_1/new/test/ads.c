#include <stdint.h>
#include "ads.h"
#include "../include/spi.h"
#include "../include/utils.h"
#include "../include/gpio.h"
#include "../include/spi.h"
void ADS1256_GPIO_Init(){
	SPI_REG(SPI_CTRL) = 0x00; // CPOL = 0, CPHA = 0
	GPIO_REG(GPIO_CTRL) |= 0x1 << 1;  // gpio0输入模式

}

void ADS1256_Reg_Init()
{
	uint8_t ADS1256_Reg_value[5]=
	{	
  	0x02,    //×´Ì¬¼Ä´æÆ÷³õÊ¼Öµ
  	0x67,    //¶àÂ·¸´ÓÃÆ÷³õÊ¼Öµ
	0x00,    //AD¿ØÖÆ¼Ä´æÆ÷³õÊ¼Öµ
	0x92,    //×ª»»ËÙÂÊ¼Ä´æÆ÷³õÊ¼»¯Öµ:5 SPS
	0x00,    //GPIO¼Ä´æÆ÷³õÊ¼»¯Öµ
	};

	spi_set_ss(0);
	busy_wait(1);

	ADS1256_Write_Register(STATUS,ADS1256_Reg_value[0]);
	busy_wait(1);
  	ADS1256_Write_Register(_MUX,ADS1256_Reg_value[1]);
	busy_wait(1);
  	ADS1256_Write_Register(ADCON,ADS1256_Reg_value[2]);
	busy_wait(1);
  	ADS1256_Write_Register(DRATE,ADS1256_Reg_value[3]);
	busy_wait(1);
  	ADS1256_Write_Register(IO,ADS1256_Reg_value[4]);

  	while(ADS1256_DRDY);
	ADS1256_Write_Byte(SELFCAL);
	busy_wait(5);
	ADS1256_Write_Byte(SYNC);
	busy_wait(5);
	ADS1256_Write_Byte(WAKEUP);
	busy_wait(5);
}




/**************************************** Ð´¼Ä´æÆ÷ *******************************************************************/
void ADS1256_Write_Register(uint8_t Addr,uint8_t Data)
{
	while(ADS1256_DRDY);  
	ADS1256_Write_Byte( (Addr&0x0F)| WREG );  
	ADS1256_Write_Byte(0x01-0x01);            
	ADS1256_Write_Byte(Data);                 
	spi_set_ss(1);     
	busy_wait(600);
}
/*********************************************************************************************************************/

void ADS1256_Write_Byte(uint8_t Data){
	spi_set_ss(0);
	spi_write_byte(Data);
}


/**************************************** ¶ÁÈ¡Êý¾Ý *******************************************************************/
uint32_t ADS1256_Read_Data()
{
	uint32_t sum1 = 0;   uint32_t sum2 = 0;   uint32_t sum3 = 0;   uint32_t sum = 0;
	
	while(ADS1256_DRDY);
	sum1 = ADS1256_Read_Byte();
	sum2 = ADS1256_Read_Byte();
	sum3 = ADS1256_Read_Byte();
	spi_set_ss(1);     //À­¸ßÆ¬Ñ¡
	
	sum1 <<= 16;
	sum2 <<=8;
	sum = sum1|sum2|sum3;
	
	return sum;
}
/*********************************************************************************************************************/

uint8_t ADS1256_Read_Byte()
{
  	uint8_t data;
	spi_set_ss(0);        //À­µÍSPIÆ¬Ñ¡
	

    SPI_REG(SPI_CTRL) |= 1 << 0;           // start
    while (SPI_REG(SPI_STATUS) & 0x1);     // wait transfer complete
    data = SPI_REG(SPI_DATA) & 0xff;       // readback data

    return data;
}





double ADS1256_DataFormatting(uint32_t Data , double Vref ,uint8_t PGA)
{
	/*
	µçÑ¹¼ÆËã¹«Ê½£»
			Éè£ºAD²ÉÑùµÄµçÑ¹ÎªVin ,AD²ÉÑù¶þ½øÖÆÖµÎªX£¬²Î¿¼µçÑ¹Îª Vr ,ÄÚ²¿¼¯³ÉÔË·ÅÔöÒæÎªG
			Vin = ( (2*Vr) / G ) * ( x / (2^23 -1))
	*/
	double ReadVoltage;
	if(Data & 0x00800000)
	{
		Data = (~Data) & 0x00FFFFFF;
		ReadVoltage = -(((double)Data) / 8388607) * ((2*Vref) / ((double)PGA));
	}
	else
		ReadVoltage =  (((double)Data) / 8388607) * ((2*Vref) / ((double)PGA));
	
	return(ReadVoltage);
}

/*********************************************************************************************************************/


