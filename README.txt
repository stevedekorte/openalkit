
About
=====
An Objective-C binding to OpenAL. 


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


Notes
=====

Threw this together for a small iPhone game I was working on. 
It seems to work, but is pretty basic. Patches appreciated.

- Steve Dekorte
steve@dekorte.com
