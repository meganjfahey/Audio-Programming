TriOsc t => ADSR env => PRCRev verb => Gain g => dac; //Setting up signal chains.
SinOsc s2 => LPF lp => env;


//parameter initialisation:
0.3=> verb.mix;
120 => t.freq;
0.8 => t.gain; 
0.3 => g.gain;
0.8 => s2.gain;

400 => lp.freq; // setting the initial cut off frequency
2 => lp.Q; // setting the resonance 

//Setting the pitch arrays
[68, 0, 0, 67, 65, 0, 63, 0, 65, 0, 67, 0, 67, 0, 0, 0] @=> int pitch1[];
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 63] @=> int pitch2[];
[65, 0, 67, 0, 65, 63, 63, 0, 65, 0, 63, 0, 63, 60, 0, 0] @=> int pitch3[];
[67, 0, 0, 0, 63, 0, 63, 0, 62, 0, 62, 0, 62, 63, 0, 0] @=> int pitch4[];

//setting the gain arrays
[0.6, 0, 0, 0.6, 0.6, 0, 0.6, 0, 0.6, 0, 0.6, 0, 0.6, 0, 0, 0] @=> float gain_array1[];
[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6] @=> float gain_array2[];
[0.6, 0, 0.6, 0, 0.6, 0.6, 0.6, 0, 0.6, 0, 0.6, 0, 0.6, 0.6, 0, 0] @=> float gain_array3[];
[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0] @=> float gain_array4[];
[0.6, 0, 0, 0, 0.6, 0, 0.6, 0, 0.6, 0, 0.6, 0, 0.6, 0.6, 0, 0] @=> float gain_array5[];

[125::ms, 125::ms, 125::ms, 125::ms, 125::ms, 125::ms, 125::ms, 125::ms, 
125::ms, 125::ms, 125::ms, 125::ms, 125::ms, 125::ms, 125::ms, 125::ms] @=> dur beat_array1[];




0::ms => dur beat; //will be used to set the note length from the beat array

(20::ms, 50::ms, 1.0, 50::ms) => env.set; //setting the ADSR envelope

//defining a function to play the notes, takes a pitch array, beat array and gain array that match up, as parameters
fun void play(int pitch[], dur beat_array[], float gain_array[])
{
    for(0=> int i; i<pitch1.cap(); i++)
    {
        beat_array[i] => beat;        
        gain_array[i] => t.gain;
        gain_array[i] => s2.gain;
        Std.mtof(pitch[i]+12) => t.freq; // set the triosc an octave higher than the sineosc          
        Std.mtof(pitch[i]) => s2.freq;
        
        env.keyOn();
        beat => now; //notes will play for the current beat value. 
        env.keyOff();
        beat => now;
    }
}
while(true)//while the program is being called in the master function, this loop will keep calling the play function with the following 
           //specified inputs:
{
    play(pitch1, beat_array1, gain_array1);
    play(pitch2, beat_array1, gain_array2);
    play(pitch3, beat_array1, gain_array3);
    play(pitch2, beat_array1, gain_array4);
    
    play(pitch4, beat_array1, gain_array5);
    play(pitch2, beat_array1, gain_array2);
    play(pitch3, beat_array1, gain_array3);
    play(pitch2, beat_array1, gain_array4);
    
    
}
