# Binary clock

![binary-clock](https://i.postimg.cc/FRSRjK87/Capture-d-e-cran-2020-10-06-a-23-51-01.png)

## Install tools

First you need to install [carton](https://metacpan.org/pod/Carton) : 

    cpanm Carton

After your to install [pp](https://metacpan.org/pod/pp) : 

    cpan install PAR::Packer

## Development

Install dependencies : 

    carton install

To run project : 

~~~bash
carton exec -- perl index.pl --s 
~~~

`--s` option set seconds mode, by default clock is updated every minute.
`--c` option set square color.
`--r`option set rainbow mode, color will change each second/minute.

**Allowed colors are red, green, yellow, blue, magenta, cyan, white. Default color is red.**


## Build

To build project : 

    sh scripts/build.sh

To run binary file : 

    chmod 777 binary-clock

Example : 

~~~bash
./binary-clock --s --color cyan
~~~