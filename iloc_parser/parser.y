/*
http://www.gnu.org/software/bison/manual/bison.html
PROLOGUE
*/

%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "iks_iloc.h"
  #include "iks_list.h"

  iks_list_t *iloc_program;

%}

/*
DECLARATIONS
*/

%union {
  char *c;
  int op;
}

%token add 0
%token sub 1
%token mult 2
%token _div 3
%token inv 4
%token addI 5
%token subI 6
%token multI 7
%token divI 8
%token rdivI 9
%token and 10
%token andI 11
%token or 12
%token orI 13
%token xor 14
%token xorI 15
%token lshift 16
%token rshift 17
%token lshiftI 18
%token rshifI 19
%token load 20
%token loadAI 21
%token loadA0 22
%token loadI 23
%token cload 24
%token cloadAI 25
%token cloadA0 26
%token store 27
%token storeAI 28
%token storeA0 29
%token cstore 30
%token cstoreAI 31
%token cstoreA0 32
%token i2i 33
%token c2c 34
%token c2i 35
%token i2c 36
%token cmp_LT 37
%token cmp_LE 38
%token cmp_EQ 39
%token cmp_GE 40
%token cmp_GT 41
%token cmp_NE 42
%token cbr 43
%token jump 44
%token jumpI 45
%token nop 46
%token tbl 47

%token<c> r 48
%token<c> l 49

%token comma 50
%token to 51

%type<op> op


%start p0



%%

/*
GRAMMAR RULES
*/

p0:
  {
    program_iloc = new_iks_list();
  } p
;

p:
  p i
  | /* empty */ { }
;

i:
  i_2_1
  | i_1_1
  | i_1_2
  | i_0_1
  | i_2_0
;

i_2_1:
  op r comma r to r
    {
      iloc_t *iloc;
      iloc = new_iloc(NULL, new_iloc_oper($1,
                                          $2,
                                          $4,
                                          NULL,
                                          $6,
                                          NULL,
                                          NULL));
      iks_list_append(program_iloc, (void*)iloc);
    }
;

i_1_1:
  op r to r
    {
      iloc_t *iloc;
      iloc = new_iloc(NULL, new_iloc_oper($1,
                                          $2,
                                          NULL,
                                          NULL,
                                          $4,
                                          NULL,
                                          NULL));
      iks_list_append(program_iloc, (void*)iloc);
    }
;

i_1_2:
  op r to r comma r
    {
      iloc_t *iloc;
      iloc = new_iloc(NULL, new_iloc_oper($1,
                                          $2,
                                          NULL,
                                          NULL,
                                          $4,
                                          $6,
                                          NULL));
      iks_list_append(program_iloc, (void*)iloc);
    }
;

i_0_1:
  op r
    {
      iloc_t *iloc;
      iloc = new_iloc(NULL, new_iloc_oper($1,
                                          NULL,
                                          NULL,
                                          NULL,
                                          $2,
                                          NULL,
                                          NULL));
      iks_list_append(program_iloc, (void*)iloc);
    }
;

i_2_0:
  op r comma r
    {
      iloc_t *iloc;
      iloc = new_iloc(NULL, new_iloc_oper($1,
                                          $2,
                                          $4,
                                          NULL,
                                          NULL,
                                          NULL,
                                          NULL));
      iks_list_append(program_iloc, (void*)iloc);
    }
;

op:
  add { $$=op_add; }
  | sub { $$=op_sub; }
  | mult { $$=op_mult; }
  | _div { $$=op_div; }
  | inv { $$=op_inv; }
  | addI { $$=op_addI; }
  | subI { $$=op_subI; }
  | multI { $$=op_multI; }
  | divI { $$=op_divI; }
  | rdivI{ $$=op_rdivI; }
  | and { $$=op_and; }
;

%%
