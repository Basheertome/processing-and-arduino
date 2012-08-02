Processing & Arduino Code
=========================

Here's a mishmash of some code snippets/programs I've written over the past years for various projects.

Breathing
---------

### Breathing.pde

The rather simple arduino sketch written to pulse the ambient led in this project: [http://madeby.basheertome.com/breathe](http://madeby.basheertome.com/breathe).

Chroma
------

### Chroma.pde

A more complex arduino sketch written to control this project: [http://madeby.basheertome.com/chroma](http://madeby.basheertome.com/chroma). The code does the following:
* Reads gray code from a rotary encoder
* listens to input from a push button
* Counts and calculates time
* Multiplexes two seven-segment displays

### Circuit v1.brd & Circuit v2.brd

The raw Eagle board files for the circuit board heart inside of [Chroma](http://madeby.basheertome.com/chroma).

Madeline
------

### Madeline.pde

A simple arduino sketch written to fade the leds in this project: [http://madeby.basheertome.com/madeline](http://madeby.basheertome.com/madeline). The end effect is a slow rolling fade in and out across the front of the device.

### Madeline.brd

The raw Eagle board files for the circuit board inside of [Madeline](http://madeby.basheertome.com/madeline) which makes the front cover pulse.

Nodes
------

### Nodes

Simple processing sketch that integrates the triangulate library in order to draw and save a nodes graphic.

### Nodes_Retina

A 2x version of the nodes sketch.