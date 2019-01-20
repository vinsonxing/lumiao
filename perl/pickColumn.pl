use strict;
use warnings;
use 5.010;

my @VALID_COL_IDX = (0, 4, 5, 6, 7);

sub main
{
  my $filename = 'seed.txt'; # input file path
  my $outputf = 'output.txt'; # output file path
  pickColumns($filename, $outputf);
}

sub pickColumns
{
  my ($filename, $outputf) = @_;
  unlink($outputf);
  open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
  open(my $of, '>>', $outputf) or die "Could not open file '$outputf' $!";
  say 'start';
  my $counter = 0;
  while (my $line = <$fh>)
  {
    my @lineArr = split('\|', $line, -1);
    my @newLineArr = ();
    foreach my $i (@VALID_COL_IDX)
    {
        push(@newLineArr, "$lineArr[$i]")
    }
    my $newLine = join( '|', @newLineArr);
    print $of "$newLine";
    if (++$counter % 100 == 0)
    {
      print "Processed $counter records\n";
    }
  }

  close $fh;
  close $of;
  unlink($filename);
  rename $outputf, $filename or die "Cannot rename file: $!";
  print "Processed $counter records\n";
  say 'done';
}

main();

