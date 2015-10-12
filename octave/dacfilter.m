% dacfilter.m
%
% Creates a sampled-data staircase vector and filters it using the
% control system toolbox.
clear all;
close all;

pkg load control % Provides tf and lsim from the control system
		 % toolbox
setenv GNUTERM x11 % The terminal type for gnuplot

% Configure linear scan
dacrate = 1e5;	% Samples per second
start = 0; % V -- the start and end of the sweep
stop =  -0.01; % V -- the vertex point
sweeprate = 100; % V/s -- the CV sweep rate

%Step forward -- generate stair corners
stepsize = sweeprate/dacrate;
num_upsteps = round(abs(stop-start)/(stepsize))+1;
for count = 1:num_upsteps,
	cornervals(count) = start-(count-1)*(stepsize);
end

%Step backward -- generate stair corners
for count = num_upsteps+1:(2*num_upsteps)-1
	cornervals(count) = stop+(count-num_upsteps)*(stepsize);
end

% Calculate dacrate based on step size and scan speed
totalsteps = size(cornervals,2);	
cornertimes = 0:1/dacrate:(totalsteps-1)*(1/dacrate);

% Digitize staircase at samplerate Hz
samplerate = 5*dacrate; % Hz
ts = 1/samplerate;


prelength = 10*cornertimes(2); % seconds -- allow system to settle to the start value
presamplenum = prelength/ts;
prevals = zeros(1,presamplenum+1) + start;
pretimes = 0:ts:presamplenum*ts;


total_scan_samples = (cornertimes(end)+cornertimes(2))/ts;
cornercount =2;
for count = 1:total_scan_samples,
	sampletime = count*ts;
	sampletimes(count) = pretimes(end)+sampletime;
	if sampletime <= cornertimes(cornercount),
		samplevals(count) = cornervals(cornercount-1);
	elseif cornercount ~= size(cornertimes,2),
		samplevals(count) = cornervals(cornercount);
		cornercount = cornercount+1;
	else
		samplevals(count) = cornervals(end);
	end
end

samplevals_preloaded = [prevals,samplevals];
sampletimes_preloaded = [pretimes,sampletimes];
endvals = zeros(1,presamplenum)+start;
endtimes = sampletimes_preloaded(end)+ts:ts:(sampletimes_preloaded(end)+presamplenum*ts);
vanhalen_vals = [samplevals_preloaded,endvals];
vanhalen_times = [sampletimes_preloaded,endtimes];
	
fc = dacrate/4; % Filter corner frequency
order = 2;

if order == 1,
	% First order low-pass filter
	wc = 2*pi*fc;
	num_first = [1];
	den_first = [1/wc 1]; %descending powers of s;
	first_sys = tf(num_first,den_first);
	first_dsys = c2d(first_sys,ts);
	filtered = lsim(first_dsys,vanhalen_vals',vanhalen_times');
elseif order == 2,
	% Second order low-pass filters
	filterq = .577;
	wc = 2*pi*fc;
	num_second = [1];
	den_second = [(1/wc)^2 1/(filterq*wc) 1]; %descending powers of s;
	second_sys = tf(num_second,den_second);
	second_dsys = c2d(second_sys,ts);
	filtered = lsim(second_dsys,vanhalen_vals',vanhalen_times');
end

% Determine time delay
[minval,minindex] = min(filtered);
mintime_filtered = vanhalen_times(minindex);
minval_staircase = min(vanhalen_vals);
minindexes_staircase = find(vanhalen_vals == minval_staircase);
center_index = minindexes_staircase(round(size(minindexes_staircase,2)/2));
mintime_staircase = vanhalen_times(center_index); 
time_delay = mintime_filtered - mintime_staircase;

% Take derivative of filtered response
for count = 1:size(vanhalen_times,2),
	if count == size(vanhalen_times,2),
		filtered_slope(count) = filtered_slope(count-1);
	else
		filtered_slope(count) = (filtered(count+1)-filtered(count))/ts;
	end
end

% Report values
disp('********************************************');
disp('Time delay (us)');
disp(num2str(time_delay*1e6));



%plot(cornertimes,cornervals,'@');
%hold on;
plot(vanhalen_times,vanhalen_vals,'@');
hold on;
plot(vanhalen_times,filtered);
xlabel('Time (s)');
ylabel('Stairgen output (V)');
pause;
