
SawOsc saw => HPF hp => ADSR env => JCRev verb => Gain g => dac; //Setting up signal chains.
SinOsc sin => env;
SinOsc sin2 => hp;

//parameter initialisation:
0.3=> verb.mix;
120 => saw.freq;
0.3 => saw.gain; 
0.15 => g.gain;
0.6 => sin.gain;
0.2 => sin2.gain;

100 => hp.freq; // setting the initial cut off frequency
4 => hp.Q; // setting the resonance 

0::ms => dur beat; //will be used to set the note length from the beat array

[51, 51, 51, 0, 0, 0, 0, 0, 
0, 51, 51, 51, 51] @=> int pitch[]; //pitch array.

[0.4, 0.4, 0.4, 0, 0, 0, 0, 0,
0, 0.4, 0.4, 0.4, 0.4] @=> float gain_array[]; //gain array, includes 0 gain to incorporate rests between notes.

125::ms => dur bl;
[bl, bl, bl, bl, bl, bl, bl, bl, bl, bl, bl, bl, 500::ms] @=> dur beat_array[]; //creating the beat array for note length                                                                                                                  //note length.

(10::ms, 50::ms, 1.0, 5::ms) => env.set; //setting the ADSR envelope

//calling the function to play the notes
while(true)
{
   play(51, 1); //passing the function different integers so it will play different notes on different calls.
   play(51, 2); //the second integer passed is a counter
   play(48, 1); 
   play(48, 2);
}

//the definition of a function to create a swelling sound on certain notes of the pitch array by adjusting the volume 
fun void gainSweep1()
{
    for(0.1 => float f; f<0.8; f+0.0035 => f) //by iterating through this a volume swell on the current note will be created
    {
        f => saw.gain;
        f => sin.gain;
        3.5::ms => now;
    }
}

//the definition of a function that will iterate through the gain and beat arrays to play notes at the pitch passed to it when called.
fun void play(int pitch, int counter){ 
    
    for(0 => int i; i<beat_array.cap(); i++){ //loop through the arrays to play the notes
        
        if(i == beat_array.cap()-1 && counter == 2) //only swell on the last note of every second time this function is called
        {
           (20::ms, 150::ms, 1.0, 330::ms) => env.set; //setting the ADSR envelope to have a longer attack and release period
           spork~ gainSweep1(); //sporking the volume swell function to change the volume in notes while the program continues
        }
        else
        {
            (50::ms, 50::ms, 1.0, 5::ms) => env.set; //reset the envelope for every note that does not swell

        }
                   
        beat_array[i] => beat; //setting the note length from the current index of the beat array.
        gain_array[i]+0.1 => saw.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                     //create 'rests' in between notes.
        
        Std.mtof(pitch) => saw.freq; // put the pitch into frequency and pass it to the oscillators:
        gain_array[i] => sin2.gain;       
        Std.mtof(pitch-12) => sin2.freq; //bring the pitch an octave lower than the pitch of the SawOsc
        Std.mtof(pitch-12) => sin.freq;
        env.keyOn(); //trigger the envelope
        beat => now; //notes will play for the current beat value. 
        env.keyOff();
        beat => now;
          
    }
}