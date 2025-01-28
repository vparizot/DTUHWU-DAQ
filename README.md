The data acquisition (DAQ) files for the DTU/HWU 2024-2025 Clinic Team.

## SENSORS

### Current Sensor
We use a ACS712 5A Current sensor, which can measure ±5A corresponding to a voltage output of ±1V range. The voltage output to current can be related by a 185mV/A constant.

[ACS712 Datasheet](https://cdn.sparkfun.com/assets/4/a/a/0/8/ACS712.pdf)

[ACS712 Purchase Link](https://www.amazon.com/Ferwooh-Current-ACS712ELC-05B-Measuring-Indicator/dp/B0D1K8SQQZ/ref=sr_1_3?dib=eyJ2IjoiMSJ9.9iXHDdkqCh9usbrI5-JT4X30IlCQFDjRNSK-jQuS0a9twnJeLx95jMzKKHQ4zG_kYXD3HA4f1HJQRSwfxFqlrHB1ZkzwEPaMbATw6AydJ1hpCdrmjFPvByGU6rkeghXp-y_Yi-SXtDUSHwgrpr6-rVef56bROy3ErBzsDtKvdK_vCEBZNj4Xpzyyj9LiyXqYSUNTgVk0RTb1Tfp4-uHM4hYO4jAHi_a1sS0TibVO5pg.uH5i2Ra4VGfqaA8YjAOWUDTOB-hIcCpBGsNAOLSlJik&dib_tag=se&keywords=ACS712%2B5A&qid=1737875295&sr=8-3&th=1)


### Wind Speed 
To measure wind speed we use an anemometer. We can convert the output voltage to the wind speed (in m/s) with the following equation: Wind Speed [m/s] = Vout/5 * 45  = Vout*9

[Anemometer purchase link](https://www.amazon.com/Anemometers-Monitoring-Outdoor-Weather-Station/dp/B01MZAO4BZ?th=1)


### Wind Vane (Wind Direction)

## CODE
The data is collected using a Teensy 4.0 ("DataAcq.ino") and visualized with MatLab ("DACVisualization.m")
