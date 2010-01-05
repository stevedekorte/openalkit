
About
=====
An BSD licensed Objective-C binding to OpenAL. 


Dependencies
============

  CoreAudio
  AudioToolbox
  AVFoundation
  OpenAL


Sample Code
===========

  self.context = [ALContext defaultContext]; 
  source = [ALSource newWithPath:pathToSoundFile]; // wav, caf, etc
  [source play];


Buffer Caches
=============

ALSource newWithPath: caches and reuses the ALBuffer it creates for a file. 
So a given sound file will only be loaded and decoded once per program run.


Notes
=====

Threw this together for a small iPhone game I was working on. 
It's pretty basic but seems to work well. Patches appreciated.

- Steve Dekorte
steve@dekorte.com
