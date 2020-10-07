use strict;
use warnings;
use Getopt::Long;
use BinaryClock::Clock;
use BinaryClock::Printer;

my $withSecond;

GetOptions( 'second' => \$withSecond, );

if ( not defined $withSecond ) {
    $withSecond = 0;
}

while (1) {
    my $printer = new Printer();
    my $clock   = new Clock();
    my @arr     = $clock->getBinaryClockAsArray();

    $printer->clear()->printClock( \@arr, $withSecond );

    if ($withSecond) {
        sleep 1;
    } else {
        sleep 60;
    }
}

