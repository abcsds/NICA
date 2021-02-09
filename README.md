# Near Infrared spectroscopy Calculations and Analysis (NICA)

A MATLAB-based Graphical  User  Interface  (GUI)  to analysefunctional  Near-Infrared  Spectroscopy  (fNIRS) measurement data recorded with the NIRScoutdevice. Further user documentation can be found under the `doc` folder.

## Installation

To install NICA you have to run the file `installNica.m`, which can be found in the main folder. The  installation  creates  the  folder  structure  for  all  the  necessary  functions  and  files  for  the GUI.  After  a  successful  installation  the  command  window  displays  the  message `Installation successful!`. Afterwards NICA can  be  started  at  any  time  (also  after restarting Matlab)  from  the  command window by simply typing the command `nica`.

## Usage Notes

NICA is freely available and can be edited and extended if necessary.


## TODO

Installing NICA on MATLAB R2017b produces the following warnings:

```
Creating folder structure...
Warning: Name is nonexistent or not a directory: /home/beto/code/NICA/Analysis_Software_fNIRS_LSL/EEGLab
> In path (line 109)
  In installNica (line 47)
Warning: Name is nonexistent or not a directory: /home/beto/code/NICA/Analysis_Software_fNIRS_LSL/EEGLab/EEG_old
> In path (line 109)
  In installNica (line 48)
Warning: Name is nonexistent or not a directory:
/home/beto/code/NICA/Analysis_Software_fNIRS_LSL/EEGLab/EEG_old/eeglab2008October01_beta
> In path (line 109)
  In installNica (line 49)
Warning: Name is nonexistent or not a directory:
/home/beto/code/NICA/Analysis_Software_fNIRS_LSL/EEGLab/EEG_old/eeglab2008October01_beta/functions
> In path (line 109)
  In installNica (line 51)
Warning: Name is nonexistent or not a directory:
/home/beto/code/NICA/Analysis_Software_fNIRS_LSL/EEGLab/EEG_old/eeglab2008October01_beta/functions/adminfunc
> In path (line 109)
  In installNica (line 53)
Warning: Name is nonexistent or not a directory:
/home/beto/code/NICA/Analysis_Software_fNIRS_LSL/EEGLab/EEG_old/eeglab2008October01_beta/functions/miscfunc
> In path (line 109)
  In installNica (line 55)
Warning: Name is nonexistent or not a directory:
/home/beto/code/NICA/Analysis_Software_fNIRS_LSL/EEGLab/EEG_old/eeglab2008October01_beta/functions/popfunc
> In path (line 109)
  In installNica (line 57)
Warning: Name is nonexistent or not a directory:
/home/beto/code/NICA/Analysis_Software_fNIRS_LSL/EEGLab/EEG_old/eeglab2008October01_beta/functions/resources
> In path (line 109)
  In installNica (line 59)
Warning: Name is nonexistent or not a directory:
/home/beto/code/NICA/Analysis_Software_fNIRS_LSL/EEGLab/EEG_old/eeglab2008October01_beta/functions/sigprocfunc
> In path (line 109)
  In installNica (line 61)
Warning: Name is nonexistent or not a directory:
/home/beto/code/NICA/Analysis_Software_fNIRS_LSL/EEGLab/EEG_old/eeglab2008October01_beta/functions/studyfunc
> In path (line 109)
  In installNica (line 63)
Warning: Name is nonexistent or not a directory:
/home/beto/code/NICA/Analysis_Software_fNIRS_LSL/EEGLab/EEG_old/eeglab2008October01_beta/functions/timefreqfunc
> In path (line 109)
  In installNica (line 65)
```
