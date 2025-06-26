#ifndef __ADS_H
#define __ADS_H
#include <stdint.h>
/********************************************  ¼Ä´æÆ÷µØÖ·¶¨Òå  **************************************************************/
#define  STATUS  0x00        // ×´Ì¬¼Ä´æÆ÷
#define  _MUX     0x01        // ÊäÈë¶àÂ·¸´ÓÃÆ÷¿ØÖÆ¼Ä´æÆ÷
#define  ADCON   0x02        // A/D¿ØÖÆ¼Ä´æÆ÷
#define  DRATE   0x03        // A/DÊý¾ÝËÙÂÊ¼Ä´æÆ÷
#define  IO      0x04        // GPIO¿ØÖÆ¼Ä´æÆ÷
#define  OFC0    0x05        // Æ«ÒÆÐ£×¼×Ö½Ú0¼Ä´æÆ÷
#define  OFC1    0x06        // Æ«ÒÆÐ£×¼×Ö½Ú1¼Ä´æÆ÷
#define  OFC2    0x07        // Æ«ÒÆÐ£×¼×Ö½Ú2¼Ä´æÆ÷
#define  FSC0    0x08        // ÂúÁ¿³ÌÐ£×¼×Ö½Ú0¼Ä´æÆ÷
#define  FSC1    0x09        // ÂúÁ¿³ÌÐ£×¼×Ö½Ú1¼Ä´æÆ÷
#define  FSC2    0x0A        // ÂúÁ¿³ÌÐ£×¼×Ö½Ú2¼Ä´æÆ÷
/*********************************************************************************************************************/

/******************************************** Ä£ÄâSPI½Ó¿Ú¶¨Òå *******************************************************************/
#define  ADS1256_DRDY  (GPIO_REG(GPIO_DATA) & 0x1)        // ×ª»»Íê³ÉÖÐ¶ÏÏß
/**********************************************************************************************************************/

/*********************************** ADS1256Ö¸Áî¶¨Òå ************************************************************************/
#define  WAKEUP    0x00  //»½ÐÑÆ÷¼þ
#define  RDATA     0x01  //¶ÁÈ¡Êý¾Ý
#define  RDATAC    0x03  //¶ÁÈ¡Continue
#define  SDATAC    0x0F  //Í£Ö¹¶ÁÈ¡Continue
#define  RREG      0x10  //¶ÁÖ¸Áî
#define  WREG      0x50  //Ð´Ö¸Áî
#define  SELFCAL   0xF0  //×ÔÆ«ÒÆºÍÔöÒæÐ£×¼
#define  SELFOCAL  0xF1  //×ÔÆ«ÒÆÐ£×¼
#define  SELFGCAL  0xF2  //×Ô¶¯ÔöÒæÐ£×¼
#define  SYSOCAL   0xF3  //ÏµÍ³Æ«ÒÆÐ£×¼
#define  SYSGCAL   0xF4  //ÏµÍ³ÔöÒæÐ£×¼
#define  SYNC      0xFC  //Æô¶¯×ª»»
#define  STANDBY   0xFD  //´ý»úÄ£Ê½/µ¥´ÎÄ£Ê½
#define  RESET     0xFE  //¸´Î»
/**********************************************************************************************************************/

void ADS1256_Write_Byte(uint8_t Data);     //Ð´Ò»¸ö×Ö½Ú
uint8_t ADS1256_Read_Byte();           //¶ÁÒ»¸ö×Ö½Ú
void ADS1256_Write_Register(uint8_t Addr,uint8_t Data);    //Ð´¼Ä´æÆ÷
uint32_t ADS1256_Read_Data(void);       //¶ÁÊý¾Ý
void ADS1256_GPIO_Init(void);         //GPIO³õÊ¼»¯
void ADS1256_Reg_Init(void);          //ADS1256¼Ä´æÆ÷³õÊ¼»¯
double ADS1256_DataFormatting(uint32_t Data , double Vref ,uint8_t PGA);


#endif


