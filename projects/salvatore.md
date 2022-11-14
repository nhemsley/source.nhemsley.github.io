---
layout: layout
title: Salvatore Fluid Simulation
---

# Numerical Fluid Simulation of Breaking waves over contoured sea floor

This was my first foray into the Rust programming language, prompted primarily by the availability of the [Salva crate](https://github.com/dimforge/salva), released by [Dimforge](https://dimforge.com).

Any public code related to this was contributed under the github user [rezural](https://github.com/rezural)

## Core simulation

Salvatore modeled the environment that the fluid existed in as a large pool, with the bathymetry provided to salva as a triangle mesh. This mesh was initially generated from a grayscale heightmap png/jpg.

Salva models the boundaries of the environment as static particles, with movement disabled. Boundaries, and water particles are modeled using particles, with salva providing methods to generate the boundary particles, from shape objects.

## Challenges 

This project presented various challenges, largely due to the volume of data produced per-frame, and the inability of visualization tools to deal with such large data sets. The volume of data per frame, simply overwhelms the throughput capabilities of current hardware.

## Output format

The output from the simulation is the spatial position of each particle, for each time step, with each time step being stored in a simple .ply file. This resulted in a 600mb file for each time step, of a realistic simulation world.

While Paraviz was able to deal with this amount of data, it was not real-time in any sense.

## Conversion to Triangle Mesh

[Splashsurf](https://www.floeschner.de/splashsurf/) ([github](https://github.com/w1th0utnam3/splashsurf)) is utilized to convert the .ply files, to .stl mesh files. These files were still on the order of 150mb per frame. Post processing, using meshlab's mesh decimation functionality, reduced the file sizes further, to around 30mb.


## Visualization of results

I decided to create a [mesh visualization software](https://github.com/rezural/mesh-ripper), that given a directory, would animate through a directory of numbered .stl files. This was written using the excellent, and very performant [Bevy](https://bevyengine.org/) game engine.

This was my first foray into using the bevy game engine, and the architecture shows. The program however, performs quite well.

# Visualization Videos


## Scar Reef

I created two bathymetries, one modeled on a surfing reef named [Scar Reef](https://goo.gl/maps/LkrFv69goCMKMxN39), in Sumbawa.

This is a video of the wave simulated for about 15 seconds real time, from various aerial perspectives:

<iframe
    width="640"
    height="480"
    src="https://www.youtube.com/embed/1qv63IPZ1tM"
    frameborder="0"
    allow="autoplay; encrypted-media"
    allowfullscreen
>
</iframe>


## Hollow Left hander

The second bathymetry I created, was intended to create a steeper reef edge, and consequently a steeper wave breaking style. In surfing terminology, a hollower wave.

Video of external view of the wave breaking:

<iframe
    width="640"
    height="480"
    src="https://www.youtube.com/embed/orD-Gmtphlo"
    frameborder="0"
    allow="autoplay; encrypted-media"
    allowfullscreen
>
</iframe>

Inside view, from within the breaking wave, the 'tube':


<iframe
    width="640"
    height="480"
    src="https://www.youtube.com/embed/iOcfvxlKDXg"
    frameborder="0"
    allow="autoplay; encrypted-media"
    allowfullscreen
>
</iframe>
