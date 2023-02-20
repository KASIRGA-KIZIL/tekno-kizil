#!/usr/bin/env perl
use v5.10.0;
use warnings;
srand($ARGV[1]);
my @illegal_instr_list = ();
foreach my $count (0 .. 100) {
    my $d = int(rand(4294967295));
    my $bin = sprintf("%b", $d); # Convert the integer to binary
    my $hex = sprintf('%X', oct("0b$bin")); # convert binary to hex

    if ($bin !~ m/11$/) # Check if compressed
    {
      if (length($hex) > 4)
      {
        $hex = substr($hex, -4);
      }
    }

    my $illegal = `echo "DASM(0x$hex)" | spike-dasm`;
    #print($illegal);
    if ($illegal =~ /unknown/ && $illegal !~ /counter/  && $illegal !~ /csr/ && $illegal !~ /custom/ && $illegal !~/ / && $illegal !~ /	/) {
      #print($illegal);
      if ($bin =~ m/11$/) {
        push @illegal_instr_list, ".word 0x$hex";
        push @illegal_instr_list, "
";
      }
      else {
        push @illegal_instr_list, ".half 0x$hex";
        push @illegal_instr_list, "
";
      }
      
    }
  }
my $filename = $ARGV[0];
open(FH, '>', $filename) or die $!;
print FH @illegal_instr_list;
close(FH);