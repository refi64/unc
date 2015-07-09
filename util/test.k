tr:{x@&(~0=#:)'x} / a helper to trim empty lines
f:!"ex" / enumerate all files in the 'ex' folder
f:f@&~{(#x)=#&x="."}'f / remove '.' and '..' from the list
{`0:"running test ",x,"\n" / print the test name
 `.tmp 0:`4:"./unc ex/",x,".unc" / call unc and write it's output to .tmp
 if[~tr[0:`$"ex/",x,".ex"]~tr[0:`.tmp] / compare .tmp to the expected output file
  `0:"FAILED\n" / if they failed, print FAILED...
  `0:`4:"diff -uw ex/",x,".ex .tmp||exit 0"] / ...and run diff on the outputs
 }'?{(x?".")#x}'f; / do that for each file in 'ex'
`4:"rm .tmp"; / delete the temporary file
