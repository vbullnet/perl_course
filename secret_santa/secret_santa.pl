#!/usr/bin/perl

use strict;
use warnings;

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
			push @people, $_
			$relations{$_} = undef;
		}
	}
	if(scalar @people % 2 != 0) {
		print "Not even number of people\n"
		return undef;
	}

	my @pairs;

	my $condition = sub {
		for my $index (0 .. $#people - 1) {
			if ($relations{$people[$index]} = $people[$index + 1]) {
				return false;
			} 
		}
		return true;
	};

	@people = sort {int rand(3) - 1} @people while ($condition->());

	my @return;
	for (0 .. $#people / 2) {
		$return[$_] = [$people[2 * $_], $people[2 * $_ + 1]];
	}	
	return @return;
}