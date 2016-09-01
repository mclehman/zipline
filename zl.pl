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

    # Short-circuiting && prevents calling between on non-numeric input.
    return is_int($value) && between($value, 0, $upper_bound);
}

sub build_path {
    my $choice = shift;
    my @dirs = @{$_[0]};

    my $path = "/";

    for (my $i = 1; $i <= $choice; $i++) {
        $path .= $dirs[$i] . "/";
    }

    return $path;
}

sub prompt {
    my @dirs = @{$_[0]};
    my $index = 0;
    my $spacing = " ";

    say STDERR "Which level would you like to go up to?";
    foreach my $dir (@dirs) {
        say STDERR $spacing . $index . ": " . $dir;
        $spacing .= " ";
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

    return $choice;
}

sub main {
    my $pwd = `pwd -L`;
    chomp $pwd;

    my @dirs = split /\//, $pwd;
    $dirs[0] = "/"; # Explictly set root level to /

    my $choice = prompt(\@dirs);

    say build_path($choice, \@dirs);
}

main();
