# Data set | Evaluation of Lake Sediment Thickness from Water-Borne Electrical Resistivity Tomography Data
This repository contains raw and processed data along with the Matlab scripts used to prepare the data in the manuscript.

# Summary
Lakes are integrators of past climate and ecological change. This information is stored in the sediment record at the lake bottom, and to make it available for paleoclimate research, potential target sites with undisturbed and continuous sediment sequences need to be identified. Different geophysical methods are suitable to identify, explore and characterize sediment layers prior to sediment core recovery. Due to the high resolution reflection seismic methods have become standard for this purpose.  However, seismic measurements cannot always provide a comprehensive image of lake-bottom sediments, e.g. due to lacking seismic contrasts between geological units or high attenuation of seismic waves. Here, we develop and test a complementary method based on water-borne electrical resistivity tomography (ERT) measurements. Our setup consists of 13 floating electrodes (at 5-m spacing) used to collect ERT data with a dipole-dipole configuration. We use a 1D inversion to adjust a layered-earth model, which facilitates the implementation of constraints on water depth, water resistivity, and sediment resistivity as a-priori information. The first two parameters are readily obtained from echo sounder and conductivity probe measurements. The resistivity of sediment samples can also be determined in the laboratory. We apply this approach to process ERT data collected on a lake in southern Mexico. The direct comparison of ERT data with reflection seismic data collected with a sub-bottom profiler (SBP) shows that we can significantly improve the sediment-thickness estimates compared to unconstrained 2D inversions. Down to water depths of ~20 m, our sediment thickness estimates are close to the sediment thickness derived from collocated SBP seismograms. Our approach represents an implementation of ERT measurements on lakes and  complements the standard lake-bottom exploration by reflection seismic methods.

# Overview

| Directory | Method |Month/Year of acquisition|Quantity|
| ------------- | ------------- |--|--|
| ERT  | Electrical resistivity tomography |10/2018| 12 profiles |
| SBP  | Sub-bottom profiler  |10/2018|18 profiles|
