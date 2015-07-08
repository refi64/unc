tr:{x@&(~0=#:)'x}
f:!"ex"
f:f@&~{(#x)=#&x="."}'f
{`0:"running test ",x,"\n";`.tmp 0:`4:"./unc ex/",x,".unc";if[~tr[0:`$"ex/",x,".ex"]~tr[0:`.tmp];`0:"FAILED\n";`0:`4:"diff -uw ex/",x,".ex .tmp||exit 0"]}'?{(x?".")#x}'f;
`4:"rm .tmp";
