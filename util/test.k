tr:{x@&(~0=#:)'x}
{`0:"running test ",x,"\n";`3:"./unc ex/",x,".unc > .tmp";if[~tr[0:`$"ex/",x,".ex"]~tr[0:`.tmp];`0:"FAILED\n";`3:"diff -uw ex/",x,".ex .tmp||exit 0"]}'?{(x?".")#x}'!"ex"
`3:"rm .tmp"
