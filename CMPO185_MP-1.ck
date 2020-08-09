TriOsc tri => ADSR env => NRev verb => Gain g => Echo eco => dac; //Setting up signal chains.
SawOsc saw => LPF lp => env;

//parameter initialisation:
0.05=> verb.mix;
120 => tri.freq;
0.8 => tri.gain; 
0.3 => g.gain;
0.8 => saw.gain;

400 => lp.freq; // setting the initial cut off frequency
2 => lp.Q; // setting the resonance 

//echo initialisation:
5000::ms => eco.max; 
0::ms => eco.delay; 
0 => eco.mix; 
0.6 => eco.gain;

0::ms => dur beat; //will be used to set the note length from the beat array

[60, 0, 0, 0, 60, 0, 60, 0] @=> int pitch[]; //pitch array.
[0.8, 0, 0, 0, 0.8, 0, 0.8, 0] @=> float gain_array[]; //gain array, includes 0 gain to incorporate rests between notes.

[125::ms, 125::ms, 125::ms, 125::ms, 125::ms, 125::ms, 125::ms, 125::ms] @=> dur beat_array[]; //creating the beat array for note length.
                                                                                                                   
(5::ms, 0.5::ms, 1.0, 5::ms) => env.set; //setting the ADSR envelope

while(true) //infinite loop to continuously iterate through the note arrays
{
    for(0 => int i; i<pitch.cap(); i++){
       
        312.5::ms => eco.delay; //setting the echo delay to create a bubbly sound
        0.45 => eco.mix;  
        
        beat_array[i] => beat; //setting the note length from the current index of the beat array.
        gain_array[i] => tri.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                 //create 'rests' in between notes.      
        Std.mtof(pitch[i]) => tri.freq; // put the pitch into frequency and pass it to the oscillators:
        gain_array[i] => saw.gain;       
        Std.mtof(pitch[i]) => saw.freq;
        env.keyOn(); //trigger the envelope 
        beat => now; //notes will play for the current beat value. 
        env.keyOff();
        beat => now;            
    }
}