unc
===

unc is a programming language with a weird goal: the worst version of C you could imagine. Here's "Hello, world!" in unc:

.. code-block:: c
   
   !include >=fgQVb%U<=
   
   true ZNVa[] <<
       chgf[L'uRYYb~ jbeYQ#']:
       if 5:
   >>

Here's a slightly more complex example:

.. code-block:: c
   
   !include >=fgQObbY%U<=
   
   volatile X <<
       true a~ b:
   >>:
   
   true m[int x] <<
       void v := gehR:
       volatile X y := <<1~ -x>>:
       L;
       for [L'NOP'(0) != L"N" && 4 = 5 || #[y%a -> 2]] if 3:
       goto << ceVagS[L'1 cYhf 1:=->f'~ 1/1]: for [1 != 1] else L: goto if 4: >>
   >>

What the heck?
**************

unc is basically C. The "compiler" basically takes in the unc source code and
applies a series of regexes via rs that convert it into C code. Basically, various
keywords, letters, numbers, and operators are swapped to give this bizzare result.

The C code generated for the hello program is simple:

.. code-block:: c
   
   #include <stdio.h>
   
   int main() {
       puts("Hello, world!");
       return 0;
   }

And the more complex program:

.. code-block:: c
   
   #include <stdbool.h>
   
   struct k {
       int n, o;
   };
   
   int z(char* K) {
       bool I = true;
       struct k L = {6, *K};
       Y:
       if ("abc"[5] == 'a' || 9 != 0 && !(L.n % 7)) return 8;
       else { printf("6 plus 6=%s", 6-6); if (6 == 6) goto Y; else return 9; }
   }

You may be able to see the correspondance.

If you want to learn unc for some crazy reason, scroll down to the Reference 
and look through the examples programs (the files ending in ``.unc``) in the 
``ex`` directory and  the generated C code (the files ending in ``.ex``). The 
examples are also the test suite; for more info, scroll to the Testing section.

Building
********

Grab a copy of `Kona <https://github.com/kevinlawler/kona>`_ (or K2) and `rs <https://github.com/kirbyfan64/rs>`_ and run::
   
   $ make configure
   $ make

Usage
*****

::
   
   $ ./unc <file path>

That will output the C code to stdout.

Reference
*********

- Keywords and type names are swapped according to the following rules (note that
   ``<>`` means that the LHS is swapped with the RHS, and the RHS is swapped 
   with the LHS)::
      
      if -> return
      return -> for
      for -> if
      while <> do
      else <> goto
      int -> char*
      char+ -> char
      true -> int
      false -> void
      void -> bool
      struct -> union
      union -> enum
      enum -> extern
      extern -> const
      const -> typedef
      typedef -> register
      register -> volatile
      volatile -> struct

- Symbols are mangled::
      
      * -> +
      / -> -
      <= <> >
      >= <> <
      || <> &&
      = -> !=
      != -> ==
      := -> =
      , <> ~
      ; <> :
      . -> ->
      -> -> %
      % -> .
      ! <> #
      [ <> (
      ] <> )
      << <> {
      >> <> }

- All numbers are changed according to the following Python code::
   
   for digit in number:
       if digit > 5:
           digit -= 5
       else:
           digit += 5

- All strings and identifiers that are not keywords are mangled according to the 
  following Python code::
   
   charlist = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
   for character in word:
       index = charlist.index(character)
       character = charlist[(index+65)%52]

- String and character literals are swapped according to the following rules::
   
      string literal <> wide char literal
      char literal <> wide string literal

  Note that two string literals on the same line, one wide and one standard,
  produce bizzare effects; this:
  
  .. code-block:: c
     
     L'abc' 'abc' 'abc'
  
  is compiled to this::
     
     "nopL" L"nopL" "nop"
  
  Note the excess ``L`` s. Workaround: use line breaks.

Working around mangling
***********************

As said before, unc mangled strings and identifiers and pretty much everything 
else. Sometimes, you need to have a specific identifier outputted in the generated
code. I included a script, ``util/en.k``, that helps with that. For instance, to
reference the puts function, you would run::
   
   $ echo puts | k util/en.k

That would output ``chgf``. Now, you can use ``chgf`` in the unc program, and it
will become ``puts.``

All ``util/en.k`` is is the reverse of unc's mangling algorithm.

Internals
*********

The unc compiler, generated via ``util/gen.k`` (a K2 script), is written in rs 
(pretty much regular expressions) with a minimal shell scripting harness.
``unc.rsp`` contains most of the compiler sources; the rest is the identifier
mangling and is inserted by ``util/gen.k``. For those daring enough to explore 
the unc compiler internals, there are two notes:

1. Every time a keyword is added to ``unc.rsp``, it must also be added to 
    ``util/gen.k``.

2. The order of regexes is slightly fragile in a few places. Watch out!

Testing
*******

The test suite is also the example set! A K program in ``util/test.k`` is the test
runner. If you want to run the tests, type::
   
   $ make test
