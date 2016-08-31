#!/usr/bin/env perl
use 5.012;
use strict;
use warnings;
use autodie;

sub is_int {
    my $value = shift;
    return ($value =~ m/^\d+$/);
}

sub between {
    my ($value, $lower, $upper) = @_;

    return ($lower <= $value and $value <= $upper);
}

sub valid {
    my $value = shift;
    my $upper_bound = shift;

    return is_int($value) && between($value, 0, $upper_bound);
}

sub main {
    my $pwd = `pwd -L`;
    chomp $pwd;
    my @levels = split /\//, $pwd;
    $levels[0] = "/"; # Explictly set root level to /
    my $index = 0;
    my $spacing = " ";

    say STDERR "Which level would you like to go up to?";
    foreach my $level (@levels) {
        say STDERR $spacing . $index . ": " . $level;
        $spacing = $spacing . " ";
        $index++;
    }

    my $max_depth = $index - 1;

    my $choice = <>;
    chomp $choice;

    while (not valid($choice, $max_depth)) {
        say STDERR "The value entered was invalid. Enter a decimal number in the range 0-$max_depth.";
        $choice = <>;
        chomp $choice;
    }

    my $command = "/";

    for (my $i = 1; $i <= $choice; $i++) {
        $command = $command . $levels[$i] . "/";
    }

    say $command;
}

main();
