

% attempt to handle pulse capture for different frequencies involved for
% bitirme


 identifierFreqs = [20, 17, 22, 23] * 1e3;
 
 % For performance testing here is the signals that are captured by the
 % mic 
 
 % Might add noise later - Really wonder how that would go %
 
 
 % Parameters for pulse generation
 pulsePeriod = 0.7e-3; % the on duration of the pulses, of course for off too
 pulseCount = 2; % number of nonzero pulses, between them will be filled with zeros
 pulseStartMoments = [1e-3, 1.3e-3, 3e-3, 0.7e-3]; % here are the start moments of different freqs
 
 % Parameters for capture
 captureDuration = 50*1e-3; % seconds 
 amplitudes = [1,1,1,1]; % amplitude of the captured freqs respectively
 
 Fs = 49e3; % sampling frequency
 ts = 0:1/Fs:captureDuration - 1/Fs;
 
 capturedSignals = zeros(length(identifierFreqs), length(ts));
 pulseSignals = zeros(length(identifierFreqs), length(ts));
 
 for i = 1:length(identifierFreqs)
     for j = 1:length(ts)
        t = ts(j);
        if(t > pulseStartMoments(i) && t < pulseStartMoments(i) + pulsePeriod * (2*pulseCount - 1) )
            t_offset = t - pulseStartMoments(i);
            t_offset = rem(t_offset, pulsePeriod * 2);
            if(t_offset < pulsePeriod)
                capturedSignals(i, j) = amplitudes(i) * cos(2*pi*t_offset * identifierFreqs(i)) ;
                pulseSignals(i,j) = amplitudes(i);
            else
                capturedSignals(i, j) = 0;
                pulseSignals(i,j) = 0;
            end
        else
           capturedSignals(i,j) = 0;
           pulseSignals(i,j) = 0;
        end
     end
     capturedSignals(i, :) = capturedSignals(i,:) + + amplitudes(i)*0.3*randn(1,length(ts));
 end
 
 figure;
 subplot(4,1,1);
 plot(ts, capturedSignals(1, :));
 hold on
 plot(ts, pulseSignals(1,:));
 
  subplot(4,1,2);
 plot(ts, capturedSignals(2, :));
  hold on
 plot(ts, pulseSignals(2,:));
 
  subplot(4,1,3);
 plot(ts, capturedSignals(3, :));
  hold on
 plot(ts, pulseSignals(3,:));
 
  subplot(4,1,4);
 plot(ts, capturedSignals(4, :));
  hold on
 plot(ts, pulseSignals(4,:));
 
 % First find the coefficients that they interfere with each other
 
 % But first lets create the sample signals for each of them %
 
 
 
 
 % Generate Sample Signals %
 
 windowLength = 15;
 windowShift = 2;
 
 
 tss = 0:1/Fs:(windowLength*1.5-1)/Fs;
 
 crossCoeffss = [];
 
 for i = 1:length(identifierFreqs)
      crossCoeffs = [];
      for j = 1:length(identifierFreqs)
         w = 2 * pi * identifierFreqs(i) / Fs;
         sampleSignal = cos(2*pi*identifierFreqs(j)*tss);
         crossCoeffs = [crossCoeffs, mean(shiftAndTakeDFTMag(sampleSignal, w, windowLength, windowShift))];
      end
      
      crossCoeffs = crossCoeffs / crossCoeffs(i);
      
      crossCoeffss = [crossCoeffss; crossCoeffs];
 end
 
 % Calculate the DFT Mags for debugging purposes %
 
 windowLength = 15;
 
 shift = 3;
 
 dftMags_capturedSignals_wrtIdentifierFreqs = zeros(length(identifierFreqs), length(identifierFreqs), floor((size(capturedSignals, 2)-windowLength)/shift) + 1);
 dftMags_times = 0:shift * 1/Fs: (size(dftMags_capturedSignals_wrtIdentifierFreqs,3)-1)*shift*1/Fs; % here for each obtained window dft we put the initial time stamp into array
 
 for i = 1:length(identifierFreqs)
    
     for j = 1:length(identifierFreqs)
        
         w = 2 * pi * identifierFreqs(j) / Fs;
         dftMags_capturedSignals_wrtIdentifierFreqs(i, j, :) = shiftAndTakeDFTMag(capturedSignals(i,:), w, windowLength, shift);
         
     end
     
 end
 
 % Here Plot Some of them %
 
 figure;
 subplot(length(identifierFreqs),1, 1);
 plot(ts, capturedSignals(1, :));
 hold on
 plot(dftMags_times, squeeze(squeeze(dftMags_capturedSignals_wrtIdentifierFreqs(1,1, :))))
  hold on
 plot(ts, pulseSignals(1,:));
 
  subplot(length(identifierFreqs),1, 2);
 plot(ts, capturedSignals(1, :));
 hold on  
 plot(dftMags_times, squeeze(squeeze(dftMags_capturedSignals_wrtIdentifierFreqs(1,2, :))))
  hold on
 plot(ts, pulseSignals(1,:));
 
  subplot(length(identifierFreqs), 1, 3);
 plot(ts, capturedSignals(1, :));
 hold on  
 plot(dftMags_times, squeeze(squeeze(dftMags_capturedSignals_wrtIdentifierFreqs(1,3, :))))
  hold on
 plot(ts, pulseSignals(1,:));
 
 
 % HELPER FUNCTIONS HERE %
 

 
 function dftMags = shiftAndTakeDFTMag(sequence, w, windowLength, shiftby)
    
    dftMags = [];
    
    leftIndex = 1;
    rightIndex = windowLength;
    
    while(rightIndex <= length(sequence))
       dftMags = [dftMags, calculateDFTMag(sequence(leftIndex:rightIndex), w)]; 
       leftIndex = leftIndex + shiftby;
       rightIndex = rightIndex + shiftby;
    end
 
 end
 
 function freqMag = calculateDFTMag(sequence, w)
    
    windowSeq = kaiser(length(sequence));
    
    sum = 0;
    
    for i = 1:length(sequence)
       sum = sum + 1 * sequence(i) * exp(-1i*w*(i-1)); 
    end
    
    freqMag = abs(sum);
 
 end
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 