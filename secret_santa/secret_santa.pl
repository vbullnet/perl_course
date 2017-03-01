#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

sub santa {
	my @list = @_;
	my @people;
	my %relations;

	for my $elem (@list) {
		if (ref $elem) {
			if (ref $elem ne 'ARRAY') {
				# print "Not correct argument $elem\n";
				return undef;
			}
			else {
				if (exists $relations{$elem->[1]}) {
					# print "Person $elem->[0] repeating";
					return undef;
				}

				if (exists $relations{$elem->[1]}) {
					# print "Person $elem->[1] repeating";
					return undef;
				}

				push @people, $elem->[0];
				push @people, $elem->[1];
				$relations{$elem->[0]} = $elem->[1];
				$relations{$elem->[1]} = $elem->[0];
			}
		}
		else {
			if (exists $relations{$elem}) {
				# print "Person $elem repeating";
				return undef;
			}
			push @people, $elem;
		}
	}

	if((scalar @people) % 2 != 0) {
		# print "Not even number of people\n";
		return undef;
	}

	my %present;
	my @gifted;

	OUTER:
	while (1)
	{
		for my $from (0 .. $#people) {
			my $to = int rand(scalar @people);
			
			if($to == $from || $gifted[$to]) {
				redo;
				if ($from == $#people) {
					%present = ();
					@gifted = ();
					next OUTER;
				}
			}
	
			elsif ((defined $relations{$people[$from]}) && ($relations{$people[$from]} eq $people[$to])) {
				redo;
				if ($from == $#people) {
					%present = ();
					@gifted = ();
					next OUTER;
				}
			}
	
			elsif ((defined $present{$people[$to]}) && ($present{$people[$to]} eq $people[$from])) {
				redo;
				if ($from == $#people) {
					%present = ();
					@gifted = ();
					next OUTER;
				}
			}
			else {
				$gifted[$to] = 1;
				$present{$people[$from]} = $people[$to];
				next;
			}
		}
		last;
	}
	my @pairs;

	for my $key (keys %present) {
		push @pairs, [$key, $present{$key}];
	}

	return @pairs;
}

my @pairs = santa("y",["x1","x2"],["x3","x4"],"z");
print Dumper \@pairs;