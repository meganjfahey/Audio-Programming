SawOsc s => HPF hp => ADSR env => JCRev verb => Gain g => Pan2 pann => dac; //Setting up signal chains.
SawOsc s2 => hp;
SinOsc sin => env;
Noise n => hp;

//parameter initialisation:
0.3=> verb.mix;
120 => s.freq;
0.3 => s.gain; 
0.15 => g.gain;
0.2 => s2.gain;
0.6 => sin.gain;
0 => pann.pan;
0.15 => n.gain;

100 => hp.freq; // setting the initial cut off frequency
4 => hp.Q; // setting the resonance 


0::ms => dur beat; //will be used to set the note length from the beat array

(250::ms, 200::ms, 1.0, 750::ms) => env.set; //setting the ADSR envelope

[48, 48, 51, 53] @=> int pitch1[]; //pitch array.
[48, 55, 53,51 ] @=> int pitch2[]; //pitch array.
[60, 48, 51, 53] @=> int pitch3[]; //pitch array.
[60, 60, 63, 53] @=> int pitch4[]; //pitch array.
[60, 60, 63, 55] @=> int pitch5[]; //pitch array.

[0.4, 0.4, 0.4, 0.4] @=> float gain_array1[]; //gain array, includes 0 gain to incorporate rests between notes.


[500::ms, 250::ms, 750::ms, 500::ms] @=> dur beat_array1[]; //creating the beat array for note length
[250::ms, 250::ms, 500::ms, 500::ms] @=> dur beat_array2[]; //creating the beat array for note length

//the definition of a function to create a swelling sound on certain notes of the pitch array by adjusting the volume 
fun void gainSweep1()
{
        for(0.7 => float f; f>0.2; f-0.0005 => f) //swell down
    {
        f => s.gain;
        f => sin.gain;
        0.5::ms => now;
    }
    for(0.2 => float f; f<0.7; f+0.001 => f) //swell up
    {
        f => s.gain;
        f => sin.gain;
        1::ms => now;
    }

}

//the definition of a function to create panning on certain notes of the pitch array.
fun void panSweep()
{

    for(1.0 => float f; f>-1.0; f-0.001 => f) //panning from right to left
    {
        f => pann.pan;
        1::ms => now;
    }
        for(-1.0 => float f; f<1.0; f+0.001 => f) //panning from left to right
    {
        f => pann.pan;
        1::ms => now;
    }
}

while(true) //while the program is added in the master file, call play1 function
{
    play(pitch1, beat_array1, gain_array1);
    play(pitch1, beat_array1, gain_array1);
    play(pitch1, beat_array1, gain_array1);
    play(pitch2, beat_array1, gain_array1); 
    
    play(pitch3, beat_array1, gain_array1);
    play(pitch4, beat_array1, gain_array1);
    play(pitch1, beat_array1, gain_array1);
    play(pitch5, beat_array1, gain_array1);
}

//the definition of a function that will iterate through the gain and beat arrays to play notes at the pitch passed to it when called.
fun void play(int pitch[], dur beat_array[], float gain_array[]){

    for(0 => int i; i<beat_array.cap(); i++){
        
        beat_array[i] => beat; //setting the note length from the current index of the beat array.
        gain_array[i] => s.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                     //create 'rests' in between notes.
        
        Std.mtof(pitch[i]) => s.freq; // put the pitch into frequency and pass it to the oscillators:
        gain_array[i] => s2.gain;       
        Std.mtof(pitch[i]) => s2.freq;
        Std.mtof(pitch[i]) => sin.freq;
        env.keyOn();
        spork~ gainSweep1();
      //  spork~ panSweep();
        beat => now; //notes will play for the current beat value. 
        env.keyOff();
        beat => now;
            
    }

}

