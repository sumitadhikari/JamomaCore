/** @file
 *
 * @ingroup modularMIDI
 *
 * @brief a MIDI input
 *
 * @details
 *
 * @author Theo Delahogue
 *
 * @copyright © 2014, GMEA (http://www.gmea.net) @n
 * This code is licensed under the terms of the "New BSD License" @n
 * http://creativecommons.org/licenses/BSD/
 */

#include "MIDIInput.h"

MIDIInput::MIDIInput(MIDIPtr protocol, TTSymbol& application) :
mProtocol(protocol),
mStream(NULL),
mPollingThread(NULL),
mRunning(NO),
mApplication(application)
{
    ;
}

MIDIInput::~MIDIInput()
{
	mRunning = NO;
    
    if (mStream) {
        Pm_Close(mStream);
        mStream = NULL;
    }
    
	if (mPollingThread)
		mPollingThread->wait();
	delete mPollingThread;
}

TTErr MIDIInput::setDevice(TTSymbol& newDevice)
{
	const PmDeviceInfo*	deviceInfo;
    int					deviceCount;
	PmError				err = pmNoError;
	
	if (newDevice != mDevice) {
        
		if (newDevice == TTSymbol("default")) {
			mID = Pm_GetDefaultInputDeviceID();
			mDeviceInfo = Pm_GetDeviceInfo(mID);
		}
		else {
            
			int i;
			
			deviceCount = Pm_CountDevices();
			for (i=0; i<deviceCount; i++) {
				deviceInfo = Pm_GetDeviceInfo(i);
				if (newDevice == TT(deviceInfo->name)) {
					mDeviceInfo = deviceInfo;
					mID = i;
					break;
				}
			}
			if (i == deviceCount)
				return kTTErrGeneric;
		}
		
		mDevice = newDevice;
        
        setRunning(NO);
		
		if (mStream) {
			Pm_Close(mStream);
			mStream = NULL;
		}
		
		err = Pm_OpenInput(&mStream, mID, NULL, kMidiBufferSize, NULL, NULL);
		if (err) {
            
			TTLogError("MIDIInput::setDevice : can't open the %s device\n", mDevice.c_str());
            return kTTErrGeneric;
        }
	}
    
	return kTTErrNone;
}

TTErr MIDIInput::setRunning(TTBoolean running)
{
    if (running != mRunning) {
        
        mRunning = running;
        
        if (mRunning) {
            
            mPollingThread = new TTThread(TTThreadCallbackType(MidiPoll), this);
        }
        else {
            
            if (mPollingThread)
                mPollingThread->wait();
            delete mPollingThread;
        }
    }
    
    return kTTErrNone;
}

void editAddress(TTString format, TTUInt8 i, TTAddress& returnedAddress)
{
    char *s_num;
    TTUInt8 len;
    
    if (i > 0) {
        len = format.size() + (TTInt32)log10((TTFloat32)i); // note : %d (lenght = 2) is replaced by 1 character (0::9), 2 charecters (10 :: 99), 3 char...
        s_num = (char *)malloc(sizeof(char)*len);
        snprintf(s_num, len, format.c_str(), i);
        returnedAddress = TTAddress(s_num);
        free(s_num);
    }
}

