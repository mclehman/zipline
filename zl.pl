#!/usr/bin/env perl
use Modern::Perl 2014;
use autodie;

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

    my $choice = <>;
    chomp $choice;

    my $command = "/";

    for (my $i = 1; $i <= $choice; $i++) {
        $command = $command . $levels[$i] . "/";
    }

    say $command;
}

main();
