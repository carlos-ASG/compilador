import compilerTools.Token;

%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}

/* Variables básicas de espacios */
CaracteresEsp = [-|*|.|,|;|:|_|#|$]
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
cadenaTxt = \"[^\"]+\"

/* Comentario */
ComentarioDeUnaLinea = "#" {EntradaDeCaracter}* {TerminadorDeLinea}?
Comentario = {ComentarioDeUnaLinea}

/* Identificador */
Letra = [A-Za-z]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*
IdentificadorInvalido = ({Digito})+ ({Digito}|{Letra})*
IdentificadorInvalido2 = ({Letra}|{Digito})+ ({CaracteresEsp}|{Digito}|{Letra})*

/* Número */
Numero = 0 | [1-9][0-9]* | [1-9][0-9]*("."[0-9]+)
NumeroMalFormado = [0-9]+\.[0-9]*[^0-9] | \.[0-9]+[a-zA-Z_]+ | [0-9]+[a-zA-Z_]+ | [0-9]+\.[0-9]*\.[0-9]*
%%

/* Comentarios o espacios en blanco */
{Comentario}|{EspacioEnBlanco} { /*Ignorar*/ }

/* palabras reservadas y tipos de datos*/
float {return token(yytext(), "FLOAT", yyline, yycolumn);}
double {return token(yytext(), "DOUBLE", yyline, yycolumn);}
bool {return token(yytext(), "BOOL", yyline, yycolumn);}
int {return token(yytext(), "INT", yyline, yycolumn);}
number {return token(yytext(), "NUMBER", yyline, yycolumn);}
string {return token(yytext(), "STRING", yyline, yycolumn);}
unit {return token(yytext(), "UNIT", yyline, yycolumn);}
none {return token(yytext(), "NONE", yyline, yycolumn);}
def {return token(yytext(), "FUNCION", yyline, yycolumn);}
return {return token(yytext(), "RETURN", yyline, yycolumn);}
class {return token(yytext(), "CLASS", yyline, yycolumn);}
switch {return token(yytext(), "SWITCH", yyline, yycolumn);}
if {return token(yytext(), "IF", yyline, yycolumn);}
else {return token(yytext(), "ELSE", yyline, yycolumn);}
while {return token(yytext(), "WHILE", yyline, yycolumn);}
var {return token(yytext(), "VAR", yyline, yycolumn);}
vac {return token(yytext(), "VAC", yyline, yycolumn);}
char {return token(yytext(), "CHAR", yyline, yycolumn);}
true {return token(yytext(), "TRUE", yyline, yycolumn);}
false {return token(yytext(), "FALSE", yyline, yycolumn);}
then {return token(yytext(), "THEN", yyline, yycolumn);}
for {return token(yytext(), "FOR", yyline, yycolumn);}
out {return token(yytext(), "OUT", yyline, yycolumn);}
case {return token(yytext(), "CASE", yyline, yycolumn);}
main {return token(yytext(), "MAIN", yyline, yycolumn);}
class {return token(yytext(), "CLASS", yyline, yycolumn);}
interface {return token(yytext(), "INTERFACE", yyline, yycolumn);}
in {return token(yytext(), "IN", yyline, yycolumn);}
is {return token(yytext(), "IS", yyline, yycolumn);}
import {return token(yytext(), "IMPORT", yyline, yycolumn);}

/* CADENA DE TEXTO*/
{cadenaTxt} {return token(yytext(), "CADENA_TXT", yyline, yycolumn);}

/* caracteres especiales */

"." {return token(yytext(), "PUNTO", yyline, yycolumn);}
"+" {return token(yytext(), "OP_SUM", yyline, yycolumn);}
"-" {return token(yytext(), "OP_REST", yyline, yycolumn);}
"*" {return token(yytext(), "OP_MUL", yyline, yycolumn);}
"/" {return token(yytext(), "OP_DIV", yyline, yycolumn);}
"%" {return token(yytext(), "OP_RESI", yyline, yycolumn);}
"=" {return token(yytext(), "OP_ASIG", yyline, yycolumn);}
"==" {return token(yytext(), "OP_COMP", yyline, yycolumn);}
">" {return token(yytext(), "OP_MAYORQ", yyline, yycolumn);}
"<" {return token(yytext(), "OP_MENORQ", yyline, yycolumn);}
">=" {return token(yytext(), "OP_MAY_IG", yyline, yycolumn);}
"<=" {return token(yytext(), "OP_MEN_IG", yyline, yycolumn);}
"{" {return token(yytext(), "LLAVE_A", yyline, yycolumn);}
"}" {return token(yytext(), "LLAVE_C", yyline, yycolumn);}
"(" {return token(yytext(), "PAR_A", yyline, yycolumn);}
")" {return token(yytext(), "PAR_C", yyline, yycolumn);}
and {return token(yytext(), "AND", yyline, yycolumn);}
or {return token(yytext(), "OR", yyline, yycolumn);}
not {return token(yytext(), "NOT", yyline, yycolumn);}
";" {return token(yytext(), "PUNTO_COMA", yyline, yycolumn);}
":" {return token(yytext(), "DOS_PUNTOS", yyline, yycolumn);}
"$" {return token(yytext(), "SIG_$", yyline, yycolumn);}
"," {return token(yytext(), "COMA", yyline, yycolumn);}

/* Numeros */
{Numero} {return token(yytext(), "NUMERO", yyline, yycolumn);}
{NumeroMalFormado} { return token(yytext(), "NUM_INVALIDO", yyline, yycolumn); }


/* Identificador */
{Identificador} { return token(yytext(), "IDENTIFICADOR", yyline, yycolumn); }
{IdentificadorInvalido} { return token(yytext(), "ID_INVALIDO", yyline, yycolumn); }

. { return token(yytext(), "SIMBOLO_INVA", yyline, yycolumn); }