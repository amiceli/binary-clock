use strict;
use warnings;
use Getopt::Long;
use BinaryClock::Clock;
use BinaryClock::Printer;

my $withSecond;
my $color;
my $rainbow;

GetOptions( 
    'second' => \$withSecond, 
    'color=s' => \$color,
    'rainbow' => \$rainbow
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

my @colors = Printer::allowedColors
my $currentColor = 0;

while (1) {

    if ($currentColor == scalar @colors - 1) {
        $currentColor = 0;
    }

    if ($rainbow) {
        $color = $colors[$currentColor];
        $color = "$color on_$color";
    }

    my $printer = new Printer($color);
    my $clock   = new Clock();
    my @arr     = $clock->getBinaryClockAsArray();

    $printer->clear()->printClock( \@arr, $withSecond );

    if ($withSecond) {
        sleep 1;
    } else {
        sleep 60;
    }

    $currentColor++;

}

