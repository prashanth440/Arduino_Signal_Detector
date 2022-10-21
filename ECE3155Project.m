clear
a = arduino;
time = 0.5; % Frequency of signal snapshots.
            % Ex: If time = 0.5, 2 snapshots of the signal occur 
            % every 1 second.
            
range = 60; % Based on the time value above.
            % Ex: If time is 0.5, and range is 60, snapshots of the 
            % signal are taken twice every second for 30 seconds.
            
writeDigitalPin(a, 'D7', 0);
writeDigitalPin(a, 'D8', 1);
writeDigitalPin(a, 'D6', 0);

String = ["Year", "Month", "Day", "Hours", "Minutes", "Seconds"];
writematrix(String, "Output.csv");

Choice = menu("Click start to begin.", "Start");
while(Choice == 1)
    for i=1:1:range
        voltage1 = readVoltage(a, 'A0');
        c = clock;
        if(voltage1 > 1)
            % LED turns on when a signal is detected.
            writeDigitalPin(a, 'D9', 1);
            writeDigitalPin(a, 'D10', 0);
            
            fprintf("Signal Received at: \n");
            fprintf("Year\tMonth\tDay\tHours\tMinutes\tSeconds\n");
            fprintf("%g\t", c);
            fprintf("\n");
            fprintf("Voltage detected: %d", voltage1);
            
            % Write time to .csv file
            writematrix(c, "Output.csv", "WriteMode", "append");
            % Sound is played on a speaker for 0.5 seconds to allow 
            % LED to glow for about 0.5 seconds
            playTone(a, 'D3', 440, 0.10);
            pause(0.10);
            playTone(a, 'D3', 500, 0.10);
            pause(0.10);
            playTone(a, 'D3', 600, 0.10);
            writeDigitalPin(a, 'D9', 0);
            
        else
            fprintf("\nNo signal detected.");
            writematrix("No signal detected", "Output.csv", "WriteMode", "append");
            writeDigitalPin(a, 'D13', 1);
            writeDigitalPin(a, 'D12', 0);
            pause(time);
            writeDigitalPin(a, 'D13', 0);
        end
    end
    Choice = menu("Continue?", "Yes", "No");
end