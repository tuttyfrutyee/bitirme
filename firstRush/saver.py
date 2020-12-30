#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Dec 23 17:17:18 2020

@author: tuttyfruty
"""

import serial
import numpy as np

#to parse c float32 to python float
from struct import *
import time
import matplotlib.pyplot as plt

# Configuring and starting Serial communication
ser = serial.Serial() # Creating serial port object
ser.baudrate = 115200
ser.port = "/dev/cu.SLAB_USBtoUART" # Port being used
ser.timeout = 1

angleFileName = "angles.txt"
registerFileName = "registers.txt"


angleFile = open(angleFileName, 'w')
registerFile = open(registerFileName, 'w')

ser.open()




angles = []
timeStamps = []


start = time.time()
while (True):
    # Monitoring the esp logs
    if(ser.isOpen() !=False):

        if (ser.inWaiting() > 0):

            reading = (ser.readline().decode("ISO-8859-1")).strip() # Strip to eliminate the newline at the end of the line, since logger already introduces one
            if  len(reading)>1: # To eliminate null char appearing at the beginning (It messes the encoding)

                print(reading)
                if "#" in reading: # if it is register data
                    a = 3                    
                elif "$" in reading: # if it is angle data
                    angle = float(reading.split("_")[1])
                    timeStamp= int(reading.split("_")[2])
                    
                    angleFile.write(reading + "\n")
                    
                    angles.append(angle)
                    timeStamps.append(timeStamp)
                    
                    diff = time.time() - start
                    print(diff)
                    if(diff > 80):
                        angleFile.close()
                        ser.close()
                        break
                                        
                    
                    
    time.sleep(.001)
                    
plt.figure()    
plt.plot(angles)
plt.figure()
plt.plot(timeStamps)
                    
                    
                    
                    
                    
                    
                    
                    



         