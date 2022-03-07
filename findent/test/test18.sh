#!/bin/sh
# -copyright-
#-# Copyright: 2015,2016,2017,2018,2019,2020,2021,2022 Willem Vermin wvermin@gmail.com
#-# 
#-# License: BSD-3-Clause
#-#  Redistribution and use in source and binary forms, with or without
#-#  modification, are permitted provided that the following conditions
#-#  are met:
#-#  1. Redistributions of source code must retain the above copyright
#-#     notice, this list of conditions and the following disclaimer.
#-#  2. Redistributions in binary form must reproduce the above copyright
#-#     notice, this list of conditions and the following disclaimer in the
#-#     documentation and/or other materials provided with the distribution.
#-#  3. Neither the name of the copyright holder nor the names of its
#-#     contributors may be used to endorse or promote products derived
#-#     from this software without specific prior written permission.
#-#   
#-#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
#-#  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#-#  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
#-#  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE HOLDERS OR
#-#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#-#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#-#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#-#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#-#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#-#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#-#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


if test -e prelude ; then
   . ./prelude
else
   unset FINDENT
   . ./debian/tests/prelude
fi
cat <<eof > prog1.f || exit 1
program prog1
continue
end program prog1
eof
cat << eof > prog2.f || exit 1
module modprog2
integer i
end module
program prog2
use modprog2
continue
end program prog2
eof
cat << eof > prog1.f.ref || exit 1
program prog1
     continue
end program prog1
eof
cat << eof > prog2.f.ref || exit 1
module modprog2
     integer i
end module
program prog2
     use modprog2
     continue
end program prog2
eof

$WFINDENT -q -i5 prog1.f prog2.f
tmpfile=`mktemp`
tr -d '\r' < prog1.f > $tmpfile
mv $tmpfile prog1.f
tmpfile=`mktemp`
tr -d '\r' < prog2.f > $tmpfile
mv $tmpfile prog2.f
for i in 1 2 ; do
   cmp -s prog$i.f prog$i.f.ref
   if [ $? -ne 0 ] ; then
      echo "prog$i.f and prog$i.f.ref are not equal"
      exit 1
   fi
done

. ../postlude
exit 0
