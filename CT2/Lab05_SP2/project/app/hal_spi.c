/* ------------------------------------------------------------------
 * --  _____       ______  _____                                    -
 * -- |_   _|     |  ____|/ ____|                                   -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
 * --   | | | '_ \|  __|  \___ \   Zuercher Hochschule Winterthur   -
 * --  _| |_| | | | |____ ____) |  (University of Applied Sciences) -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
 * ------------------------------------------------------------------
 * --
 * -- Module      : SPI Library
 * --
 * -- $Id: hal_spi.c 4720 2019-03-04 10:11:31Z akdi $
 * ------------------------------------------------------------------
 */

#ifdef MOCKED_SPI_DISPLAY
#include "hal_spi.h"
#include "hal_mocked.h"

void hal_spi_init(void) { hal_mocked_spi_init(); }

uint8_t hal_spi_read_write(uint8_t send_byte) {
  return hal_mocked_spi_read_write(send_byte);
}

#else // !MOCKED_SPI_DISPLAY
#include "hal_spi.h"
#include <reg_stm32f4xx.h>

#define BIT_TXE (uint32_t)0x00000002
#define BIT_RXNE (uint32_t)0x00000001
#define BIT_BSY (uint32_t)0x00000080

static void set_ss_pin_low(void);
static void set_ss_pin_high(void);
static void wait_10_us(void);

/*
 * according to description in header file
 */
void hal_spi_init(void) {
  RCC->APB2ENR |= 0x00001000;   /**< enable SPI clock */
  RCC->AHB1ENR |= 0x00000001;   /**< start clock on GPIO A */
  GPIOA->OSPEEDR &= 0xFFFF00FF; /**< clear P4 to P7 */
  GPIOA->OSPEEDR |= 0x0000FF00; /**< set P4 to P7 to 100 MHz */
  GPIOA->MODER &= 0xFFFF00FF;   /**< clear mode on P5 to P7 */
  /* P5 to P7, P4 output mode */
  GPIOA->MODER |= 0x0000A900; /**< Set alternate function mode on */
  /* P5 to P7, P4 output mode */
  GPIOA->AFRL &= 0x0000FFFF; /**< clear alternate function */
  GPIOA->AFRL |= 0x55550000; /**< Set SPI1 alternate function */

  SPI1->CR2 = 0x0000; /**< set spi to default state */
  SPI1->CR1 = 0x0000; /**< set spi to default state */

  /// STUDENTS: To be programmed

  SPI1->CR1 = 0x33C;
  SPI1->CR1 |= 1 << 6; // SPE

  /// END: To be programmed
  set_ss_pin_high();
}

/*
 * according to description in header file
 */
uint8_t hal_spi_read_write(uint8_t send_byte) {
  /// STUDENTS: To be programmed
  uint8_t receive_byte = 0x0;

  set_ss_pin_low();
  SPI1->DR = send_byte;

  while ((SPI1->SR & BIT_TXE) == 0) {
  }; // wait for txe flag

  while ((SPI1->SR & BIT_RXNE) == 0) {
  }; // wait for rxne flag

  receive_byte = SPI1->DR;

  while (((SPI1->SR & BIT_TXE) == 0) && ((SPI1->SR & BIT_BSY) != 0)) {
  }; // wait for bsy flag

  wait_10_us();
  set_ss_pin_high();

  return receive_byte;
  /// END: To be programmed
}

/**
 * Set Slave-Select Pin (Port A, Pin 5) low
 *
 * No parameters
 *
 * No returns
 */
static void set_ss_pin_low(void) {
  GPIOA->BSRR |= 0x0010 << 16; /**< Set Port A, Pin 5 low */
}

/**
 * Set Slave-Select Pin (Port A, Pin 5) high
 *
 * No parameters
 *
 * No returns
 */
static void set_ss_pin_high(void) {
  GPIOA->BSRR |= 0x0010; /**< Set Port A, Pin 5 high */
}

/**
 * Wait for approximately 10us
 *
 * No parameters
 *
 * No returns
 */
static void wait_10_us(void) {
  uint8_t counter = 0;
  while (counter < 160) {
    counter++;
  }
}

#endif // MOCKED_SPI_DISPLAY