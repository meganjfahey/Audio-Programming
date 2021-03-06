# Audio programming project

## Motivation and goals for project 
Musical composition. Most complete version is Digital Music composition structure, not in a song composition structure, but there are a few versions of this piece. The piece started off as a song idea composed in Ableton Live, then was modified to fit into a digital music project for an audio programming course using ChucK.

In parallel to the programmed piece, I have been developing an acoustic version in the format of an ABAB song format. This acoustic version uses vocals and piano. Work on the piano accompaniment to the song has also been carried out through notation in MuseScore. 

The goal for this musical project is to integrate the song into the programmed piece structure, so that it can exist as a combined version. If I find some sounds in this process I would like to see taken further, I will branch out and use some more advanced languages/DAWs/audio-modification softwares, and add in live recordings. 

I would also like to keep the original acoustic and programmed versions as well, but develop both of them into more interesting pieces, as both myself and others who have listened agree that they both currently lack some interest which could be solved by some modification.

## Current usability notes/complications for the audio program

Currently the audio program takes its drum kit samples from a local samples folder that cannot be uploaded. I am therefore working towards transferring to accessable samples which can be included in this repo. 

I use miniAudical as an IDE for ChucK, so that has to be installed and set-up for modification of this program. This is prone to crashing and getting overloaded.

To play the piece in ChucK, all ChucK files and necessary samples must be in the same folder and the virtual machine must be running. The piece is 'controlled' by the master file - clicking 'add shred' (shred is ChucK's name for program thread) will start the piece. The Master file is for multi-threading, and controlling the different layers of this piece to make sure they come in and out at the desired time.

If more than one shred is running, the sounds will play over one another. If it is a complicated piece, the virtual machine can crash with mutliple shreds running at the same time. 

