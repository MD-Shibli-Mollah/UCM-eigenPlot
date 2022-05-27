#!/usr/bin/env perl

# PERL CODE RUN COMMAND
# e.g. perl spectrum.pl < eigenvalues_noeh.dat > spectrum.dat


$pi = 3.1415962;

# Gaussian broadening
$width = 0.5; 
$emin = 0; 
$emax = 500; 
$estep = 1;
$abs_spectrum = 0; 
$electron = 13.606;
$nfiles=0; #Our calculation does not require this. Some other calculation requires it. Still kept it. 

# loop over datasets
while(<STDIN>) {

# move through header info 
    while(<STDIN>) {
        if($_ =~ /^#   ik/)  # It's for parsing the data
            $nfiles++;       # It might not impact our result. 
            last;
        }
    }

#These are the eigenvalues_noeh.dat file data, to see at a glance------------------------------------------------------------
##   ik    ic    iv    is         ec (eV)         ev (eV)        eig (eV)   abs(dipole)^2          dipole 
#     1     1     1     1  0.73760347E+02  0.36820680E+02  0.36939667E+02  0.37700076E-02  0.61400388E-01
#     1     1     2     1  0.73760347E+02 -0.33100160E+02  0.10686051E+03  0.41246494E-04 -0.64223434E-02
#     1     1     3     1  0.73760347E+02 -0.33104646E+02  0.10686499E+03  0.17556626E-03  0.13250142E-01
#     1     1     4     1  0.73760347E+02 -0.33109496E+02  0.10686984E+03  0.24123677E-01 -0.15531799E+00
#     1     1     5     1  0.73760347E+02 -0.36816821E+02  0.11057717E+03  0.91220666E-02  0.95509510E-01
#--------------------------------------------------------------------------------------------------------------

# parse data
    while(<STDIN>) {
        @linesplit = split(' ');
        if($#linesplit != 5) {
            last; # data is done
        }
        $eig = $linesplit[6]; #Need to check, if called proper column
        $dip = $linesplit[7]; #Need to check, if called proper column


        $energy = $emin;
        for($ie = 0; $ie < ($emax - $emin) / $estep; $ie++) 
            $ep_spectrum[$ie] += ($dip / ($width * sqrt(2 * $pi))) * exp(-0.5 * (($energy - $eig) / $width)**2) * ((16 * ($pi)**2 * ($electron)**2)/($eig)**2) ;  #equation
            $energy += $estep;
        }
    }
}


$energy = $emin;
printf "%12s %12s\n", "Energy (eV)", "epsilon_2"; 

for($ie = 0; $ie < ($emax - $emin) / $estep; $ie++) {
    printf "%12.6f %12.6f\n", $energy, $ep_spectrum[$ie]; 
    $energy += $estep;
}
