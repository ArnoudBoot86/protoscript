% squaresin.m
%
% Creates a wav file that starts with a square wave and ends with a
% sine wave.  This is for testing the CGR USB oscilloscope.
%
% The created wave is 10s long.  The first 100ms of each second will
% be a 100Hz square wave, and the last 100ms will be a 100Hz sine
% wave. In between will be silence.
clear all;
close all;

%---------------------- Configuration --------------------------
periods = 10; % Number of square/sine repeats
dacrate = 44100; % samples per second
playtime = 0.005; % Seconds
amplitude = 1;
freq = 1000; % Hz


samples = dacrate * playtime;
ts = 1/dacrate;
omega = 2*pi*freq;


for i = 1:samples
  if ((ts * i) < (0.4 * playtime))
    sineval = sin( omega * ts * i );
    if (sineval > 0)
      wavevec(i) = amplitude;
    else
      wavevec(i) = -amplitude;
    endif
  elseif ((ts * i) > (0.6 * playtime) )
    wavevec(i) = amplitude * sin( omega * ts * i );
  else
    wavevec(i) = 0;
  endif
  timevec(i) = ts * i;
endfor

zerovec = zeros(1,dacrate * 1);
## longvec = ones(1,1);
## for n = 1:periods
##   if (rem(n,2) == 0)
##     longvec = [longvec,zerovec];
##   else
##     longvec = [longvec,wavevec];
##   endif
## endfor
longvec = [zerovec,wavevec,zerovec];
trigvec = [zerovec,ones(size(wavevec)),zerovec];
% wavwrite expects one or two columns of data.  For example,
% wavwrite([leftdata,rightdata],fs,bits,outfile)
wavwrite([trigvec',longvec'],dacrate,16,'squaresin.wav');

% Plotting will only work in an interactive session
plot(longvec);
xlabel('Time (s)');
ylabel('Amplitude');




