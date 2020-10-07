package Clock;

use strict;
use warnings;

sub new {
    my $class = shift;

    my $self = {
        leftHour    => '',
        rightHour   => '',
        leftMinute  => '',
        rightMinute => '',
        leftSecond  => '',
        rightSecond => ''
    };

    bless $self, $class;

    return $self;
}

sub atIndex {
    my $self  = shift;
    my $str   = shift;
    my $index = shift;

    my @split = split //, $str;

    return $split[$index];
}

sub parseTime {
    my $self = shift;
    my $time = shift;

    if ( $time < 10 ) {
        return '0' . $time;
    }

    return $time;
}

sub loadTime {
    my $self = shift;
    my ( $seconds, $minutes, $hours ) = localtime();

    $seconds = $self->parseTime($seconds);
    $minutes = $self->parseTime($minutes);
    $hours   = $self->parseTime($hours);

    return ( $hours, $minutes, $seconds );
}

sub initialize {
    my $self = shift;
    my ( $hours, $minutes, $seconds ) = $self->loadTime();

    my ( $leftHour,   $rightHour )   = $self->timeToBinary($hours);
    my ( $leftMinute, $rightMinute ) = $self->timeToBinary($minutes);
    my ( $leftSecond, $rightSecond ) = $self->timeToBinary($seconds);

    $self->{leftHour}    = reverse $leftHour;
    $self->{rightHour}   = reverse $rightHour;
    $self->{leftMinute}  = reverse $leftMinute;
    $self->{rightMinute} = reverse $rightMinute;
    $self->{leftSecond}  = reverse $leftSecond;
    $self->{rightSecond} = reverse $rightSecond;
}

sub to4Bin {
    my $self  = shift;
    my $value = shift;

    if ( length $value == 4 ) {
        return $value;
    } else {
        my $len = 4 - length $value;
        for ( my $i = 0 ; $i < $len ; $i++ ) {
            $value = '0' . $value;
        }
    }

    return $value;
}

sub timeToBinary {
    my $self     = shift;
    my $time     = shift;
    my @char     = split( //, $time );
    my $leftBin  = sprintf( "%b", $char[0] );
    my $rightBin = sprintf( "%b", $char[1] );

    return ( $self->to4Bin($leftBin), $self->to4Bin($rightBin) );
}

sub getBinaryClockAsArray {
    my $self = shift;

    $self->initialize();

    my @binaryClock = ();

    for ( my $i = 3 ; $i >= 0 ; $i-- ) {
        my @part = (
            $self->atIndex( $self->{leftHour},    $i ),
            $self->atIndex( $self->{rightHour},   $i ),
            $self->atIndex( $self->{leftMinute},  $i ),
            $self->atIndex( $self->{rightMinute}, $i ),
            $self->atIndex( $self->{leftSecond},  $i ),
            $self->atIndex( $self->{rightSecond}, $i ),
        );

        push @binaryClock, \@part;
    }

    return @binaryClock;
}

1;
