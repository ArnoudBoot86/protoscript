% squaresin.m
%
% Creates a wav file that starts with a square wave and ends with a
% sine wave.  This is for testing the CGR-101 USB oscilloscope.
%
% The created wave is split into sections as follows:
%
% |-------- qtime --------| 2ms | 1ms | 2ms |-------- qtime --------|
%          Silence           Square / Sine           Silence
%
% The square/sine region starts with 2 cycles of a 1kHz square wave,
% followed by 1ms of silence, followed by 2 cycles of a 1kHz sine
% wave.
%
% The second output is meant to trigger the scope.  It simply goes
% high for the length of the square/sine region.

clear all;
close all;

%---------------------- Configuration --------------------------
periods = 10; % Number of square/sine repeats
dacrate = 44100; % samples per second
wavetime = 0.005; % Seconds -- time in square/sine region
amplitude = 1;
freq = 1000; % Hz -- frequency of the square and sine waves
qtime = 0.01 % Seconds -- the quiet time before and after the wave region

samples = dacrate * wavetime;
ts = 1/dacrate;
omega = 2*pi*freq;

for i = 1:samples
  if ((ts * i) < (0.4 * wavetime))
    sineval = sin( omega * ts * i );
    if (sineval > 0)
      wavevec(i) = amplitude;
    else
      wavevec(i) = -amplitude;
    endif
  elseif ((ts * i) > (0.6 * wavetime) )
    wavevec(i) = amplitude * sin( omega * ts * i );
  else
    wavevec(i) = 0;
  endif
  timevec(i) = ts * i;
endfor

% Create the beginning and ending silence regions
zerovec = zeros(1,dacrate * qtime);
longvec = [zerovec,wavevec,zerovec];
trigvec = [zerovec,ones(size(wavevec)),zerovec];
timevec = [0:ts:(ts*(size(longvec)(2) - 1))];

% Create a wav audio file
% wavwrite expects one or two columns of data.  For example,
% wavwrite([leftdata,rightdata],fs,bits,outfile)
wavwrite([trigvec',longvec'],dacrate,16,'squaresin.wav');

% Plotting will only work in an interactive session
plot(timevec * 1000, longvec,';Right channel;',
     timevec * 1000, trigvec,';Left channel;');
xlabel('Time (ms)');
ylabel('Amplitude');




