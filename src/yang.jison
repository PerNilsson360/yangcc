// MIT license
//
// Copyright 2024 Per Nilsson
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

%lex

DIGIT           [0-9]
L               [a-zA-Z_]

%x str
%x double_quoted_string
%x single_quoted_string
%x identifier
%x qname
%x schema_path
%x date
%x range
%x len
%x integer
%x comment
%x unknown
%x status

%%

"action"                                                        { this.begin('identifier'); return 'action'; }
"anydata"                                                       { this.begin('identifier'); return 'anydata'; }
"anyxml"                                                        { this.begin('identifier'); return 'anyxml'; }
"argument"                                                      { this.begin('identifier'); return 'argument'; }
"augment"                                                       { this.begin('schema_path'); return 'AUGMENT'; } 
"base"                                                          { this.begin('qname'); return 'base'; }
"belongs-to"                                                    { this.begin('identifier'); return 'belongs-to'; }
"bit"                                                           { this.begin('identifier'); return 'bit'; }
"case"                                                          { this.begin('identifier'); return 'CASE'; }
"choice"                                                        { this.begin('identifier'); return 'choice'; }
"config"                                                        { return('config'); }
"contact"                                                       { this.begin('str'); return 'contact'; }
"container"	                                                    { this.begin('identifier'); return 'CONTAINER'; }
"default"                                                       { this.begin('str'); return 'default'; } 
"description"                                                   { this.begin('str'); return 'description'; }
"enum"                                                          { this.begin('str'); return' enum'; }
"error-app-tag"                                                 { this.begin('str'); return 'error-app-tag'; }
"error-message"                                                 { this.begin('str'); return 'error-message'; }
"extension"                                                     { this.begin('identifier'); return 'extension'; }
"deviation"                                                     { return 'deviation'; }
"deviate"                                                       { return'deviate'; }
"feature"                                                       { this.begin('identifier'); return 'feature'; }
"fraction-digits"                                               { this.begin('integer'); return 'fraction-digits'; }
"grouping"                                                      { this.begin('identifier'); return 'grouping'; }
"identity"                                                      { this.begin('identifier'); return 'identity'; }
"if-feature"                                                    { this.begin('qname'); return 'if-feature'; }
"import"                                                        { this.begin('identifier'); return 'import'; }
"include"                                                       { this.begin('identifier'); return 'include'; }
"input"                                                         { return'input'; }
"key"                                                           { this.begin('qname'); return 'key'; }
"leaf"	                                                        { this.begin('identifier'); return 'leaf'; }      
"leaf-list"                                                     { this.begin('identifier'); return 'leaf-list'; }
"length"                                                        { this.begin('length'); return 'length'; }
"list"                                                          { this.begin('identifier'); return'list'; }       
"mandatory"                                                     { return'mandatory'; }
"max-elements"                                                  { this.begin('integer'); return max-elements; }
"min-elements"                                                  { this.begin('integer'); return min-elements; }
"modifier"                                                      { return('modifier'); }
"module"		                                                { this.begin('identifier'); return 'module'; }  
"must"                                                          { this.begin('str'); return 'must'; }
"namespace"                                                     { this.begin('str'); return 'namespace'; }
"notification"                                                  { this.begin('identifier'); return 'notification'; }
"ordered-by"                                                    { return 'ordered-by'; }
"organization"                                                  { this.begin('str'); return 'organization'; }
"output"                                                        { return 'output'; }
"path"                                                          { this.begin(str); return 'path'; }
"pattern"                                                       { this.begin(str); return 'pattern'; }
"position"                                                      { this.begin(integer); return 'position'; }
"prefix"                                                        { this.begin(identifier); return 'prefix'; }
"presence"                                                      { this.begin(str); return 'presence'; }
"range"                                                         { this.begin(range); return 'range'; }
"reference"                                                     { this.begin(str); return 'reference'; }
"refine"                                                        { return 'refine'; }
"require-instance"                                              { return 'require-instance'; }
"revision"                                                      { this.begin(date); return 'revision'; }
"revision-date"                                                 { this.begin(date); return 'revision-date'; }
"rpc"                                                           { this.begin(identifier); return 'rpc'; }
"status"                                                        { this.begin(status); return 'status'; }
"submodule"                                                     { this.begin(identifier); return'submodule'; }
"type"		                                                    { this.begin(qname); return 'type'; }
"typedef"                                                       { this.begin(identifier); return 'typedef'; }
"unique"                                                        { this.begin(schema_path); return 'unique'; }
"units"                                                         { this.begin(str); return 'units'; }
"uses"                                                          { this.begin(qname); return 'uses'; }
"value"                                                         { this.begin(integer); return 'value'; }
"when"                                                          { this.begin(str); return 'when'; }
"yang-version"                                                  { this.begin(str); return 'yang-version'; }
"yin-element"                                                   { return 'yin-element'; }
<status>"current"                                               { return 'current'; }
<status>"obsolete"                                              { return 'obsolete'; }
<status>"deprecated"                                            { return 'deprecatedd'; }
"false"                                                         { return 'false'; }
"invert-match"                                                  { return 'invert-match'; }
<range,len>"max"                                                { return 'max'; }
<range,len>"min"                                                { return 'min'; }
"true"                                                          { return 'true'; }
"system"                                                        { return 'system'; }
"user"                                                          { return 'user'; }
<range,len>".."                                                 { return '..'; }
<*>"{"     		                                                { this.begin('INITIAL'); return '{'; }
"}"     		                                                { this.begin('INITIAL'); return '}'; }
<*>";"			                                                { this.begin('INITIAL'); return ';'; }
<str>"+"                                                        { return('+'); }                                                      
<qname,schema_path,unknown>":"			                        { return(':'); }
<range>"|"			                                            { return('|'); }
<schema_path>"/"			                                    { return('/'); }
<date>{DIGIT}{4}"-"{DIGIT}{2}"-"{DIGIT}{2}                      { return 'DATE'; }
<integer,range,len>"-"{DIGIT}*|{DIGIT}*                                            { return 'INTEGER'; }
<range>"-"{DIGIT}+"."{DIGIT}+|{DIGIT}+"."{DIGIT}+                                     { return 'DECIMAL'; }'
({L}|"_")({L}|{DIGIT}|[-_.])*                                                         { this.begin(unknown); return 'IDENTIFIER'; }
<unknown>({L}|"_")({L}|{DIGIT}|[-_.])*                                                { this.begin(str); return 'IDENTIFIER'; }
<identifier,qname,schema_path>({L}|"_")({L}|{DIGIT}|[-_.])*                           { return 'IDENTIFIER'; }
<str>"\""                                                                             { this.begin(double_quoted_string); }
<double_quoted_string>([^"])*                                                         { return 'QUOTED_STRING_PART'} 
<double_quoted_string>"\""                                                            { this.begin(str); } 
<str>"'"                                                                              { this.begin(single_quoted_string); }
<single_quoted_string>([^'])*                                                         { return 'QUOTED_STRING_PART' }
<single_quoted_string>"'"                                                             { this.begin(str); } 
<str>([^\x09\x0A\x0B\x0D\x20;{'\""])([^\x09\x0A\x0B\x0D\x20;{"])*                         { return 'UNQUOTED_STRING'; }
[\x09\x0A\x0B\x0D\x20]		                                                              {/* skip whitespaces in intital start condition */}
<identifier,str,qname,schema_path,date,range,len,integer,status>[\x09\x0A\x0B\x0D\x20] { }
<identifier,qname,schema_path,date,range,len,integer>"\""                              { /* these are *-arg-str in grammar so need to skip quotes */ }
"/*"                                                                                      {  this.begin(comment); }
<comment>[^*\n]*                                                                          {/* eat anything that's not a '*' */ }
<comment>"*"+[^*/\n]*                                                                     {/* eat up '*'s not followed by '/'s */ }
<comment>\n                                                                               {}
<comment>"*"+"/"                                                                          {  this.begin(INITIAL); }
<*>.			                                                                          { cosnole.log('FIXME: uhandled char') }

/lex

%start yang

%% /* language grammar */

yang
: top_stmt                                                           {}
| top_stmts top_stmt                                                 {}
;

top_stmt
: module_stmt                                                        { $$ = $1; }
| submodule_stmt                                                     { $$ = $1; }
;

module_stmt
: 'module' IDENTIFIER '{' '}'                     {}
;


%%
