#!/usr/bin/perl

use warnings;
use strict;
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

	for (@words) {
		$_ = decode('utf-8',$_);
	}

	my %anagram;

	for my $i (0..$#words) {
		next if !defined $words[$i];
		my @set;

		for my $j ($i + 1..$#words) {
			if (one_set($words[$i], $words[$j])) {
				push @set, encode('utf-8',lc($words[$j]));
				$words[$j] = undef;
			}
		}

		push @set, encode('utf-8',lc($words[$i]));

		if (scalar @set > 1) {
			$anagram{encode('utf-8',lc($words[$i]))} =  [sort{$a cmp $b} @set];
		} 
	}
	return %anagram;
}



my $arr = ["листок", "слиток", "столик", "лампа", "мапла"];
print Dumper \{anagrams $arr};
