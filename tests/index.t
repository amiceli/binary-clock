use diagnostics;
use warnings;
use strict;
use Test::MockTime qw( :all );
use Test::More qw( no_plan );
use BinaryClock::Clock;

set_absolute_time('1970-01-01T18:21:37Z');

my $clock = new Clock();

is( $clock->{leftHour},    '' );
is( $clock->{rightHour},   '' );
is( $clock->{leftMinute},  '' );
is( $clock->{rightMinute}, '' );
is( $clock->{leftSecond},  '' );
is( $clock->{rightSecond}, '' );

my ( $hours, $minutes, $seconds ) = $clock->loadTime();

is( $hours,   19 );
is( $minutes, 21 );
is( $seconds, 37 );

is( $clock->atIndex( '101', 1 ), "0" );

is( $clock->parseTime(13), "13" );
is( $clock->parseTime(3),  "03" );

is( $clock->to4Bin('11'), '0011' );

my ( $left, $right ) = $clock->timeToBinary(38);

is( $left,  '0011' );
is( $right, '1000' );

$clock->initialize();

is( $clock->{leftHour},    '1000' );
is( $clock->{rightHour},   '1001' );
is( $clock->{leftMinute},  '0100' );
is( $clock->{rightMinute}, '1000' );
is( $clock->{leftSecond},  '1100' );
is( $clock->{rightSecond}, '1110' );

my @arr = $clock->getBinaryClockAsArray();

is($arr[0][0], "0");
is($arr[1][0], "0");
is($arr[2][0], "0");
is($arr[3][0], "1");

is($arr[0][1], "1");
is($arr[1][1], "0");
is($arr[2][1], "0");
is($arr[3][1], "1");

is($arr[0][2], "0");
is($arr[1][2], "0");
is($arr[2][2], "1");
is($arr[3][2], "0");

is($arr[0][3], "0");
is($arr[1][3], "0");
is($arr[2][3], "0");
is($arr[3][3], "1");

is($arr[0][4], "0");
is($arr[1][4], "0");
is($arr[2][4], "1");
is($arr[3][4], "1");

is($arr[0][5], "0");
is($arr[1][5], "1");
is($arr[2][5], "1");
is($arr[3][5], "1");