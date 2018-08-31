#!/usr/bin/perl
use strict;
use warnings;

####################################################
## Daniel Pass | github.com/passdan | August 2016 ##
####################################################

# Print to the screen slower for effect!
$| = 1;

my %sequenceDB;
my $dbchoice;

if ($ARGV[0]){
  $dbchoice = $ARGV[0]
}else{
    print "Which Database to load:\n- GuessWho\n- Mars\n- Blank\n---\n";
    $dbchoice = <STDIN>;
    chomp($dbchoice);
    exit 0 if ($dbchoice eq ""); # If empty string, exit.
}

if(lc $dbchoice eq lc "GuessWho"){
  print "Loading Guess Who database!\n";sleep(1);
  loadGuessWhoDB();
}elsif(lc $dbchoice eq lc "Mars"){
  print "Loading Mars database!\n";sleep(1);
  loadMarsDB();
}elsif(lc $dbchoice eq lc "Blank"){
  print "Loading Blank database!\n";sleep(1);
  loadBlankDB();
}else{
print "I didn't understand that choice, exiting\n";
exit 0
}

print "Gene options are:\n";
foreach my $key (sort { $sequenceDB{$a} cmp $sequenceDB{$b} } keys %sequenceDB){
  print "$key\t$sequenceDB{$key}\n";
  select(undef, undef, undef, 0.1);
}
sleep(1);

my $prompt = "
############################################################
## Type a DNA sequence to search for what gene it is from ##
############################################################

Input: ";

system("clear");
print $prompt;

while (my $seq = <STDIN>){
  chomp($seq);
  if (exists $sequenceDB{$seq}){
    my $n = 0;
    print "Searching: 0%"; sleep(1);
    while ($n < 100){ $n+=25; print "----$n%";sleep(1);};
    my $genestring = $sequenceDB{$seq};
    # Guess Who return line
    if (lc $dbchoice eq lc "GuessWho"){
	    print "\n\nThis DNA sequence is found in the gene for:  "; sleep(1);
    # Mars return line
    }elsif(lc $dbchoice eq lc "Mars"){
	    print "\n\nThis DNA sequence is most similar to : "; sleep(1);
    }
    foreach (split //, $genestring){
      print;
      select(undef, undef, undef, 0.1);
    }
    print "!\n";
    sleep(1);
    restart();
  }else{
    sleep(1);
    print "\nOops! This sequence doesn't exist, make sure it's right!\n";
    sleep(1);
    restart();
  }
}

sub restart {
  print "\n~~~Press Enter to begin another search~~~\n";
  while (my $in = <STDIN>){
   if($in eq "\n"){
     system("clear");
     print $prompt;
     return;
   }
  }
}

sub loadGuessWhoDB {

  %sequenceDB = (
  TAGTGGAGCATC => "Attached Earlobes",      #Ears
  CGGAATAACATG => "Detached Earlobes",      #Ears
  CCAGTGGATGGC => "Brown Eyes",             #Eyes
  AGTCCAGTGGTA => "Blue Eyes",              #Eyes
  CAGCGGTTGCTA => "Green Eyes",             #Eyes
  GGGACATTCCTG => "Curly Hair",             #Hair Type
  TTAGCCGCAACG => "Straight Hair",          #Hair Type
  TATGTTGAAGGC => "Blonde Hair",            #Hair Colour
  AACTCCCGGATA => "Brown Hair",             #Hair Colour
  TGATAGACTGGC => "Black Hair",             #Hair Colour
  CCACTGGATCTA => "Ginger Hair",            #Hair Colour
  GTGATGCCGTGG => "Boy",                    #Sex
  AATACACCCGTG => "Girl",                   #Sex
  GAGTAACGCATC => "Doesn't need glasses",   #Eyesight
  GTCTCCGATATG => "Needs glasses"           #Eyesight
  );
  return;
}

sub loadMarsDB {

  %sequenceDB = (
  TAGTGGAGCATC => "Vulcan",                     #MS01
  CGGAATAACATG => "Unknown Species",            #MS02
  CCAGTGGATGGC => "Methanosarcina barkeri",     #MS03
  AGTCCAGTGGTA => "Yersinia pestis",            #MS04
  CAGCGGTTGCTA => "Ulva intestinalis",          #MS05
  GGGACATTCCTG => "Xenomorph XX121",            #MS06
  TTAGCCGCAACG => "Homo Sapien",                #MS07
  TATGTTGAAGGC => "Bradyrhizobium japonicum",   #MS08
  AACTCCCGGATA => "Cyanobacteria",              #MS09
  TGATAGACTGGC => "Campylobacter jejuni",       #MS10
  CCACTGGATCTA => "Salmonela enterica",         #MS11
  GTGATGCCGTGG => "Gungan",                     #MS12
  AATACACCCGTG => "Agaricus bisporus",          #MS13
  GAGTAACGCATC => "Influenza",                  #MS14
  );
  return;
}

sub loadBlankDB {

  %sequenceDB = (
  TAGTGGAGCATC => "",   #MS01
  CGGAATAACATG => "",   #MS02
  CCAGTGGATGGC => "",   #MS03
  AGTCCAGTGGTA => "",   #MS04
  CAGCGGTTGCTA => "",   #MS05
  GGGACATTCCTG => "",   #MS06
  TTAGCCGCAACG => "",   #MS07
  TATGTTGAAGGC => "",   #MS08
  AACTCCCGGATA => "",   #MS09
  TGATAGACTGGC => "",   #MS10
  CCACTGGATCTA => "",   #MS11
  GTGATGCCGTGG => "",   #MS12
  AATACACCCGTG => "",   #MS13
  GAGTAACGCATC => "",   #MS14
  );
  return;
}
