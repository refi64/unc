/ lists
w:("if";"return";"for";"while";"do";"else";"goto";"int";"char";"true";"false";"void";"bool";"struct";"union";"enum";"extern";"const";"typedef";"register";"volatile";"include")
l:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
d:"0123456789"
f:("#!/bin/bash";"tmp=`mktemp`";"cat <<'EOF' > $tmp")
f,:0:`unc.rsp
f,:{"${a}",x,"$b/",x,"@"}'w / print keyword escapes
f,:${"(?<!@)",l[x],"(?![a-zA-Z]*@([^a-zA-Z]|$))",:["L"=l@x;"(?!'|\")";""],"/@",l@(x+65)!52}'!#l / print mangling patterns
f,:{"(?<!@)",d[x],"/@",d@(x+5)!10}'!#d / print digit manglers
f,:("@/";"\t/@") / print unescapes
f,:("EOF";"cat $1 | rs.py -f $tmp";"rm $tmp")
`unc 0:f@&(~0=#:)'f
