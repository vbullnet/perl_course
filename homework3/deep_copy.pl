#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;

sub deep_copy ($);

sub deep_copy ($) {
	my ($struct) = @_;
	unless (ref $struct) {
		return $struct;
	}
	else {
		if (ref $struct eq 'ARRAY') {
			my @arr;
			for (@{$struct}) {
				push @arr, deep_copy($_);
			}
			return \@arr;
		}
		elsif (ref $struct eq 'HASH') {
			my %hash;
			
			while (my ($k, $v) = each %{$struct}) {
				$hash {deep_copy($k)} = deep_copy($v);
			}

			return \%hash;
		}
		elsif (ref $struct eq 'SCALAR') {
			my $scalar = ${$struct};
			return \$scalar;
		}
		else {
			return undef;
		}
	}
}

my $var = 7;
my $hash = {
	s => "string",
	a => [ qw(some elements) ],
	h => {
		nested => "value",
		"key\0" => [ 1,2,$var ],
	},
	f => undef
};

print Dumper deep_copy($hash);