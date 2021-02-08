Created by Dominik Bachmaier, 17.04.2016

The evaluation software (Auswertesoftware-LSL) is copied and adapted from software created by G. Bauernfeind.
Main difference is the possibility to load xdf files instead of gdf files. Only parts in respect to that difference
changed within the original version of the software.

Function:
It is possible to determine the folder location of stored xdf and NIRS files, start (before trigger) and stop 
(after trigger) time defining a task to calculate mean over several tasks, the different conditions (triggers), the 
amount of triggers and location to store the result.

It is also possible to send triggers directly to NIRStar or NIRScout device or to send them also as a lsl stream with the 
name "paradigm".

This version is only able to distinguish between three conditions with trigger value 2, 3, 4. Trigger 1 is reserved 
to start and stop condition of one run. It is also only allowed to record one run within each xdf.

If an increased functionality regarding more conditions ore recording more runs within one xdf is required it could 
be adapted with small effort within the files "Main_NIRx.m", "load_NIRx_XDF.m" and others regarding to them. While
this first version was created there was no need to.
