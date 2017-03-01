#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

sub make_pairs {
	my @list = @_;
	my @people;
	my %relations;

	for (@list) {
		if (ref $_) {
			if (ref $_ ne 'ARRAY') {
				print "Not correct argument $_\n";
				return undef;
			}
			else {
				if (exists $relations{$_->[1]}) {
					print "Person $_->[0] repeating";
					return undef;
				}

				if (exists $relations{$_->[1]}) {
					print "Person $_->[1] repeating";
					return undef;
				}

				push @people, $_->[0];
				push @people, $_->[1];
				$relations{$_->[0]} = $->[1];
				$relations{$_->[1]} = $->[0];
			}
		}
		else {
			if (exists $relations{$_}) {
				print "Person $_ repeating";
				return undef;
			}
			push @people, $_;
			$relations{$_} = undef;
		}
	}
	
	if((scalar @people) % 2 != 0) {
		print "Not even number of people\n";
		return undef;
	}

	my %present;
	for my $from (0 .. $#people) {
		my $to = int rand(scalar @people);

		if ($to == $from || $relations{$people[$from]} eq $people[$to]{
			redo;
		}
		elsif (not defined $relations{$people[$from]}){
			$present{$people[$from]} = $people[$to];
			next;
		}
		elsif ($present{$people[$to]} eq $people[$from])() {
			redo;
		}
		
		$present{$people[$from]} = $people[$to];
	}

	my @pairs;

	for my $key (keys %present) {
		push @pairs, [$key, $present{$key}];
	}

	return @pairs;
}

my @pairs = make_pairs("y",["x1","x2"],["x3","x4"],"z");
print Dumper \@pairs;