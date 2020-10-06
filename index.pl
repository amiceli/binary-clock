use strict;
use warnings;
use Term::ANSIColor;
use Term::ReadKey;
use Getopt::Long;

sub timeToBinary {
    my $time     = shift;
    my @char     = split( //, $time );
    my $leftBin  = sprintf( "%b", $char[0] );
    my $rightBin = sprintf( "%b", $char[1] );

    return ( to4Bin($leftBin), to4Bin($rightBin) );
}

sub to4Bin {
    my $value = shift;

    if ( length $value == 4 ) {
        return $value;
    }
    else {
        my $len = 4 - length $value;
        for ( my $i = 0 ; $i < $len ; $i++ ) {
            $value = '0' . $value;
        }
    }

    return $value;
}

sub parseTime {
    my $time = shift;

    if ( $time < 10 ) {
        return '0' . $time;
    }

    return $time;
}

sub loadTime {
    my ( $seconds, $minutes, $hours ) = localtime();

    $seconds = parseTime($seconds);
    $minutes = parseTime($minutes);
    $hours   = parseTime($hours);

    return ( $hours, $minutes, $seconds );
}

sub atIndex {
    my $str   = shift;
    my $index = shift;

    my @split = split //, $str;

    return $split[$index];
}

sub printSquare {
    print color('black on_black');
    print "██";
    print color('reset');
    print " ";
}

sub printActiveSquare {
    print color('red on_red');
    print "██";
    print color('reset');
    print " ";
}

sub clear {
    my ($self) = @_;

    print "\033[2J";
    print "\033[0;0H";

    return $self;
}

sub getPadLeft {
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

my $withSecond;

GetOptions( 'second' => \$withSecond, );

if ( not defined $withSecond ) {
    $withSecond = 0;
}

while (1) {
    clear();

    my ( $hours, $minutes, $seconds ) = loadTime();

    my ( $leftHour,   $rightHour )   = timeToBinary($hours);
    my ( $leftMinute, $rightMinute ) = timeToBinary($minutes);
    my ( $leftSecond, $rightSecond ) = timeToBinary($seconds);

    my $padLeft = getPadLeft();
    my $padTop  = getPadTop();

    $leftHour    = reverse $leftHour;
    $rightHour   = reverse $rightHour;
    $leftMinute  = reverse $leftMinute;
    $rightMinute = reverse $rightMinute;
    $leftSecond  = reverse $leftSecond;
    $rightSecond = reverse $rightSecond;

    my @arr = (
        [
            atIndex( $leftHour,    3 ),
            atIndex( $rightHour,   3 ),
            atIndex( $leftMinute,  3 ),
            atIndex( $rightMinute, 3 ),
            atIndex( $leftSecond,  3 ),
            atIndex( $rightSecond, 3 ),
        ],
        [
            atIndex( $leftHour,    2 ),
            atIndex( $rightHour,   2 ),
            atIndex( $leftMinute,  2 ),
            atIndex( $rightMinute, 2 ),
            atIndex( $leftSecond,  2 ),
            atIndex( $rightSecond, 2 ),
        ],
        [
            atIndex( $leftHour,    1 ),
            atIndex( $rightHour,   1 ),
            atIndex( $leftMinute,  1 ),
            atIndex( $rightMinute, 1 ),
            atIndex( $leftSecond,  1 ),
            atIndex( $rightSecond, 1 ),
        ],
        [
            atIndex( $leftHour,    0 ),
            atIndex( $rightHour,   0 ),
            atIndex( $leftMinute,  0 ),
            atIndex( $rightMinute, 0 ),
            atIndex( $leftSecond,  0 ),
            atIndex( $rightSecond, 0 ),
        ]
    );

    my $line;

    print $padTop, "\n";

    for ( my $index = 0 ; $index < 4 ; $index++ ) {
        my $pow = 2**( 3 - $index );

        print $padLeft;
        my $count = $withSecond ? 6 : 4;

        for ( my $sub = 0 ; $sub < $count ; $sub++ ) {
            if ( $arr[$index][$sub] == '1' ) {
                printActiveSquare();
            }
            else {
                printSquare();
            }
        }

        print "\n";
        print "\n";

    }

    if ($withSecond) {
        sleep 1;
    } else {
        sleep 60;
    }
    
}

