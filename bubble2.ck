//Megan Fahey CMPO185 Assignment 2 300438767

SinOsc s => ADSR env => NRev verb => Gain g => Echo eco => dac; //Setting up signal chains.
SinOsc s2 => LPF lp => env;


//parameter initialisation:
0.05=> verb.mix;
120 => s.freq;
0.6 => s.gain; 
0.35 => g.gain;
0.6 => s2.gain;


800 => lp.freq; // setting the initial cut off frequency
2 => lp.Q; // setting the resonance 

5000::ms => eco.max; //echo initialisation:
0::ms => eco.delay; 
0 => eco.mix; 
0.5 => eco.gain;

0::ms => dur beat; //counter to iterate through the beat array
0 => int echo_count; //counter to determine when to start echoing. 

[63, 63, 63, 63, 63, 63, 63, 63] @=> int pitch[]; //pitch array.
[60, 60, 63, 63, 60, 63, 63, 63] @=> int pitch2[]; //pitch array.
[63, 63, 65, 65, 63, 65, 65, 65] @=> int pitch3[]; //pitch array.
[67, 67, 65, 65, 67, 63, 65, 63] @=> int pitch4[]; //pitch array.


[0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5] @=> float gain_array[]; //gain array, includes 0 gain to incorporate rests between notes.


[62.5::ms, 62.5::ms, 62.5::ms, 62.5::ms, 62.5::ms, 62.5::ms, 62.5::ms, 62.5::ms] @=> dur beat_array[]; //creating the beat array for 
                                                                                                                   //note length.

(5::ms, 0.5::ms, 1.0, 5::ms) => env.set; //setting the ADSR envelope

0 => int rep_count;
0 => int rep2_count;

