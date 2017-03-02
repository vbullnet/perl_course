#!/usr/bin/perl

use warnings;
use strict;
use utf8;
use Encode;
use Data::Dumper;

sub anagrams ($) {
	sub one_set ($$) {
		my ($first, $second) = @_;

		return "" if length($first) != length($second);

		my @firstLetters = sort {lc($a) cmp lc($b)} split //, $first;
		my @secondLetters = sort {lc($a) cmp lc($b)} split //, $second;

		return (join "", @firstLetters) eq (join "", @secondLetters);
	}

	my ($arrref) = @_;
	my @words = @{$arrref};

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



my $arr = ["листок", "слиток", "столик", "лампа", "мапла"];
@{$arr} = map {encode('utf-8',$_)} @{$arr};
print Dumper \{anagrams $arr};
