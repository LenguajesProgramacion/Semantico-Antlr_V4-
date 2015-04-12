grammar Proyecto;
init: code
    ;

general:declaration
    |asignation
    |function
    |comen
    |read
    |write
    |clear
    |code
    |
        ;
code:declaration
    |asignation
    |function
    |condif
    |condWhile
    |condDoWhile
    |indepent
    |comen
    |read
    |write
    |clear
    |
    ;

condDoWhile:  'hacer' '{' bloque_hacer_mientras   '}''mientras'  comparacion  code;
condWhile:'mientras'  comparacion  '{' bloque_mientras '}' code ;
//Condicional sin parentecis, en caso Emergencia Agregarlos Aqui.
condif : 'si' comparacion  'entonces' '{' (condif)* code retornar* '}' code
        | 'si' comparacion  'entonces'  (condif)* code retornar*  code
        |'si' comparacion  'entonces' '{' (condif)* code retornar* '}' 'si_no' '{' code retornar* '}'code
        |'si' comparacion  'entonces' '{' (condif)* code retornar* '}' 'si_no'  code retornar* code
        |'si' comparacion  'entonces'  (condif)* code retornar*  'si_no' '{' code retornar* '}'code
        |'si' comparacion  'entonces'  (condif)* code retornar*  'si_no'  code retornar*  code

        ;

bloque_hacer_mientras: code retornar*
            ;
bloque_mientras: code retornar*
            ;

indepent: NAME '(' exp')' ';'code
          |NAME '('NAME')' ';'code
          |NAME '(' ')' ';'code
          |NAME '=' NAME'(' exp')' ';'code
          |NAME '=' NAME'(' valor')' ';'code
          |NAME '=' NAME'(' exp')' suma exp ';'code
          |NAME '=' NAME'(' exp')' mult exp ';'code
            ;

retornar: 'retornar' ';'
            |'retornar' exp ';'
            { System.out.println(" Expresion1");}
            |'retornar' indepent ';'
            { System.out.println(" Expresion2");}
            |'retornar' NAME'(' exp')' suma exp ';'code
            { System.out.println(" Expresion3");}
            |'retornar' exp suma NAME'(' exp')' ';'code
            { System.out.println(" Expresion4");}
            |'retornar' NAME'(' exp')' mult exp ';'code
            { System.out.println(" Expresion5");}
            |'retornar' exp mult NAME'(' exp')' ';'code
            { System.out.println(" Expresion6");}
            ;

comparacion: op comparator op
            |'(' op comparator op ')'
           ;

read    :   'leer' NAME ';'
        |   'leer' NAME ';' code
        ;

write   :   'escribir' exp ';'
        |   'escribir' exp ';' code
        ;

clear   :   'borrar'
        |   'borrar' code
        ;

comparator:'=='
          |'!='
          |'>='
          |'<='
          |'>'
          |'<'
          ;

declaration : tipo NAME ';'
    |tipo NAME ';' code
    |tipo NAME (',' NAME)+ ';'code
    |tipo NAME '=' exp ';' code
    |tipo NAME '=' NAME '(' exp* ')'';' code
    ;

asignation : NAME '=' exp ';'
            |NAME '=' exp ';' code
            | exp  '=' exp ';'
            | exp  '='exp ';' code
           ;


comen : PALABRA
       |PALABRA code
       |MULTI_COMENT
       |MULTI_COMENT code
 ;

MULTI_COMENT  : '/*'.*?'*/'

            ;




function: tipo  NAME'(' (parametros)* ')' '{' code  retornar* '}' code;

parametros: tipo NAME
            |tipo NAME ','
        ;


exp : valor
    |op
    ;


tipo : 'entero'|'real'|'vacio'|'cadena' ;


valor : INTEGER|BOOL|FLOAT|CADENA ;

op: termino suma op
  | termino

  ;
suma :'+'
     |'-'
     ;

termino: fact mult termino
       | fact
       ;

mult :'*'
     |'/'
     |'%'
     ;


fact : unit literal
     |literal
     ;

unit :'-'
     |'!'
     ;
literal:
        NAME
       |INTEGER
       |FLOAT
       |CADENA
       |BOOL
       ;
PALABRA: '//'.*? '\n';
NAME : [a-zA-Z][a-zA-Z0-9]*;
BOOL : 'true'|'false';
INTEGER : [0-9]+ ;
FLOAT : [0-9]+'.'[0-9]+ ;
CADENA :  [a-zA-Z0-9]+;
WS  :   [ \t\r\n]+ -> skip ;