package Printer;

use strict;
use warnings;
use Term::ANSIColor;
use Term::ReadKey;
use Data::Dumper;

sub new {
    my $class = shift;

    my $self = {};

    bless $self, $class;

    return $self;
}

sub printSquare {
    my $self = shift;

    print color('black on_black');
    print "██";
    print color('reset');
    print " ";
}

sub printActiveSquare {
    my $self = shift;

    print color('red on_red');
    print "██";
    print color('reset');
    print " ";
}

sub clear {
    my $self = shift;

    print "\033[2J";
    print "\033[0;0H";

    return $self;
}

sub getPadLeft {
    my $self = shift;
    my ( $wchar, $hchar, $wpixels, $hpixels ) = GetTerminalSize();

    my $diff = ( $wchar - 17 ) / 2;
    my $pad  = "";

    for ( my $k = 0 ; $k < $diff ; $k++ ) {
        $pad = $pad . " ";
    }

    return $pad;
}

sub getPadTop {
    my ( $wchar, $hchar, $wpixels, $hpixels ) = GetTerminalSize();

    my $diff = ( $hchar - 6 ) / 2;
    my $pad  = "";

    for ( my $k = 0 ; $k < $diff ; $k++ ) {
        $pad = $pad . " ";
    }

    return $pad;
}

sub printClock {
    my $self        = shift;
    my @binaryClock = @{ $_[0] };
    my $withSecond  = $_[1];

    my $padLeft = $self->getPadLeft();
    my $padTop  = $self->getPadTop();

    my $line;

    print $padTop, "\n";

    for ( my $index = 0 ; $index < 4 ; $index++ ) {
        my $pow = 2**( 3 - $index );

        print $padLeft;
        my $count = $withSecond ? 6 : 4;

        for ( my $sub = 0 ; $sub < $count ; $sub++ ) {
            if ( $binaryClock[$index][$sub] == '1' ) {
                $self->printActiveSquare();
            } else {
                $self->printSquare();
            }
        }

        print "\n\n";
    }
}

1;
