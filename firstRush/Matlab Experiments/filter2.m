ns = [3,5,7]; % pulse counts
shifts = [0,0.0029,0.001]; % in seconds

Fs = 150 * 1e3; % 100khz of sampling

f = 40 * 1e3; % 40khz sound
fsquare = 17 * 1e3; %11khz pulse frequency

fwindow = 0.1*1e3; % 1 khz max window frequency

windowDiff = fwindow / 20;


duration = 10 * 1e-3; % 1mseconds of window

time = 0:1/Fs:duration-1/Fs; % sampled time instants

sinSignal = []; % sampled signal


for t = time
    sinSignal = [sinSignal, sin(2*pi*f*t)];
end

shift1 = 0;
shift2 = 0;
shift3 = 0;



pulse1 = generateAlternatingPulses(fsquare, shift1, Fs, duration);
pulse2 = generateAlternatingPulses(fsquare*0.95, shift2, Fs, duration);
pulse3 = generateAlternatingPulses(fsquare*0.9, shift3, Fs, duration);

window = generatePulses(fwindow, 0, Fs, duration);

samplerResolution = 2^10;

pulsedSinSignal_1 = pulse1 .* sinSignal .* window ;
pulsedSinSignal_2 = pulse2 .* sinSignal .* window ;
pulsedSinSignal_3 = pulse3 .* sinSignal .* window ;

disc_pulsedSinSignal_1 = round(pulsedSinSignal_1 / max(pulsedSinSignal_1) * samplerResolution);
disc_pulsedSinSignal_2 = round(pulsedSinSignal_2 / max(pulsedSinSignal_2) * samplerResolution);
disc_pulsedSinSignal_3 = round(pulsedSinSignal_3 / max(pulsedSinSignal_3) * samplerResolution);


sum = disc_pulsedSinSignal_1 + disc_pulsedSinSignal_2 + disc_pulsedSinSignal_3;

figure

subplot(3,1,1);
plot(disc_pulsedSinSignal_1);
subplot(3,1,2);
plot(disc_pulsedSinSignal_2);
subplot(3,1,3);
plot(disc_pulsedSinSignal_3);



figure
plot(sum)

fft_1 = abs(fftshift(fft(disc_pulsedSinSignal_1)));
fft_2 = abs(fftshift(fft(disc_pulsedSinSignal_2)));
fft_3 = abs(fftshift(fft(disc_pulsedSinSignal_3)));
fft_sum = abs(fftshift(fft(sum)));

maxValue = max([max(fft_1), max(fft_2), max(fft_3)]);

% figure
% subplot(3,1,1);
% plot(fft_1);
% ylim([0,maxValue])
% 
% subplot(3,1,2);
% plot(fft_2);
% ylim([0,maxValue])
% 
% subplot(3,1,3);
% plot(fft_3);
% ylim([0,maxValue])

figure;
plot(fft_1);
hold on;
plot(fft_2);
hold on;
plot(fft_3);

legend("1","2","3");

figure
plot(fft_sum);


function signal = generatePulses(pulseFrequency, timeShift, samplingFreq, duration)

time = 0:1/samplingFreq:duration-1/samplingFreq;

signal = [];
for t = time
    donePulses = (t-timeShift) * pulseFrequency;
    if(t>timeShift)
        modedT = rem(t-timeShift, 1/pulseFrequency);
        if(modedT < 1/pulseFrequency/2)
            signal = [signal, 1];
        else
            signal = [signal, 0];
        end
    else
        signal = [signal, 0];
    end
end

end


function signal = generateAlternatingPulses(pulseFrequency, timeShift, samplingFreq, duration)

time = 0:1/samplingFreq:duration-1/samplingFreq;

signal = [];
for t = time
    donePulses = (t-timeShift) * pulseFrequency;
    if(t>timeShift)
        modedT = rem(t-timeShift, 1/pulseFrequency);
        if(modedT < 1/pulseFrequency/2)
            state = floor(floor(t-timeShift / (1/pulseFrequency) ) / 2);
            if(state == 1)
                state = 1;
            else
                state = -1;                
            end
            
            signal = [signal, state];
        else
            signal = [signal, 0];
        end
    else
        signal = [signal, 0];
    end
end

end







