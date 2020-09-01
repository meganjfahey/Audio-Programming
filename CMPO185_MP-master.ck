//Master file for multi-threading, and controlling the different layers of this piece to make sure they come in and out at the desired time:

// A-section

Machine.add(me.dir()+"CMPO185_MP-1.ck") => int id1; // adding the first file - beeping sound loop
8::second => now; //passing time

Machine.add(me.dir()+"CMPO185_MP-2.ck") => int id2; // adding fizzy bass loop
16::second => now;

Machine.add(me.dir()+"CMPO185_MP-3.ck") => int id3; // adding A-section percussion 1 (lite)
Machine.add(me.dir()+"CMPO185_MP-4.ck") => int id4; // adding Bubble loop 1 (lite)
16::second => now;

Machine.add(me.dir()+"CMPO185_MP-5.ck") => int id5; // adding vocal-like sound
16::second => now;

Machine.add(me.dir()+"CMPO185_MP-6.ck") => int id6; // adding sweeping string-like sound
16::second => now;



// B-section

Machine.remove(id2);                                // removing fizzy bass loop
Machine.remove(id3);                                // removing A-section percussion 1
Machine.remove(id5);                                // removing vocal-like
Machine.add(me.dir()+"CMPO185_MP-7.ck") => int id7; // adding a new percussion layer, to start a new section 
12::second => now;

Machine.remove(id6);                                // removing sweeping strings for transition back to A-section
Machine.add(me.dir()+"CMPO185_MP-8.ck") => int id8; // adding in extra string layer to start ending the section and transition 
4::second => now;
Machine.remove(id7);                                // removing the B-section percussion 



// A-section 

Machine.add(me.dir()+"CMPO185_MP-2.ck") => int id2b; // bringing back the A section layers, minus 'vocal-like and string-like' layers
Machine.add(me.dir()+"CMPO185_MP-3.ck") => int id3b; 
12::second => now;

Machine.remove(id3b);                                // removing percussion,
Machine.remove(id1);                                 // removing beeping for 2 bars of quiet before bringing vocal-like in again
4::second => now;

Machine.add(me.dir()+"CMPO185_MP-1.ck") => int id1b; // adding percussion 
Machine.add(me.dir()+"CMPO185_MP-3.ck") => int id3c; // adding beeping
Machine.remove(id4);                                 // removing bubble loop 1,
Machine.add(me.dir()+"bubble2.ck") => int id40;      // replacing with bubble loop 2 (heavy)
Machine.add(me.dir()+"CMPO185_MP-5.ck") => int id5b; // adding the voc/string layers back in
Machine.add(me.dir()+"CMPO185_MP-6.ck") => int id6b; // adding sweeping strings
32::second => now;

Machine.remove(id2b);                                // removing fizzy bass,
Machine.remove(id3c);                                // removing percussion 1,
Machine.remove(id5b);                                // removing vocal-like for quiet 2 bars
Machine.add(me.dir()+"62.ck") => int id62;           // adding second sweeping strings layer for harmony
4::second => now;

Machine.add(me.dir()+"CMPO185_MP-7.ck") => int id7b; // adding transition percussion
12::second => now;

Machine.add(me.dir()+"CMPO185_MP-6.ck") => int id6c; // adding sweeping strings 
Machine.add(me.dir()+"CMPO185_MP-8.ck") => int id8c; // adding transition strings
8::second => now;



// C-section 

Machine.remove(id8c);                                // removing the 'B' section percussion 
Machine.remove(id6b);                                // removing sweeping string
Machine.remove(id62);                                // removing sweeping string harmony 
Machine.add(me.dir()+"63.ck") => int id63;           // adding percussive string-like loop
Machine.add(me.dir()+"CMPO185_MP-2.ck") => int id2c; // adding fizzy bass loop
Machine.add(me.dir()+"CMPO185_MP-3.ck") => int id3d; // adding A-section percussion 1
Machine.add(me.dir()+"CMPO185_MP-7.ck") => int id7c; // adding transition percussion
16::second => now;

Machine.add(me.dir()+"perc2.ck") => int perc;        // adding in A-section percussion 2 (heavy)
16::second => now;

Machine.remove(id6c); 
Machine.add(me.dir()+"CMPO185_MP-6.ck") => int id6d; // adding sweeping strings
Machine.add(me.dir()+"62.ck") => int id62b;          // adding sweeping strings harmony
Machine.remove(id2c);                                // removing fizzy bass
Machine.remove(id3d);                                // removing A-section percussion 1 (lite)
16::second => now;

Machine.remove(id63);                                // removing percussive strings
Machine.remove(id1b);                                // removing beeping
24::second => now;

Machine.remove(perc);                                // removing A-section percussion 2 (heavy)
16::second => now;

Machine.remove(id6d);                                // removing sweeping strings
Machine.remove(id62b);                               // removing sweeping strings harmony
16::second => now;
