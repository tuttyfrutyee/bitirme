ns = [3,5,7]; % pulse counts
shifts = [0,0.0029,0.001]; % in seconds

Fs = 300 * 1e3; % 100khz of sampling

f = 40 * 1e3; % 40khz sound
fsquare = 10 * 1e3; %11khz pulse frequency

fwindow = 1*1e3; % 1 khz max window frequency

windowDiff = fwindow / 20;

fwindow1 = fwindow ;
fwindow2 = fwindow - windowDiff * 1;
fwindow3 = fwindow - windowDiff * 2;
fwindow3 = fwindow - windowDiff * 3;



duration = 10 * 1e-3; % 1mseconds of window

time = 0:1/Fs:duration-1/Fs; % sampled time instants

sinSignal = []; % sampled signal


for t = time
    sinSignal = [sinSignal, sin(2*pi*f*t)];
end

shift1 = 0;
shift2 = 0;
shift3 = 0;



pulse1 = generatePulses(fsquare, shift1, Fs, duration);
pulse2 = generatePulses(fsquare, shift2, Fs, duration);
pulse3 = generatePulses(fsquare, shift3, Fs, duration);

window1 = generatePulses(fwindow1, shift1, Fs, duration);
window2 = generatePulses(fwindow2, shift1, Fs, duration);
window3 = generatePulses(fwindow3, shift1, Fs, duration);



pulsedSinSignal_1 = pulse1 .* sinSignal;
pulsedSinSignal_2 = pulse2 .* sinSignal;
pulsedSinSignal_3 = pulse3 .* sinSignal;

output1 = pulsedSinSignal_1 .* window1;
output2 = pulsedSinSignal_2 .* window2;
output3 = pulsedSinSignal_3 .* window3;

sum = output1 + output2 + output3;

figure

subplot(3,1,1);
plot(output1);
subplot(3,1,2);
plot(output2);
subplot(3,1,3);
plot(output3);

figure
plot(sum)

fft_1 = abs(fftshift(fft(output1)));
fft_2 = abs(fftshift(fft(output2)));
fft_3 = abs(fftshift(fft(output3)));
fft_sum = abs(fftshift(fft(sum)));

maxValue = max([max(fft_1), max(fft_2), max(fft_3)]);

figure
subplot(3,1,1);
plot(fft_1);
ylim([0,maxValue])

subplot(3,1,2);
plot(fft_2);
ylim([0,maxValue])

subplot(3,1,3);
plot(fft_3);
ylim([0,maxValue])

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

