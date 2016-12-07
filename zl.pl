#!/usr/bin/env perl
use 5.012;
use strict;
use warnings;
use autodie;

use Cwd;
use File::Spec;
use Term::ReadKey;

# clean up on exit
$SIG{INT} = $SIG{TERM} = \&reset_term;
END { reset_term() };

sub reset_term {
    ReadMode 'restore';
    exit;
}

#test_comment

sub is_int {
    my $value = shift // '';
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

    return File::Spec->catdir(File::Spec->rootdir(), @dirs[1..$choice]);
}

sub prompt {
    my @dirs = @{$_[0]};
    my $spacing = " ";

    say STDERR "Which level would you like to go up to?";
    foreach my $i (0..$#dirs) {
        say STDERR $spacing . $i . ": " . $dirs[$i];
        $spacing .= " ";
    }

    my $max_depth = $#dirs;

    my $choice = get_choice($max_depth);

    while (not valid($choice, $max_depth)) {
        say STDERR "The value entered was invalid. Enter a decimal number in the range 0-$max_depth.";
        $choice = get_choice($max_depth);
    }

    return $choice;
}

# allow single-character entry when there are 10 or fewer choices (0-9)
sub get_choice {
    my ($max_choice) = @_;

    my $choice;

    if ($max_choice < 10) {
        ReadMode 'cbreak';
        $choice = ReadKey(0);
        ReadMode 'restore';
    }
    else {
        no warnings 'uninitialized';
        chomp($choice = <>);
    }

    return $choice;
}

sub main {
    my $pwd = cwd();

    my @dirs = File::Spec->splitdir($pwd);

    # Explictly set root level to /
    $dirs[0] = File::Spec->rootdir();

    my $choice = prompt(\@dirs);

    say build_path($choice, \@dirs);
}

main();
