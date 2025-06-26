#include <stdint.h>

#include "../include/gpio.h"
#include "../include/utils.h"
#include "../include/uart.h"
#include "../include/xprintf.h"
#include "../include/ads.h"
double value=0;
uint8_t output_value = 0;
int main()
{
    /*
    GPIO_REG(GPIO_CTRL) |= 0x1;       // gpio0输入模式
    GPIO_REG(GPIO_CTRL) |= 0x1 << 3;  // gpio1输出模式
    GPIO_REG(GPIO_CTRL) |= 0x1 << 4;  // gpio2输出模式
    GPIO_REG(GPIO_CTRL) |= 0x1 << 6;  // gpio3输出模式
    GPIO_REG(GPIO_CTRL) |= 0x1 << 8;  // gpio4输出模式
    ...
    */
    GPIO_REG(GPIO_CTRL) |=0x5555556;//01 01 01 01 01 01 01 01 01 10
    uart_init();
    ADS1256_GPIO_Init();
    ADS1256_Reg_Init();
    
    while (1) {
        GPIO_REG(GPIO_DATA) |= 0xA;  // GPIO0输出高
        ADS1256_Write_Byte(RDATA);
        busy_wait(1);
        value = ADS1256_DataFormatting(ADS1256_Read_Data(),2.5,1);	
        xprintf("%lf\n",value);
        // 将value转换为8位数据
        output_value = (uint8_t)(value * 255 / 2.5); // 假设value的范围是0到2.5
        
        // 通过GPIO1-GPIO8输出8位数据
        GPIO_REG(GPIO_DATA) = (GPIO_REG(GPIO_DATA) & 0xFFFFFE01) | (output_value << 1);


        GPIO_REG(GPIO_DATA) &= ~0xA; // GPIO0输出低
        
    }
}
