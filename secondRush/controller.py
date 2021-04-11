#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Apr 11 19:08:16 2021

@author: tuttyfrutyee
"""

import paho.mqtt.client as mqtt
import time
import numpy as np
import matplotlib.pyplot as plt
import threading
from threading import Thread
import os
import struct 
import matplotlib.pyplot as plt

client = None



def readDump():
    
    totalNumberOfMeasurements = int(totalLength / (6))
    
    for i in range(totalNumberOfMeasurements):
        timeStampBytes = dumpFile.read(4)
        voltageBytes = dumpFile.read(2)
        
        timeStamp = struct.unpack("<I", timeStampBytes)
        voltage = struct.unpack("<H", voltageBytes)
        
        measurements.append((timeStamp, voltage))
    
    dumpFile.close()
    
    return np.array(measurements)

def visualizeMeasurements(measurements):
    fig = plt.figure()
    plt.plot(measurements[:,0]*1e-6, measurements[:,1])
    fig.suptitle('Measurements', fontsize=15)
    plt.xlabel('Timestamp(seconds)', fontsize=13)
    plt.ylabel('Voltage(unknown)', fontsize=13)

def sendCommand_dump(room_id, device_id):
    global client
    client.publish("/"+str(room_id) + "/" + str(device_id) + "/samplerCommand", "0")
    
def seeBigMeasurementQueue():
    sendCommand_dump()
    time.sleep(1)
    fetchDump()
    measurements = readDump()
    visualizeMeasurements(measurements)


def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))

    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    
    client.subscribe("/0/0/samplerDump")


def on_message(client, userdata, msg):
    
    print("Got Message\n")
    
    if(msg.topic == "/0/0/samplerDump"):
        try:
            
            messageLength = len(msg.payload)
            print(str(messageLength))
            formatString = "<"
            for i in range(int(messageLength / 10)):
                formatString += "qH"
            stuff = struct.unpack(formatString, msg.payload)
            print(stuff[0:5])
            #currentImage = [floatTuples[len(floatTuples) - x - 1] for x in range(len(floatTuples))]

        except Exception as e:
            print("Upper exception occured",e)

    
def mqttMonitor():
    
    global client
    
    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message
    
    
    client.connect("192.168.1.32", 1883)
    client.loop_forever()     
    
    
    

monitor = Thread(target=mqttMonitor, args = ())

monitor.start()