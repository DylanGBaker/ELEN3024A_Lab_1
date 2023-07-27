function [Message_Signal, Carrier_Signal, Modulated_Signal, Frequency_Spectra] = DSB_FC_Modulator(normalised_message_signal, carrier_signal, modulation_index)
Message_Signal = normalised_message_signal;
Carrier_Signal = carrier_signal;

Modulated_Signal = (1 + (modulation_index*normalised_message_signal)).*carrier_signal; 

Frequency_Spectra = fftshift(fft(Modulated_Signal));
end