void* MidiPoll(MIDIInput* self)
{
	PmEvent	buffer[64];
	int		result;
	
	while (self->mRunning) {
        
		if (Pm_Poll(self->mStream)) {
            
			result = Pm_Read(self->mStream, buffer, 64);
            
            // result is an error number
			if (result < 0) {
				
				TTLogError("MidiPoll error\n");
			}
            // result is the number of midi events
			else {
                
                TTAddress   address;
                TTValue     value;
                TTBoolean   sysex = NO;
				
				for (TTInt32 i = 0; i < result; i++) {
                    
					char statusByte = Pm_MessageStatus(buffer[i].message);
					char dataByte1 = Pm_MessageData1(buffer[i].message);
					char dataByte2 = Pm_MessageData2(buffer[i].message);
                    
                    // parse command and channel
                    TTUInt8 command = statusByte & 0xF0;
                    TTUInt8 channel = (statusByte & 0x0F) + 1;
                    
                    // SYSTEM EXCLUSIVE starts : dataByte1 = id code then any number of byte
                    if (!sysex && command == 240 && channel == 1) {
                        
                        sysex = YES;
                        address = TTAddress("/sysex");
                        value = TTValue(TTUInt32(dataByte1), TTUInt32(dataByte2));
                        continue;
                    }
                    
                    if (sysex) {
                        
                        // SYSTEM EXCLUSIVE ends
                        if (command == 247 && channel == 1) {
                            sysex = NO;
                            self->mProtocol->receivedMessage(self->mApplication, address, value);
                            continue;
                        }
                        
                        value.append(TTUInt32(statusByte));
                        
                        // SYSTEM EXCLUSIVE ends
                        if (TTUInt8(dataByte1) == 247) {
                            sysex = NO;
                            self->mProtocol->receivedMessage(self->mApplication, address, value);
                            continue;
                        }
                        
                        value.append(TTUInt32(dataByte1));
                        
                        // SYSTEM EXCLUSIVE ends
                        if (TTUInt8(dataByte2) == 247) {
                            sysex = NO;
                            self->mProtocol->receivedMessage(self->mApplication, address, value);
                            continue;
                        }
                        
                        value.append(TTUInt32(dataByte2));
                        
                        continue;
                    }
                    else {
                        
                        // edit channel address part
                        TTAddress channelPart;
                        editAddress("/channel.%ld", channel, channelPart);
                        
                        // edit command address part and value
                        TTAddress commandPart;
                        
                        switch (command) {
                                
                            case 128 :  // NOTE OFF : dataByte1 = pitch, dataByte2 = velocity (always 0)
                            {
                                editAddress("note.%ld", dataByte1, commandPart);
                                value = TTUInt32(dataByte2);
                                break;
                            }
                            case 144 :  // NOTE ON : dataByte1 = pitch, dataByte2 = velocity (always > 0)
                            {
                                editAddress("note.%ld", dataByte1, commandPart);
                                value = TTUInt32(dataByte2);
                                break;
                            }
                            case 160 :  // POLY PRESSURE : dataByte1 = pitch, dataByte2 = pressure
                            {
                                editAddress("pressure.%ld", dataByte1, commandPart);
                                value = TTUInt32(dataByte2);
                                break;
                            }
                            case 176 :  // CONTROL CHANGE : dataByte1 = control type, dataByte2 = control value
                            {
                                editAddress("control.%ld", dataByte1, commandPart);
                                value = TTUInt32(dataByte2);
                                break;
                            }
                            case 192 :  // PROGRAM CHANGE : dataByte1 = program number, dataByte2 not used
                            {
                                editAddress("program.%ld", dataByte1, commandPart);
                                value.clear();
                                break;
                            }
                            case 208 :  // CHANNEL PRESSURE : dataByte1 = pressure, dataByte2 not used
                            {
                                commandPart = TTAddress("pressure");
                                value = TTUInt32(dataByte1);
                                break;
                            }
                            case 224 :  // PITCH WHEEL ? dataByte1 = LSB, dataByte2 = MSB
                            {
                                commandPart = TTAddress("wheel");
                                
                                TTUInt16 LSB = dataByte1;
                                TTUInt16 MSB = TTUInt16(dataByte2) << 8;
                                value = TTUInt32(MSB + LSB);
                                break;
                            }
                            case 240 :
                            {
                                channelPart = kTTAdrsRoot;
                                commandPart = TTAddress("system_exclusive");
                                value.clear();
                                break;
                            }
                            case 241 :  // UNDEFINED ? dataByte1 not used, dataByte2 not used
                            {
                                channelPart = kTTAdrsRoot;
                                editAddress("undefined.%ld", command, commandPart);
                                value = TTValue(TTUInt32(dataByte1), TTUInt32(dataByte2));
                                break;
                            }
                            case 242 :  // SONG POSITION ? dataByte1 = LSB, dataByte2 = MSB
                            {
                                channelPart = kTTAdrsRoot;
                                commandPart = TTAddress("song/position");
                                
                                TTUInt16 LSB = dataByte1;
                                TTUInt16 MSB = TTUInt16(dataByte2) << 8;
                                value = TTUInt32(MSB + LSB);
                                break;
                            }
                            case 243 :  // SONG SELECT ? dataByte1 = song, dataByte2 not used
                            {
                                channelPart = kTTAdrsRoot;
                                commandPart = TTAddress("song/select");
                                value = TTUInt32(dataByte1);
                                break;
                            }
                            case 244 :  // UNDEFINED ? dataByte1 not used, dataByte2 not used
                            {
                                channelPart = kTTAdrsRoot;
                                editAddress("undefined.%ld", command, commandPart);
                                value = TTValue(TTUInt32(dataByte1), TTUInt32(dataByte2));
                                break;
                            }
                            case 245 :  // UNDEFINED ? dataByte1 not used, dataByte2 not used
                            {
                                channelPart = kTTAdrsRoot;
                                editAddress("undefined.%ld", command, commandPart);
                                value = TTValue(TTUInt32(dataByte1), TTUInt32(dataByte2));
                                break;
                            }
                            case 246 :  // TUNE REQUEST ? dataByte1 not used, dataByte2 not used
                            {
                                commandPart = TTAddress("tune_request");
                                value.clear();
                                break;
                            }
                            case 247 :  // END OF EXCLUSIVE ? dataByte1 not used, dataByte2 not used
                            {
                                commandPart = TTAddress("end_of_exclusive");
                                value.clear();
                                break;
                            }
                            case 248 :  // TIMING CLOCK ? dataByte1 not used, dataByte2 not used
                            {
                                commandPart = TTAddress("clock");
                                value.clear();
                                break;
                            }
                            case 249 :  // UNDEFINED ? dataByte1 not used, dataByte2 not used
                            {
                                channelPart = kTTAdrsRoot;
                                editAddress("undefined.%ld", command, commandPart);
                                value = TTValue(TTUInt32(dataByte1), TTUInt32(dataByte2));
                                break;
                            }
                            case 250 :  // START ? dataByte1 not used, dataByte2 not used
                            {
                                commandPart = TTAddress("start");
                                value.clear();
                                break;
                            }
                            case 251 :  // CONTINUE ? dataByte1 not used, dataByte2 not used
                            {
                                commandPart = TTAddress("continue");
                                value.clear();
                                break;
                            }
                            case 252 :  // STOP ? dataByte1 not used, dataByte2 not used
                            {
                                commandPart = TTAddress("stop");
                                value.clear();
                                break;
                            }
                            case 253 :  // UNDEFINED ? dataByte1 not used, dataByte2 not used
                            {
                                channelPart = kTTAdrsRoot;
                                editAddress("undefined.%ld", command, commandPart);
                                value = TTValue(TTUInt32(dataByte1), TTUInt32(dataByte2));
                                break;
                            }
                            case 254 :  // ACTIVE SENSING ? dataByte1 not used, dataByte2 not used
                            {
                                commandPart = TTAddress("active_sensing");
                                value.clear();
                                break;
                            }
                            case 255 :  // SYSTEM RESET ? dataByte1 not used, dataByte2 not used
                            {
                                commandPart = TTAddress("reset");
                                value.clear();
                                break;
                            }
                            default :   // UNDEFINED ? dataByte1 not used, dataByte2 not used
                            {
                                channelPart = kTTAdrsRoot;
                                editAddress("undefined.%ld", command, commandPart);
                                value = TTValue(TTUInt32(dataByte1), TTUInt32(dataByte2));
                                break;
                            }
                        }
                        
                        // edit /channelPart/commandPart address
                        address = channelPart.appendAddress(commandPart);
                    }
                    
                    self->mProtocol->receivedMessage(self->mApplication, address, value);
                    
                    // TODO ? edit /raw statusByte dataByte1 dataByte2
                    // TODO ? return buffer[i].timestamp
                }
            }
        }
        
        self->mPollingThread->sleep(1);
    }
    
    return NULL;
}