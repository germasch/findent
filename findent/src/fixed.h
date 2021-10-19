/* -copyright-
#-# Copyright: 2015,2016,2017,2018,2019,2020,2021 Willem Vermin wvermin@gmail.com
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
 */

#ifndef FIXED_H
#define FIXED_H

#include "fortran.h"

class Fixed : public Fortran
{
   public:
      Fixed(Findent *f) : Fortran(f) {}
      void build_statement(Fortranline &line, bool &f_more, bool &pushback);
      void output(lines_t &lines,bool contains_hollerith,lines_t *freelines = 0);
      void output_converted(lines_t &lines, bool ch);

   private:
      bool wizard(void);
      bool wizard(lines_t lines);
      std::string add_amp(const std::string &s,const char prevquote);

      std::string insert_omp(const std::string &s)
      {
	 if(is_omp)
	 {
	    std::string sl = s;
	    sl = sl + blanks(ompstr.length() - sl.length());
	    return sl.replace(0,ompstr.length(),ompstr);
	 }
	 else
	    return s;
      }

      bool        is_omp;
      std::string ompstr;
      std::string cmpstr;
};

#endif
