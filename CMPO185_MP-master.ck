//Master file for multi-threading, and controlling the different layers of this piece to make sure they come in and out at the desired time:

// A section
Machine.add(me.dir()+"CMPO185_MP-1.ck") => int id1; //shred the first file 
8::second => now; //passing time

Machine.add(me.dir()+"CMPO185_MP-2.ck") => int id2; 
16::second => now;

Machine.add(me.dir()+"CMPO185_MP-3.ck") => int id3; //add percussion 
Machine.add(me.dir()+"CMPO185_MP-4.ck") => int id4; 
16::second => now;

Machine.add(me.dir()+"CMPO185_MP-5.ck") => int id5; //add vocal-like sound
16::second => now;

Machine.add(me.dir()+"CMPO185_MP-6.ck") => int id6; //add string-like sound 
16::second => now;

// B section
Machine.remove(id2); //remove some layers,
Machine.remove(id3);
Machine.remove(id5);
Machine.add(me.dir()+"CMPO185_MP-7.ck") => int id7; //and add a new percussion layer, to start a new section 
12::second => now;


Machine.remove(id6);
Machine.add(me.dir()+"CMPO185_MP-8.ck") => int id8; //add in another layer to start ending the section and transition 
4::second => now;
Machine.remove(id7); //remove the 'B' section percussion 

// A section 
Machine.add(me.dir()+"CMPO185_MP-2.ck") => int id2b; //bring back the A section layers, minus 'vocal-like and string-like' layers
Machine.add(me.dir()+"CMPO185_MP-3.ck") => int id3b;
16::second => now;

Machine.add(me.dir()+"CMPO185_MP-5.ck") => int id5b; //add the voc/string layers back in
Machine.add(me.dir()+"CMPO185_MP-6.ck") => int id6b;
16::second => now;

Machine.remove(id2b); //begin removing layers to 'wind-down' the piece
Machine.remove(id3b);
Machine.remove(id5b);
8::second => now;

Machine.remove(id1);
8::second => now;

Machine.remove(id4);
Machine.remove(id6b);
