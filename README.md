
About
=====
An Objective-C binding to OpenAL.


Dependencies
============

* CoreAudio
* AudioToolbox
* AVFoundation(iPhone)
* OpenAL


Sample Code
===========

	self.context = [ALContext context]; 
	source = [ALSource sourceWithPath:pathToSoundFile]; // wav, caf, etc
	[source play];


Buffer Caches
=============

ALSource sourceWithPath: caches and reuses the ALBuffer it creates for a file. 
So a given sound file will only be loaded and decoded once per program run.


Notes
=====

Threw this together for a small iPhone game I was working on. 
It seems to work, but is pretty basic. Patches appreciated.

 - Steve Dekorte
steve@dekorte.com

Some style & minor fixes by Jeremy Knope <jerome@buttered-cat.com>
