SawOsc s => HPF hp => ADSR env => JCRev verb => Gain g => Pan2 pann => dac; //Setting up signal chains.
SawOsc s2 => hp;
SinOsc sin => env;
Noise n => hp;

//parameter initialisation:
0.3=> verb.mix;
120 => s.freq;
0.3 => s.gain; 
0.3 => g.gain;
0.3 => s2.gain;
0.6 => sin.gain;
0 => pann.pan;
0.1 => n.gain;

100 => hp.freq; // setting the initial cut off frequency
4 => hp.Q; // setting the resonance 


[500::ms, 500::ms, 3000::ms] @=> dur beat_array[]; //beat array

0::ms => dur beat; //will be used to set the note length from the beat array

(1500::ms, 500::ms, 1.0, 1000::ms) => env.set; //setting the ADSR envelope


for(0 => int i; i<beat_array.cap(); i++){ //iterate through the arrays to create notes.
        
        beat_array[i] => beat; //setting the note length from the current index of the beat array.

        Std.mtof(48) => s.freq; // put the pitch of 48 into frequency and pass it to the oscillators:    
        Std.mtof(48) => s2.freq;
        Std.mtof(48) => sin.freq;
        env.keyOn();

        if(i == beat_array.cap()-1) //on the last note to be played, increase the volume
        {
            0.3 => s.gain;
            0.3 => sin.gain;
            0.0 => n.gain;
            0.15 => g.gain;
        }
        beat => now; //notes will play for the current beat value. 
        env.keyOff();
        beat => now;
            
    }