while(true)
{
    while(rep2_count == 0){
        
        if(rep_count <=3){
            
            for(0 => int i; i<pitch.cap(); i++){
                
                if(echo_count >=0) //on the 5th repetition, start echoing:
                {
                    0.2 => g.gain; //adjust the gain to keep the volume as it was before.
                    //if(i<9)
                    //{              
                        125::ms => eco.delay; //make the echo delay so that it comes after the first group of notes in the repetition.
                        0.8 => eco.mix;
                   // }
                   // else if(i>=9) //create a different echo delay for the second group of notes:
                   // {              
                   //    400::ms => eco.delay; 
                     //  0.3 => eco.mix; // increase here to create more 'solid' echo notes.
                   // }
                    
                    
                }
               
                if(i%3 == 0){
                    beat_array[i] => beat; //setting the note length from the current index of the beat array.
                    gain_array[i] => s.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                             //create 'rests' in between notes.
                    
                    Std.mtof(pitch[i]+12) => s.freq; // put the pitch into frequency and pass it to the oscillators:
                    gain_array[i] => s2.gain;       
                    Std.mtof(pitch[i]+12) => s2.freq;
                    env.keyOn();
                    beat => now; //notes will play for the current beat value. 
                    env.keyOff();
                    beat => now;
                }
                else{
                    beat_array[i] => beat; //setting the note length from the current index of the beat array.
                    gain_array[i] => s.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                             //create 'rests' in between notes.
                    
                    Std.mtof(pitch[i]) => s.freq; // put the pitch into frequency and pass it to the oscillators:
                    gain_array[i] => s2.gain;       
                    Std.mtof(pitch[i]) => s2.freq;
                    env.keyOn();
                    beat => now; //notes will play for the current beat value. 
                    env.keyOff();
                    beat => now;
                }
                
          
                    
            }
        }
        
        else if(rep_count > 3){
            for(0 => int i; i<pitch2.cap(); i++){
                
                if(echo_count >=0) //on the 5th repetition, start echoing:
                {
                    0.4 => g.gain; //adjust the gain to keep the volume as it was before.
                    //if(i<9)
                    //{              
                        125::ms => eco.delay; //make the echo delay so that it comes after the first group of notes in the repetition.
                        0.8 => eco.mix;
                   // }
                   // else if(i>=9) //create a different echo delay for the second group of notes:
                   // {              
                   //    400::ms => eco.delay; 
                     //  0.3 => eco.mix; // increase here to create more 'solid' echo notes.
                   // }
                    
                    
                }
               
                if(i%3 == 0){
                    beat_array[i] => beat; //setting the note length from the current index of the beat array.
                    gain_array[i] => s.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                             //create 'rests' in between notes.
                    
                    Std.mtof(pitch2[i]+12) => s.freq; // put the pitch into frequency and pass it to the oscillators:
                    gain_array[i] => s2.gain;       
                    Std.mtof(pitch2[i]+12) => s2.freq;
                    env.keyOn();
                    beat => now; //notes will play for the current beat value. 
                    env.keyOff();
                    beat => now;
                }
                else{
                    beat_array[i] => beat; //setting the note length from the current index of the beat array.
                    gain_array[i] => s.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                             //create 'rests' in between notes.
                    
                    Std.mtof(pitch2[i]) => s.freq; // put the pitch into frequency and pass it to the oscillators:
                    gain_array[i] => s2.gain;       
                    Std.mtof(pitch2[i]) => s2.freq;
                    env.keyOn();
                    beat => now; //notes will play for the current beat value. 
                    env.keyOff();
                    beat => now;
                }
                
          
                    
            }
        }
            
            echo_count++; //increase the count for the amount of repetitions.
        
            if(rep_count == 7){
                0 => rep_count;
                1 => rep2_count;
            }
            else if(rep_count < 7){
                rep_count++;
            }
        }
            
         while(rep2_count == 1){
                if(rep_count <=3){
            
            for(0 => int i; i<pitch3.cap(); i++){
                
                if(echo_count >=0) //on the 5th repetition, start echoing:
                {
                    0.4 => g.gain; //adjust the gain to keep the volume as it was before.
                    //if(i<9)
                    //{              
                        125::ms => eco.delay; //make the echo delay so that it comes after the first group of notes in the repetition.
                        0.8 => eco.mix;
                   // }
                   // else if(i>=9) //create a different echo delay for the second group of notes:
                   // {              
                   //    400::ms => eco.delay; 
                     //  0.3 => eco.mix; // increase here to create more 'solid' echo notes.
                   // }
                    
                    
                }
               
                if(i%3 == 0){
                    beat_array[i] => beat; //setting the note length from the current index of the beat array.
                    gain_array[i] => s.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                             //create 'rests' in between notes.
                    
                    Std.mtof(pitch3[i]+12) => s.freq; // put the pitch into frequency and pass it to the oscillators:
                    gain_array[i] => s2.gain;       
                    Std.mtof(pitch3[i]+12) => s2.freq;
                    env.keyOn();
                    beat => now; //notes will play for the current beat value. 
                    env.keyOff();
                    beat => now;
                }
                else{
                    beat_array[i] => beat; //setting the note length from the current index of the beat array.
                    gain_array[i] => s.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                             //create 'rests' in between notes.
                    
                    Std.mtof(pitch3[i]) => s.freq; // put the pitch into frequency and pass it to the oscillators:
                    gain_array[i] => s2.gain;       
                    Std.mtof(pitch3[i]) => s2.freq;
                    env.keyOn();
                    beat => now; //notes will play for the current beat value. 
                    env.keyOff();
                    beat => now;
                }
                
          
                    
            }
        }
        
        else if(rep_count > 3){
            for(0 => int i; i<pitch4.cap(); i++){
                
                if(echo_count >=0) //on the 5th repetition, start echoing:
                {
                    0.4 => g.gain; //adjust the gain to keep the volume as it was before.
                    //if(i<9)
                    //{              
                        125::ms => eco.delay; //make the echo delay so that it comes after the first group of notes in the repetition.
                        0.8 => eco.mix;
                   // }
                   // else if(i>=9) //create a different echo delay for the second group of notes:
                   // {              
                   //    400::ms => eco.delay; 
                     //  0.3 => eco.mix; // increase here to create more 'solid' echo notes.
                   // }
                    
                    
                }
               
                if(i%3 == 0){
                    beat_array[i] => beat; //setting the note length from the current index of the beat array.
                    gain_array[i] => s.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                             //create 'rests' in between notes.
                    
                    Std.mtof(pitch4[i]+12) => s.freq; // put the pitch into frequency and pass it to the oscillators:
                    gain_array[i] => s2.gain;       
                    Std.mtof(pitch4[i]+12) => s2.freq;
                    env.keyOn();
                    beat => now; //notes will play for the current beat value. 
                    env.keyOff();
                    beat => now;
                }
                else{
                    beat_array[i] => beat; //setting the note length from the current index of the beat array.
                    gain_array[i] => s.gain; //setting the gain from the current index of the gain array: there are gains of 0 included to 
                                             //create 'rests' in between notes.
                    
                    Std.mtof(pitch4[i]) => s.freq; // put the pitch into frequency and pass it to the oscillators:
                    gain_array[i] => s2.gain;       
                    Std.mtof(pitch4[i]) => s2.freq;
                    env.keyOn();
                    beat => now; //notes will play for the current beat value. 
                    env.keyOff();
                    beat => now;
                }
                
          
                    
            }
        }
            
            echo_count++; //increase the count for the amount of repetitions.
        
                if(rep_count == 7){
                    0 => rep_count;
                    0 => rep2_count;
                }
                else if(rep_count < 7){
                    rep_count++;
                }
                }
              
            
        
}