use strict;
use warnings;
use Getopt::Long;
use BinaryClock::Clock;
use BinaryClock::Printer;

my $withSecond;
my $color;

GetOptions( 
    'second' => \$withSecond, 
    'color=s' => \$color
);

if (!grep /$color/, Printer::allowedColors) {
    die "Allowed colors are " . join (', ', Printer::allowedColors) . "\n";
}

if ( not defined $withSecond ) {
    $withSecond = 0;
}

if (not defined $color) {
    $color = "red on_red";
} else {
    $color = "$color on_$color";
}

while (1) {
    my $printer = new Printer($color);
    my $clock   = new Clock();
    my @arr     = $clock->getBinaryClockAsArray();

    $printer->clear()->printClock( \@arr, $withSecond );

    if ($withSecond) {
        sleep 1;
    } else {
        sleep 60;
    }
}

