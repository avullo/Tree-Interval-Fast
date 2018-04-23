#ifdef __cplusplus
extern "C" {
#endif

/* 
   From http://blogs.perl.org/users/nick_wellnhofer/2015/03/writing-xs-like-a-pro---perl-no-get-context-and-static-functions.html
   The perlxs man page recommends to define the PERL_NO_GET_CONTEXT macro before including EXTERN.h, perl.h, and XSUB.h. 
   If this macro is defined, it is assumed that the interpreter context is passed as a parameter to every function. 
   If it's undefined, the context will typically be fetched from thread-local storage when calling the Perl API, which 
   incurs a performance overhead.
   
   WARNING:
   
    setting this macro involves additional changes to the XS code. For example, if the XS file has static functions that 
    call into the Perl API, you'll get somewhat cryptic error messages like the following:

    /usr/lib/i386-linux-gnu/perl/5.20/CORE/perl.h:155:16: error: ‘my_perl’ undeclared (first use in this function)
    #  define aTHX my_perl

   See http://perldoc.perl.org/perlguts.html#How-do-I-use-all-this-in-extensions? for ways in which to avoid these
   errors when using the macro.

   One way is to begin each static function that invoke the perl API with the dTHX macro to fetch context. This is
   used in the following static functions.
   Another more efficient approach is to prepend pTHX_ to the argument list in the declaration of each static
   function and aTHX_ when each of these functions are invoked. This is used directly in the AVL tree library
   source code.
*/
#define PERL_NO_GET_CONTEXT
  
#ifdef ENABLE_DEBUG
#define TRACEME(x) do {						\
    if (SvTRUE(perl_get_sv("Tree::Interval::Fast::ENABLE_DEBUG", TRUE)))	\
      { PerlIO_stdoutf (x); PerlIO_stdoutf ("\n"); }		\
  } while (0)
#else
#define TRACEME(x)
#endif
  
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
  
#include "ppport.h"
  
#include "interval.h"
  
#ifdef __cplusplus
}
#endif

typedef interval_t* Tree__Interval__Fast__Interval;

/* C-level callbacks required by the interval tree library */

static SV* svclone(SV* p) {
  dTHX;       /* fetch context */
  
  return newSVsv(p);
}

void svdestroy(SV* p) {
  dTHX;       /* fetch context */
  
  SvREFCNT_dec(p);
}

/*====================================================================
 * XS SECTION                                                     
 *====================================================================*/

MODULE = Tree::Interval::Fast 	PACKAGE = Tree::Interval::Fast::Interval PREFIX=interval_

Tree::Interval::Fast::Interval
interval_new(packname, low, high, data)
    char* packname
    float low
    float high
    SV*   data
  PROTOTYPE: $$$
  CODE:
    RETVAL = interval_new(low, high, data, svclone, svdestroy);
  OUTPUT:
    RETVAL

Tree::Interval::Fast::Interval
interval_copy(interval)
    Tree::Interval::Fast::Interval interval
  PROTOTYPE: $
  CODE:
    RETVAL = interval_copy(interval);
  OUTPUT:
    RETVAL

int
interval_overlap(i1, i2)
    Tree::Interval::Fast::Interval i1
    Tree::Interval::Fast::Interval i2
  PROTOTYPE: $$ 
  CODE:
    RETVAL = interval_overlap(i1, i2);
  OUTPUT:
    RETVAL

int
interval_equal(i1, i2)
    Tree::Interval::Fast::Interval i1
    Tree::Interval::Fast::Interval i2
  PROTOTYPE: $$ 
  CODE:
    RETVAL = interval_equal(i1, i2);
  OUTPUT:
    RETVAL

float
interval_low(interval)
    Tree::Interval::Fast::Interval interval
  PROTOTYPE: $
  CODE:
    RETVAL = interval->low;
  OUTPUT:
    RETVAL

float
interval_high(interval)
    Tree::Interval::Fast::Interval interval
  PROTOTYPE: $
  CODE:
    RETVAL = interval->high;
  OUTPUT:
    RETVAL

SV*
interval_data(interval)
    Tree::Interval::Fast::Interval interval
  PROTOTYPE: $
  CODE:
    RETVAL = newSVsv(interval->data);
  OUTPUT:
    RETVAL

void
interval_DESTROY(interval)
    Tree::Interval::Fast::Interval interval
  PROTOTYPE: $
  CODE:
    interval_delete(interval);
  
