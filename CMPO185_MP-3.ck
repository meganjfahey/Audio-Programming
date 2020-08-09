SndBuf drums[5]; //make an array of buffers

me.dir() + "samples/" => string folderPath; //get the folder directory path
["kick_01.wav", "hh_03.wav", "hh_01.wav", "snare_04.wav", "hh_05.wav"] @=> string filePaths[]; //get the sample filepaths

for(0 => int i; i < drums.cap(); i++) //iterate through the buffer array
{
    folderPath + filePaths[i] => drums[i].read; //load the filepaths into the sound buffer objects
    drums[i] => dac; //set the sndbuf objects to dac
    0 => drums[i].rate; //set the rate of the buffer objects to 0 to prevent autoplay
    0.2 => drums[i].gain; //set the gain of the objects
    if(i == 4) //for the snare sample, gain is 0.2
    {
        0.1 => drums[i].gain;
    }
}

//setting the rhythm patterns of the drum samples, using arrays, divided into semi-quavers
[1,0,1,0,0,0,0,1,1,0,1,0,1,0,0,0,1,0,1,0,0,0,0,1,1,0,1,0,1,0,0,0] @=> int kikPattern[]; 
[0,0,0,0,0,0,0,1,0,0,0,1,1,0,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0] @=> int hat3Pattern[]; 
[0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0] @=> int hat1Pattern[]; 
[0,0,0,0,1,0,0,1,0,0,0,0,1,1,0,1,0,0,0,0,1,0,0,1,0,0,0,0,1,1,1,1] @=> int snrPattern[]; 
[1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1] @=> int hat5Pattern[]; 

while(true) //loop to play and repeat the patterns
{
    for(0 => int i; i < kikPattern.cap(); i++)//for loop to iterate through the patterns
    {
        if(kikPattern[i] == 1) //if the number in the array is a 1, then play the sample
        {
            0 => drums[0].pos; //play the sample from the start of the wave
            1 => drums[0].rate; //play it at a rate of 1
        }
        if(hat3Pattern[i] == 1)
        {
            0 => drums[1].pos;
            1 => drums[1].rate;
        }
        if(hat1Pattern[i] == 1)
        {
            0 => drums[2].pos;
            1 => drums[2].rate;
        }
        if(snrPattern[i] == 1)
        {
            0 => drums[3].pos;
            1 => drums[3].rate;
        }
        if(hat5Pattern[i] == 1)
        {
            0 => drums[4].pos;
            1 => drums[4].rate;
        }
        
        
        125::ms => now; //pass time, set tempo
    }
}