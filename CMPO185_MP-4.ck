
SinOsc s => ADSR env => NRev verb => Gain g => Echo eco => Pan2 panner => dac; //Setting up signal chains.
SinOsc s2 => LPF lp => env;


//parameter initialisation:
0.05=> verb.mix;
120 => s.freq;
0.8 => s.gain; 
0.3 => g.gain;
0.8 => s2.gain;


800 => lp.freq; // setting the initial cut off frequency
2 => lp.Q; // setting the resonance 

5000::ms => eco.max; //echo initialisation:
0::ms => eco.delay; 
0 => eco.mix; 
0.5 => eco.gain;

0::ms => dur beat; //will be used to set the note length from the beat array

[63, 63, 63, 63] @=> int pitch1[]; //pitch arrays, differing, to be called at different points.
[0, 0, 0, 0] @=> int pitch2[]; 
[65, 65, 65, 65] @=> int pitch3[]; 
[67, 67, 67, 67] @=> int pitch4[]; 
[60, 60, 60, 60] @=> int pitch5[]; 

[0.8, 0.8, 0.8, 0.8] @=> float gain_array[]; //gain array, includes 0 gain to incorporate rests between notes.
[0.0, 0.0, 0.0, 0.0] @=> float zero_gain_array[];

[62.5::ms, 62.5::ms, 62.5::ms, 62.5::ms] @=> dur beat_array[]; //creating the beat array for note length
                                                                                                                  
(5::ms, 0.5::ms, 1.0, 5::ms) => env.set; //setting the ADSR envelope

//defining a function that takes a pitch array, an integer to specify repeat number, a gain array to match the pitched wanted, 
//and an integer to set a harmony. 
fun void play1(int pitch[], int repeats, float gain_array[], int harmo) 
{
    for(0 => int x; x<repeats; x++){ //loop the play function for the amount of times speciifed on calling. 
        for(0 => int i; i<gain_array.cap(); i++){
                              
            125::ms => eco.delay; //set the echo delay.
            0.8 => eco.mix;
            Std.rand2f(-0.5,0.5)=> panner.pan;  //generating a random float to set pan for every note        
           
            if(i%3 == 0){ //on the third note of the array set the pitch to be an octave higher. 
                beat_array[i] => beat; //setting the note length from the current index of the beat array.
                gain_array[i] => s.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                         //create 'rests' in between notes.
                
                Std.mtof(pitch[i]+12) => s.freq; // put the pitch into frequency and pass it to the oscillators:
                gain_array[i] => s2.gain;       
                Std.mtof(pitch[i]+harmo) => s2.freq;
                //play the notes
                env.keyOn();
                beat => now; //notes will play for the current beat value. 
                env.keyOff();
                beat => now;
            }
            
            else{ //for every other note than the 3rd note of array, don't set the octave higher for pitch.
                beat_array[i] => beat; 
                gain_array[i] => s.gain; 
                
                Std.mtof(pitch[i]) => s.freq; 
                gain_array[i] => s2.gain;       
                Std.mtof(pitch[i]) => s2.freq;
                //play the notes
                env.keyOn();
                beat => now; 
                env.keyOff();
                beat => now;
            }               
        }       
    }
}
while(true) //while the program is being called in the master function, this loop will keep calling the play function with the following 
            //specified inputs:
{
    //each block represents 2 'bars' of the piece (at 2 seconds each), where there are 4 repeats per bar.
    play1(pitch1, 2, gain_array,12);
    play1(pitch2, 2, zero_gain_array,12);
    play1(pitch1, 3, gain_array,9);
    play1(pitch2, 1, zero_gain_array,12);
    
    play1(pitch1, 2, gain_array,12);
    play1(pitch2, 3, zero_gain_array,12);
    play1(pitch3, 1, gain_array,7);
    play1(pitch4, 1, gain_array,5);
    play1(pitch3, 1, gain_array,7);
    
    play1(pitch5, 2, gain_array,12);
    play1(pitch2, 2, zero_gain_array,12);
    play1(pitch5, 3, gain_array,15);
    play1(pitch2, 1, zero_gain_array,12);
    
    play1(pitch5, 2, gain_array,12);
    play1(pitch2, 3, zero_gain_array,12);
    play1(pitch3, 1, gain_array,7);
    play1(pitch4, 1, gain_array,5);
    play1(pitch3, 1, gain_array,7);
}
