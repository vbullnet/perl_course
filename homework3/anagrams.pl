#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use Data::Dumper;

sub anagrams {
	sub one_set ($$) {
		my ($first, $second) = @_;

		return "" if length($first) != length($second);

		my @firstLetters = sort {lc($a) cmp lc($b)} split //, $first;
		my @secondLetters = sort {lc($a) cmp lc($b)} split //, $second;

		return (join "", @firstLetters) eq (join "", @secondLetters);
	}

	my @words = @_;
	my %anagram;

	for my $i (0..$#words) {
		next if !defined $words[$i];
		my @set;

		for my $j ($i + 1..$#words) {
			if (one_set($words[$i], $words[$j])) {
				push @set, lc($words[$j]);
				$words[$j] = undef;
			}
		}

		push @set, lc($words[$i]);

		if (scalar @set > 1) {
			$anagram{lc($words[$i])} =  [sort{$a cmp $b} @set];
		} 
	}
	return %anagram;
}



print Dumper \{anagrams("листок", "слиток", "столик", "лампа", "мапла")};
