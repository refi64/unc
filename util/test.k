tr:{x@&(~0=#:)'x}      / a helper to trim empty lines
f:!"ex"                / enumerate all files in the 'ex' folder
f:f@&~{(#x)=#&x="."}'f / remove '.' and '..' from the list
{
  p:"ex/",x                    / the full path
  `0:"running test ",x,"\n"    / print the test name
  out:`4:"./unc ",p,".unc"     / call unc and save it's output to the out variable
  if[~tr[0:p,".ex"]~tr[out]    / if out and the expected output file differ then
    `0:"FAILED\n"                           / print the FAILED message
    `.tmp 0:out                             / write the output to .tmp
    `0:`4:"diff -uw ",p,".ex .tmp||exit 0"] / run diff on the outputs
}'?{(x?".")#x}'f; / do that for each file in 'ex', removing the extension
`4:"rm .tmp>/dev/null 2>&1||exit 0";     / delete the temporary file
