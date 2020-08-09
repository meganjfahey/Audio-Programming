SndBuf drums[3]; //make an array of buffers

me.dir() + "samples/" => string folderPath; //get the folder directory path
["kick_01.wav", "hh_02.wav", "kick_06.wav"] @=> string filePaths[]; //get the sample filepaths

for(0 => int i; i < drums.cap(); i++) //iterate through the buffer array
{
    folderPath + filePaths[i] => drums[i].read; //load the filepaths into the sound buffer objects
    drums[i] => dac; //set the sndbuf objects to dac
    0 => drums[i].rate; //set the rate of the buffer objects to 0 to prevent autoplay
    0.3 => drums[i].gain; //set the gain of the objects
    if(i == 1)
    {
        0.2 => drums[i].gain; //for the high hat sample, gain is 0.2
    }
}

//setting times to change the input patterns
10::second + now => time change1;
14::second + now => time change2;

//setting the rhythm patterns of the drum samples, using arrays, divided into semi-quavers
[1,0,1,0,0,0,0,0,1,0,1,0,0,0,0,1,1,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0] @=> int kik1Pattern[]; 
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] @=> int hat2Pattern[]; 
[0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0] @=> int kik6Pattern[]; 


[1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1,1] @=> int hat2Pattern2[]; 

while(now <= change1) //loop to play and repeat the patterns without the hat2 file
{
    play(kik1Pattern, hat2Pattern); //calling the play function with kick1 and pattern for no hat
}

while(now >change1 && now<=change2) //once the time to change has been reached, play the next segment of rhythm
{
    play(kik1Pattern, hat2Pattern2);//calling the play function with kick1 and pattern for hat
}
    fun void play(int kik1Pattern[], int hat2Pattern[])
    {
        for(0 => int i; i < kik1Pattern.cap(); i++)//for loop to iterate through the patterns
        {
            if(kik1Pattern[i] == 1) //if the number in the array is a 1, then play the sample
            {
                0 => drums[0].pos; //play the sample from the start of the wave
                1 => drums[0].rate; //play it at a rate of 1
            }
            if(hat2Pattern[i] == 1)
            {
                0 => drums[1].pos;
                1 => drums[1].rate;
            }
            if(kik6Pattern[i] == 1)
            {
                0 => drums[2].pos;
                1 => drums[2].rate;
            }

            
            
            125::ms => now; //pass time and set tempo
        }
    } 
