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
<range,len>".."                                                                        { return '..'; }
<*>"{"     		                                                                       { this.begin('INITIAL'); return '{'; }
"}"     		                                                                       { this.begin('INITIAL'); return '}'; }
<*>";"			                                                                       { this.begin('INITIAL'); return ';'; }
<str>"+"                                                                               { return('+'); }                                                      
<qname,schema_path,unknown>":"			                                               { return(':'); }
<range>"|"			                                                                   { return('|'); }
<schema_path>"/"			                                                           { return('/'); }
<date>{DIGIT}{4}"-"{DIGIT}{2}"-"{DIGIT}{2}                                             { return 'DATE'; }
<integer,range,len>"-"{DIGIT}*|{DIGIT}*                                                { return 'INTEGER'; }
<range>"-"{DIGIT}+"."{DIGIT}+|{DIGIT}+"."{DIGIT}+                                      { return 'DECIMAL'; }'
({L}|"_")({L}|{DIGIT}|[-_.])*                                                          { this.begin(unknown); return 'IDENTIFIER'; }
<unknown>({L}|"_")({L}|{DIGIT}|[-_.])*                                                 { this.begin(str); return 'IDENTIFIER'; }
<identifier,qname,schema_path>({L}|"_")({L}|{DIGIT}|[-_.])*                            { return 'IDENTIFIER'; }
<str>"\""                                                                              { this.begin(double_quoted_string); }
<double_quoted_string>([^"])*                                                          { return 'QUOTED_STRING_PART'} 
<double_quoted_string>"\""                                                             { this.begin(str); } 
<str>"'"                                                                               { this.begin(single_quoted_string); }
<single_quoted_string>([^'])*                                                          { return 'QUOTED_STRING_PART' }
<single_quoted_string>"'"                                                              { this.begin(str); } 
<str>([^\x09\x0A\x0B\x0D\x20;{'\""])([^\x09\x0A\x0B\x0D\x20;{"])*                      { return 'UNQUOTED_STRING'; }
[\x09\x0A\x0B\x0D\x20]		                                                           {/* skip whitespaces in intital start condition */}
<identifier,str,qname,schema_path,date,range,len,integer,status>[\x09\x0A\x0B\x0D\x20] { }
<identifier,qname,schema_path,date,range,len,integer>"\""                              { /* these are *-arg-str in grammar so need to skip quotes */ }
"/*"                                                                                   {  this.begin(comment); }
<comment>[^*\n]*                                                                       { /* eat anything that's not a '*' */ }
<comment>"*"+[^*/\n]*                                                                  { /* eat up '*'s not followed by '/'s */ }
<comment>\n                                                                            {}
<comment>"*"+"/"                                                                       {  this.begin(INITIAL); }
<*>.			                                                                       { cosnole.log('FIXME: uhandled char') }

/lex

%start top_stmts

%% /* language grammar */
/* comment */
top_stmts
: top_stmt                                                           {}
| top_stmts top_stmt                                                 {}
;

top_stmt
: module_stmt                                                        { $$ = $1; }
| submodule_stmt                                                     { $$ = $1; }
;

/////////////////////////////////////////////////////////////////////////////////////////////
// draft-ietf-netmod-rfc6020bis-08
/*    module-stmt         = optsep module-keyword sep identifier-arg-str */
/*                          optsep */
/*                          "{" stmtsep */
/*                              module-header-stmts */
/*                              linkage-stmts */
/*                              meta-stmts */
/*                              revision-stmts */
/*                              body-stmts */
/*                          "}" optsep */
module_stmt
: 'module' 'IDENTIFIER' '{' module_body_stmts '}'                     {}
;

module_body_stmts
: module_body_stmt                                                   {}
| module_body_stmts module_body_stmt                                 {}
;

module_body_stmt
: yang_version_stmt                                                  { $$ = $1; } /* module-header-stmts */
| namespace_stmt                                                     { $$ = $1; } 
| prefix_stmt                                                        { $$ = $1; } 
| import_stmt                                                        { $$ = $1; } /* linkage-stmts*/
| include_stmt                                                       { $$ = $1; }
| organization_stmt                                                  { $$ = $1; } /* meta-stmts*/
| contact_stmt                                                       { $$ = $1; }
| description_stmt                                                   { $$ = $1; } 
| reference_stmt                                                     { $$ = $1; }
| revision_stmt                                                      { $$ = $1; } /* revision-stmts */
| extension_stmt                                                     { $$ = $1; } /* body-stmts */
| feature_stmt                                                       { $$ = $1; }
| identity_stmt                                                      { $$ = $1; }
| typedef_stmt                                                       { $$ = $1; }
| grouping_stmt                                                      { $$ = $1; }
| container_stmt                                                     { $$ = $1; } /*  data-def-stmt */
| leaf_stmt                                                          { $$ = $1; }
| leaf_list_stmt                                                     { $$ = $1; }
| list_stmt                                                          { $$ = $1; }
| choice_stmt                                                        { $$ = $1; }
| anydata_stmt                                                       { $$ = $1; }
| anyxml_stmt                                                        { $$ = $1; }
| uses_stmt                                                          { $$ = $1; }
| augment_stmt                                                       { $$ = $1; }
| rpc_stmt                                                           { $$ = $1; }    
| notification_stmt                                                  { $$ = $1; } 
/*                            deviation-stmt) */
| unknown_stmt                                                       { $$ = $1; }
;

/*    submodule-stmt      = optsep submodule-keyword sep identifier-arg-str */
/*                          optsep */
/*                          "{" stmtsep */
/*                              submodule-header-stmts */
/*                              linkage-stmts */
/*                              meta-stmts */
/*                              revision-stmts */
/*                              body-stmts */
/*                          "}" optsep */
submodule_stmt
: 'submodule' 'IDENTIFIER' '{' submodule_body_stmts '}'               {}
;

submodule_body_stmts
: submodule_body_stmt                                                {}
| submodule_body_stmts submodule_body_stmt                           {}
;

submodule_body_stmt
: yang_version_stmt                                                  { $$ = $1; } /* submodule-header-stmts */
| belongs_to_stmt                                                    { $$ = $1; } 
| import_stmt                                                        { $$ = $1; } /* linkage-stmts*/
| include_stmt                                                       { $$ = $1; }
| organization_stmt                                                  { $$ = $1; } /* meta-stmts*/
| contact_stmt                                                       { $$ = $1; }
| description_stmt                                                   { $$ = $1; } 
| reference_stmt                                                     { $$ = $1; }
| revision_stmt                                                      { $$ = $1; } /* revision-stmts */
| extension_stmt                                                     { $$ = $1; } /* body-stmts */
| feature_stmt                                                       { $$ = $1; }
| identity_stmt                                                      { $$ = $1; }
| typedef_stmt                                                       { $$ = $1; }
| grouping_stmt                                                      { $$ = $1; }
| container_stmt                                                     { $$ = $1; } /*  data-def-stmt */
| leaf_stmt                                                          { $$ = $1; }
| leaf_list_stmt                                                     { $$ = $1; }
| list_stmt                                                          { $$ = $1; }
| choice_stmt                                                        { $$ = $1; }
| anydata_stmt                                                       { $$ = $1; }
| anyxml_stmt                                                        { $$ = $1; }
| uses_stmt                                                          { $$ = $1; }
| augment_stmt                                                       { $$ = $1; }
| rpc_stmt                                                           { $$ = $1; }                    
| notification_stmt                                                  { $$ = $1; }
/*                            deviation-stmt) */
| unknown_stmt                                                       { $$ = $1; } 
;

// /*    module-header-stmts = ;; these stmts can appear in any order */
// /*                          yang-version-stmt */
// /*                          namespace-stmt */
// /*                          prefix-stmt */

// /*    submodule-header-stmts = */
// /*                          ;; these stmts can appear in any order */
// /*                          yang-version-stmt */
// /*                          belongs-to-stmt */

// /*    meta-stmts          = ;; these stmts can appear in any order */
// /*                          [organization-stmt] */
// /*                          [contact-stmt] */
// /*                          [description-stmt] */
// /*                          [reference-stmt] */

// /*    linkage-stmts       = ;; these stmts can appear in any order */
// /*                          *import-stmt */
// /*                          *include-stmt */

// /*    revision-stmts      = *revision-stmt */

// /*    body-stmts          = *(extension-stmt / */
// /*                            feature-stmt / */
// /*                            identity-stmt / */
// /*                            typedef-stmt / */
// /*                            grouping-stmt / */
// /*                            data-def-stmt / */
// /*                            augment-stmt / */
// /*                            rpc-stmt / */
// /*                            notification-stmt / */
// /*                            deviation-stmt) */

// /*    data-def-stmt       = container-stmt / */
// /*                          leaf-stmt / */
// /*                          leaf-list-stmt / */
// /*                          list-stmt / */
// /*                          choice-stmt / */
// /*                          anydata-stmt / */
// /*                          anyxml-stmt / */
// /*                          uses-stmt */

// /*    yang-version-stmt   = yang-version-keyword sep yang-version-arg-str stmtend */
yang_version_stmt
: 'yang-version' string ';'                                 {}
;

// /*    yang-version-arg-str = < a string that matches the rule > < yang-version-arg > */
// /*    yang-version-arg    = "1.1" */

// /*    import-stmt         = import-keyword sep identifier-arg-str optsep */
// /*                          "{" stmtsep */
// /*                              prefix-stmt */
// /*                              [revision-date-stmt] */
// /*                          "}" stmtsep */
import_stmt
: 'import' 'IDENTIFIER' '{' prefix_stmt '}'                           {}
| 'import' 'IDENTIFIER' '{' prefix_stmt revision_date_stmt '}'        {}
;

// /*    include-stmt        = include-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               [revision-date-stmt] */
// /*                           "}") stmtsep */
include_stmt
: 'include' 'IDENTIFIER' ';'                                           {}
| 'include' 'IDENTIFIER' '{' '}'                                       {}
| 'include' 'IDENTIFIER' '{' revision_date_stmt '}'                    {}
;

// /*    namespace-stmt      = namespace-keyword sep uri-str stmtend */
namespace_stmt
: 'namespace' string ';'                                      {}
;

// /*    uri-str             = < a string that matches the rule > < URI in RFC 3986 > */

// /*    prefix-stmt         = prefix-keyword sep prefix-arg-str stmtend */
prefix_stmt
: 'prefix' 'IDENTIFIER' ';'                                            {}
;

// /*    belongs-to-stmt     = belongs-to-keyword sep identifier-arg-str optsep */
// /*                          "{" stmtsep */
// /*                              prefix-stmt */
// /*                          "}" stmtsep */
// belongs_to_stmt
// : BELONGS_TO_KW IDENTIFIER '{' prefix_stmt '}'                        { $$ = new Yang::Ast::BelongsTo($2, $4); }
// ;

// /*    organization-stmt   = organization-keyword sep string stmtend */
organization_stmt
: 'organization' string ';'                                    {}
;

// /*    contact-stmt        = contact-keyword sep string stmtend */
contact_stmt
: 'contact' string ';'                                         {}
;

// /*    description-stmt    = description-keyword sep string stmtend */
description_stmt
: 'description' string ';'                                     {}
;

// /*    reference-stmt      = reference-keyword sep string stmtend */
reference_stmt
: 'reference' string ';'                                       {}
;

// /*    units-stmt          = units-keyword sep string stmtend */
// units_stmt
// : 'units' string ';'                                           {}

// /*    revision-stmt       = revision-keyword sep revision-date optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                           "}") stmtsep */
revision_stmt
: 'revision' 'DATE' ';'                                             {}
| 'revision' 'DATE' '{' revision_body '}'                           {}
;

revision_body
: revision_body_stmt                                                {}
| revision_body revision_body_stmt                                  {}
;

revision_body_stmt
: description_stmt                                                   { $$ = $1; }
| reference_stmt                                                     { $$ = $1; }
| unknown_stmt                                                       { $$ = $1; } 
;

// /*    revision-date       = date-arg-str */
// /*    revision-date-stmt  = revision-date-keyword sep revision-date stmtend */
// revision_date_stmt
// : 'revision-date' 'DATE' ';'                                         {}
// ;

// /*    extension-stmt      = extension-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [argument-stmt] */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                           "}") stmtsep */
extension_stmt
: 'extension' 'IDENTIFIER' ';'                                       {}
| 'extension' 'IDENTIFIER' '{' extension_stmt_body '}'               {}   
;

extension_stmt_body
: extension_stmt_body_stmt                                          {}
| extension_stmt_body extension_stmt_body_stmt                      {}
;

extension_stmt_body_stmt
: argument_stmt                                                     { $$ = $1; }
| status_stmt                                                       { $$ = $1; }
| description_stmt                                                  { $$ = $1; }
| reference_stmt                                                    { $$ = $1; }
| unknown_stmt                                                      { $$ = $1; } 
;

// /*    argument-stmt       = argument-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               [yin-element-stmt] */
// /*                           "}") stmtsep */
argument_stmt
: 'argument' 'IDENTIFIER' ';'                                        {}
;

// /*    yin-element-stmt    = yin-element-keyword sep yin-element-arg-str */
// /*                          stmtend */

// /*    yin-element-arg-str = < a string that matches the rule > < yin-element-arg > */

// /*    yin-element-arg     = true-keyword / false-keyword */
// true_false_arg
// : 'true'                                                         {}
// | 'FALSE'                                                        {}
// ;

// /*    identity-stmt       = identity-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               *if-feature-stmt */
// /*                               *base-stmt */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                           "}") stmtsep */
identity_stmt
: 'identity' 'IDENTIFIER' ';'                                       {}
| 'identity' 'IDENTIFIER' '{' '}'                                   {}
| 'identity' 'IDENTIFIER' '{' identity_stmt_body '}'                {}
;

identity_stmt_body
: identity_stmt_body_stmt                                          {}
| identity_stmt_body identity_stmt_body_stmt                       {}
;

identity_stmt_body_stmt
: base_stmt                                                        { $$ = $1; }
| status_stmt                                                      { $$ = $1; }
| description_stmt                                                 { $$ = $1; }
| reference_stmt                                                   { $$ = $1; }
| unknown_stmt                                                       { $$ = $1; } 
;

// /*    base-stmt           = base-keyword sep identifier-ref-arg-str stmtend */
// base_stmt
// : 'base' identifier_ref ';'                                          {}
// ;

// /*    feature-stmt        = feature-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               *if-feature-stmt */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                           "}") stmtsep */
feature_stmt
: 'feature' 'IDENTIFIER' ';'                                         {}
| 'feature' 'IDENTIFIER' '{' '}'                                     {}
| 'feature' 'IDENTIFIER' '{' feature_stmt_body '}'                   {}
;

feature_stmt_body
: feature_stmt_body_stmt                                            {}
| feature_stmt_body feature_stmt_body_stmt                          {}
;
 
feature_stmt_body_stmt
: if_feature_stmt                                                   { $$ = $1; }
| status_stmt                                                       { $$ = $1; }
| description_stmt                                                  { $$ = $1; }
| reference_stmt                                                    { $$ = $1; }
| unknown_stmt                                                      { $$ = $1; } 
;

// /*    if-feature-stmt     = if-feature-keyword sep if-feature-expr-str stmtend */
if_feature_stmt
: 'if-feature' identifier_ref ';'                                  {} /* @todo implement complete grammar */
;

// /*    if-feature-expr-str = < a string that matches the rule > < if-feature-expr > */
// /*    if-feature-expr     = "(" if-feature-expr ")" / if-feature-expr sep boolean-operator sep if-feature-expr / not-keyword sep if-feature-expr / identifier-ref-arg */

// /*    boolean-operator = and-keyword / or-keyword */

// /*    typedef-stmt        = typedef-keyword sep identifier-arg-str optsep */
// /*                          "{" stmtsep */
// /*                              ;; these stmts can appear in any order */
// /*                              type-stmt */
// /*                              [units-stmt] */
// /*                              [default-stmt] */
// /*                              [status-stmt] */
// /*                              [description-stmt] */
// /*                              [reference-stmt] */
// /*                           "}" stmtsep */
typedef_stmt
: 'typedef' 'IDENTIFIER' '{' typedef_stmt_body '}'                   {}
;

typedef_stmt_body
: typedef_stmt_body_stmt                                             {}
| typedef_stmt_body typedef_stmt_body_stmt                           {}
;

typedef_stmt_body_stmt
: type_stmt                                                          { $$ = $1; }
| units_stmt                                                         { $$ = $1; }
| default_stmt                                                       { $$ = $1; }
| status_stmt                                                        { $$ = $1; }
| description_stmt                                                   { $$ = $1; }
| reference_stmt                                                     { $$ = $1; }
| unknown_stmt                                                       { $$ = $1; } 
;

// /*    type-stmt           = type-keyword sep identifier-ref-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               [type-body-stmts] */
// /*                           "}") stmtsep */
// type_stmt
// : 'type' identifier_ref ';'                                          {}
// | 'type' identifier_ref '{' '}'                                      {}
// | 'type' identifier_ref '{' type_body_stmts '}'                      {}
// ;

// /*    type-body-stmts     = numerical-restrictions / */
// /*                          decimal64-specification / */
// /*                          string-restrictions / */
// /*                          enum-specification / */
// /*                          leafref-specification / */
// /*                          identityref-specification / */
// /*                          instance-identifier-specification / */
// /*                          bits-specification / */
// /*                          union-specification / */
// /*                          binary-specification */
// type_body_stmts
// : type_body_stmt                                                      {} 
// | type_body_stmts type_body_stmt                                      {}
// ;

// type_body_stmt
// : range_stmt                                                          { $$ = $1; } /* numerical_restrictions, decimal64_specification */
// | fraction_digits_stmt                                                { $$ = $1; } /* decimal64_specification */
// | length_stmt                                                         { $$ = $1; } /* string_restrictions, binary-specification */
// | pattern_stmt                                                        { $$ = $1; } /* string_restrictions */
// | enum_specification                                                  { $$ = $1; }
// | path_stmt                                                           { $$ = $1; } /* leafref_specification */
// | require_instance_stmt                                               { $$ = $1; } /* leafref_specification, instance-identifier-specification */
// | base_stmt                                                           { $$ = $1; } /* identityref-specification */
// | bit_stmt                                                            { $$ = $1; } /* bits-specification */
// | type_stmt                                                           { $$ = $1; } /* union-specification */    
// | unknown_stmt                                                        { $$ = $1; } 
// ;

// /*    numerical-restrictions = range-stmt */

// /*    range-stmt          = range-keyword sep range-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [error-message-stmt] */
// /*                               [error-app-tag-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                            "}") stmtsep */
// range_stmt
// : 'range' range_arg  ';'                                               {}
// ;                          

// /*    decimal64-specification = ;; these stmts can appear in any order */
// /*                              fraction-digits-stmt */
// /*                              [range-stmt] */

// /*    fraction-digits-stmt = fraction-digits-keyword sep fraction-digits-arg-str stmtend */
// fraction_digits_stmt
// : 'fraction-digits' 'INTEGER' ';'                                       {} 
// ;
// /*    fraction-digits-arg-str = < a string that matches the rule > < fraction-digits-arg > */
// /*    fraction-digits-arg = ("1" ["0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8"]) / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9" */

// /*    string-restrictions = ;; these stmts can appear in any order */
// /*                          [length-stmt] */
// /*                          *pattern-stmt */

// /*    length-stmt         = length-keyword sep length-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [error-message-stmt] */
// /*                               [error-app-tag-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                            "}") stmtsep */
// length_stmt
// : 'length' length_arg ';'                                             {}
// | 'length' length_arg '{' length_body_stmts '}'                       {}
// ;

// length_body_stmts
// : length_body_stmt                                                    {}
// | length_body_stmts length_body_stmt                                  {}
// ;

// length_body_stmt
// : error_message_stmt                                                  { $$ = $1; }
// | error_app_tag_stmt                                                  { $$ = $1; }
// | description_stmt                                                    { $$ = $1; }
// | reference_stmt                                                      { $$ = $1; }
// | unknown_stmt                                                        { $$ = $1; } 
// ;

// /*    pattern-stmt        = pattern-keyword sep string optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [modifier-stmt] */
// /*                               [error-message-stmt] */
// /*                               [error-app-tag-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                            "}") stmtsep */
// pattern_stmt
// : 'pattern' string ';'                                                {}
// | 'pattern' string '{' pattern_stmt_body '}' ';'                      {}
// ;

// pattern_stmt_body
// : pattern_stmt_body_stmt                                              {}
// | pattern_stmt_body pattern_stmt_body_stmt                            {}
// ;

// pattern_stmt_body_stmt
// : modifier_stmt                                                       { $$ = $1; }
// | error_message_stmt                                                  { $$ = $1; }
// | error_app_tag_stmt                                                  { $$ = $1; }
// | description_stmt                                                    { $$ = $1; }
// | reference_stmt                                                      { $$ = $1; }
// | unknown_stmt                                                        { $$ = $1; } 
// ;

// /*    modifier-stmt       = modifier-keyword sep modifier-arg-str stmtend */
// /*    modifier-arg-str    = < a string that matches the rule > < modifier-arg > */
// /*    modifier-arg        = invert-match-keyword */
// modifier_stmt
// : 'modifier' 'invert-match'                                         {}
// ;
// /*    default-stmt        = default-keyword sep string stmtend */
// default_stmt
// : 'default' string ';'                                        {}
// ;

// /*    enum-specification  = 1*enum-stmt */
// /*    enum-stmt           = enum-keyword sep string optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               *if-feature-stmt */
// /*                               [value-stmt] */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                            "}") stmtsep */
// enum_specification
// : 'enum' string ';'                                     { $$ = new Yang::Ast::EnumSpec($2); }
// | 'enum' string '{' enum_specification_body '}'          {}
// ;

// enum_specification_body
// : enum_specification_body_stmt                            {}
// | enum_specification_body enum_specification_body_stmt    {}
// ;

// enum_specification_body_stmt
// : if_feature_stmt                                         { $$ = $1; }
// | value_stmt                                              { $$ = $1; }
// | status_stmt                                             { $$ = $1; }
// | description_stmt                                        { $$ = $1; }
// | reference_stmt                                          { $$ = $1; }
// | unknown_stmt                                            { $$ = $1; } 
// ;

// /*    leafref-specification = */
// /*                          ;; these stmts can appear in any order */
// /*                          path-stmt */
// /*                          [require-instance-stmt] */

// /*    path-stmt           = path-keyword sep path-arg-str stmtend */
// path_stmt
// : 'path' string                                               {}
// ;

// /*    require-instance-stmt = require-instance-keyword sep require-instance-arg-str stmtend */
// require_instance_stmt
// : 'require-instance' true_false_arg                            {}
// ;

// /*    require-instance-arg-str = < a string that matches the rule > < require-instance-arg > */
// /*    require-instance-arg = true-keyword / false-keyword */

// /*    instance-identifier-specification = [require-instance-stmt] */

// /*    identityref-specification = 1*base-stmt */

// /*    union-specification = 1*type-stmt */

// /*    binary-specification = [length-stmt] */

// /*    bits-specification  = 1*bit-stmt */
// /*    bit-stmt            = bit-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               *if-feature-stmt */
// /*                               [position-stmt] */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                           "}") stmtsep */
// bit_stmt
// : 'bit' 'IDENTIFIER' ';'                                               {}
// | 'bit' 'IDENTIFIER' '{' bit_body '}'                                   {}
// ;

// bit_body
// : bit_body_stmt                                                       { $$ = new Yang::Ast::Nodes(1, $1); }
// | bit_body bit_body_stmt                                              { $1->push_back($2); $$ = $1; }
// ;

// bit_body_stmt
// : if_feature_stmt                                                     { $$ = $1; }
// | position_stmt                                                       { $$ = $1; }
// | status_stmt                                                         { $$ = $1; }
// | description_stmt                                                    { $$ = $1; }
// | reference_stmt                                                      { $$ = $1; }
// | unknown_stmt                                                        { $$ = $1; } 
// ;

// /*    position-stmt       = position-keyword sep position-value-arg-str stmtend */
// position_stmt
// : 'position' 'INTEGER' ';'                                              {}
// ;
// /*    position-value-arg-str = < a string that matches the rule > < position-value-arg > */
// /*    position-value-arg  = non-negative-integer-value */

// /*    status-stmt         = status-keyword sep status-arg-str stmtend */
// status_stmt
// : 'status' status_arg ';'                                           {}
// ;

// /*    status-arg-str      = < a string that matches the rule > */
// /*                          < status-arg > */

// /*    status-arg          = current-keyword / */
// /*                          obsolete-keyword / */
// /*                          deprecated-keyword */
// status_arg
// : 'current'                                                         {} /* @todo these should be enums */
// | 'obsolete'                                                        {}
// | 'deprecated'                                                      {}
// ;

// /*    config-stmt         = config-keyword sep config-arg-str stmtend */
// config_stmt
// : CONFIG_KW true_false_arg ';'                                           { $$ = new Yang::Ast::Config($2); }

// /*    config-arg-str      = < a string that matches the rule > < config-arg > */
// /*    config-arg          = true-keyword / false-keyword */

// /*    mandatory-stmt      = mandatory-keyword sep mandatory-arg-str stmtend */
// mandatory_stmt
// : 'mandatory' true_false_arg ';'                                         {}

// /*    mandatory-arg-str   = < a string that matches the rule > < mandatory-arg > */
// /*    mandatory-arg       = true-keyword / false-keyword */

// /*    presence-stmt       = presence-keyword sep string stmtend */
// presence_stmt
// : 'presence' string ';'                                           {}

// /*    ordered-by-stmt     = ordered-by-keyword sep ordered-by-arg-str stmtend */
// /*    ordered-by-arg-str  = < a string that matches the rule > < ordered-by-arg > */
// /*    ordered-by-arg      = user-keyword / system-keyword */
// ordered_by_stmt
// : 'ordered-by' 'user' ';'                                                {}
// | 'ordered-by' 'system' ';'                                             {}
// ;

// /*    must-stmt           = must-keyword sep string optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [error-message-stmt] */
// /*                               [error-app-tag-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                            "}") stmtsep */
// must_stmt
// : 'must' string ';'                                              {}
// | 'must' string '{' must_stmt_body '}'                            {}
// ;

// must_stmt_body
// : must_stmt_body_stmt                                               {}
// | must_stmt_body must_stmt_body_stmt                                {}
// ;

// must_stmt_body_stmt
// : error_message_stmt                                                { $$ = $1; }
// | error_app_tag_stmt                                                { $$ = $1; }
// | description_stmt                                                  { $$ = $1; }
// | reference_stmt                                                    { $$ = $1; }
// | unknown_stmt                                                       { $$ = $1; } 
// ;

// /*    error-message-stmt  = error-message-keyword sep string stmtend */
// error_message_stmt
// : 'error_message' string ';'                                  {}
// ;

// /*    error-app-tag-stmt  = error-app-tag-keyword sep string stmtend */
// error_app_tag_stmt
// : 'error-app-tag' string ';'                                  {}
// ;

// /*    min-elements-stmt   = min-elements-keyword sep min-value-arg-str stmtend */
// /*    min-value-arg-str   = < a string that matches the rule > < min-value-arg > */
// /*    min-value-arg       = non-negative-integer-value */
// min_elements_stmt
// : 'min-elements' 'INTEGER' ';'                                 {} /* @todo check non negative int */
// ;


// /*    max-elements-stmt   = max-elements-keyword sep max-value-arg-str stmtend */
// /*    max-value-arg-str   = < a string that matches the rule > < max-value-arg > */
// /*    max-value-arg       = unbounded-keyword / positive-integer-value */
// max_elements_stmt
// : 'max-elements' 'INTEGER' ';'                                 {} /* @todo check non negative int and add unbounded keyword */
// ;

// /*    value-stmt          = value-keyword sep integer-value-str stmtend */
// value_stmt
// : 'VALUE' 'INTEGER' ';'                                        {}
// ;

// /*    integer-value-str   = < a string that matches the rule > < integer-value > */

// /*    grouping-stmt       = grouping-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                               *(typedef-stmt / grouping-stmt) */
// /*                               *data-def-stmt */
// /*                               *action-stmt */
// /*                               *notification-stmt */
// /*                           "}") stmtsep */
grouping_stmt
: 'grouping' 'IDENTIFIER' ';'                                          {}
| 'grouping' 'IDENTIFIER' '{' grouping_stmt_body '}'                   {}
;

grouping_stmt_body
: grouping_stmt_body_stmt                                             {}
| grouping_stmt_body grouping_stmt_body_stmt                          {}
;

grouping_stmt_body_stmt
: status_stmt                                                         { $$ = $1; }       
| description_stmt                                                    { $$ = $1; }
| reference_stmt                                                      { $$ = $1; }
| typedef_stmt                                                        { $$ = $1; }
| grouping_stmt                                                       { $$ = $1; }
| container_stmt                                                      { $$ = $1; } /* data-def-stmt */
| leaf_stmt                                                           { $$ = $1; }
| leaf_list_stmt                                                      { $$ = $1; }
| list_stmt                                                           { $$ = $1; }
| anydata_stmt                                                        { $$ = $1; }
| anyxml_stmt                                                         { $$ = $1; }
| choice_stmt                                                         { $$ = $1; }
| uses_stmt                                                           { $$ = $1; }
| action_stmt                                                         { $$ = $1; }
| notification_stmt                                                   { $$ = $1; }
| unknown_stmt                                                        { $$ = $1; } 
;

// /*    container-stmt      = container-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [when-stmt] */
// /*                               *if-feature-stmt */
// /*                               *must-stmt */
// /*                               [presence-stmt] */
// /*                               [config-stmt] */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                               *(typedef-stmt / grouping-stmt) */
// /*                               *data-def-stmt */
// /*                               *action-stmt */
// /*                               *notification-stmt */
// /*                           "}") stmtsep */
container_stmt
: 'container' 'IDENTIFIER' ';'                                           {}
| 'container' 'IDENTIFIER' '{' container_stmt_body '}'                   {}
;

container_stmt_body
: container_stmt_body_stmt                                              {}
| container_stmt_body container_stmt_body_stmt                          {}
;

container_stmt_body_stmt
: when_stmt                                                             { $$ = $1; }
| if_feature_stmt                                                       { $$ = $1; }
| must_stmt                                                             { $$ = $1; }
| presence_stmt                                                         { $$ = $1; }
| config_stmt                                                           { $$ = $1; }
| status_stmt                                                           { $$ = $1; }
| description_stmt                                                      { $$ = $1; }
| reference_stmt                                                        { $$ = $1; }
| typedef_stmt                                                          { $$ = $1; }
| grouping_stmt                                                         { $$ = $1; }
| container_stmt                                                        { $$ = $1; } /* *data-def-stmt */
| leaf_stmt                                                             { $$ = $1; }
| leaf_list_stmt                                                        { $$ = $1; }
| list_stmt                                                             { $$ = $1; }
| anydata_stmt                                                          { $$ = $1; }
| anyxml_stmt                                                           { $$ = $1; }
| choice_stmt                                                           { $$ = $1; }
| uses_stmt                                                             { $$ = $1; }
| action_stmt                                                           { $$ = $1; }
| notification_stmt                                                     { $$ = $1; }
| unknown_stmt                                                          { $$ = $1; }
;

// /*    leaf-stmt           = leaf-keyword sep identifier-arg-str optsep */
// /*                          "{" stmtsep */
// /*                              ;; these stmts can appear in any order */
// /*                              [when-stmt] */
// /*                              *if-feature-stmt */
// /*                              type-stmt */
// /*                              [units-stmt] */
// /*                              *must-stmt */
// /*                              [default-stmt] */
// /*                              [config-stmt] */
// /*                              [mandatory-stmt] */
// /*                              [status-stmt] */
// /*                              [description-stmt] */
// /*                              [reference-stmt] */
// /*                           "}" stmtsep */
leaf_stmt
: 'LEAF' 'IDENTIFIER' '{' leaf_stmt_body '}'                             {}
;

leaf_stmt_body
: leaf_stmt_body_stmt                                                   {}
| leaf_stmt_body leaf_stmt_body_stmt                                    {}
;

leaf_stmt_body_stmt
: when_stmt                                                             { $$ = $1; }
| if_feature_stmt                                                       { $$ = $1; }
| type_stmt                                                             { $$ = $1; }
| units_stmt                                                            { $$ = $1; }
| must_stmt                                                             { $$ = $1; }
| default_stmt                                                          { $$ = $1; }
| config_stmt                                                           { $$ = $1; }
| mandatory_stmt                                                        { $$ = $1; }
| status_stmt                                                           { $$ = $1; }
| description_stmt                                                      { $$ = $1; }
| reference_stmt                                                        { $$ = $1; }
| unknown_stmt                                                          { $$ = $1; } 
;

// /*    leaf-list-stmt      = leaf-list-keyword sep identifier-arg-str optsep */
// /*                          "{" stmtsep */
// /*                              ;; these stmts can appear in any order */
// /*                              [when-stmt] */
// /*                              *if-feature-stmt */
// /*                              type-stmt stmtsep */
// /*                              [units-stmt] */
// /*                              *must-stmt */
// /*                              *default-stmt */
// /*                              [config-stmt] */
// /*                              [min-elements-stmt] */
// /*                              [max-elements-stmt] */
// /*                              [ordered-by-stmt] */
// /*                              [status-stmt] */
// /*                              [description-stmt] */
// /*                              [reference-stmt] */
// /*                           "}" stmtsep */
leaf_list_stmt
: 'leaf-list' 'IDENTIFIER' '{' leaf_list_stmt_body '}'                   {}
;

leaf_list_stmt_body
: leaf_list_stmt_body_stmt                                               {}
| leaf_list_stmt_body leaf_list_stmt_body_stmt                           {}
;

leaf_list_stmt_body_stmt
: when_stmt                                                              { $$ = $1; }
| if_feature_stmt                                                        { $$ = $1; }
| type_stmt                                                              { $$ = $1; }
| units_stmt                                                             { $$ = $1; }
| must_stmt                                                              { $$ = $1; }
| default_stmt                                                           { $$ = $1; }
| config_stmt                                                            { $$ = $1; }
| min_elements_stmt                                                      { $$ = $1; }
| max_elements_stmt                                                      { $$ = $1; }
| ordered_by_stmt                                                        { $$ = $1; }
| status_stmt                                                            { $$ = $1; }
| description_stmt                                                       { $$ = $1; }
| reference_stmt                                                         { $$ = $1; }
| unknown_stmt                                                           { $$ = $1; } 
;

// /*    list-stmt           = list-keyword sep identifier-arg-str optsep */
// /*                          "{" stmtsep */
// /*                              ;; these stmts can appear in any order */
// /*                              [when-stmt] */
// /*                              *if-feature-stmt */
// /*                              *must-stmt */
// /*                              [key-stmt] */
// /*                              *unique-stmt */
// /*                              [config-stmt] */
// /*                              [min-elements-stmt] */
// /*                              [max-elements-stmt] */
// /*                              [ordered-by-stmt] */
// /*                              [status-stmt] */
// /*                              [description-stmt] */
// /*                              [reference-stmt] */
// /*                              *(typedef-stmt / grouping-stmt) */
// /*                              1*data-def-stmt */
// /*                              *action-stmt */
// /*                              *notification-stmt */
// /*                           "}" stmtsep */
list_stmt
: 'list' 'IDENTIFIER' '{' list_stmt_body '}'                               {}
;

list_stmt_body
: list_stmt_body_stmt                                                     {}
| list_stmt_body list_stmt_body_stmt                                      {}
;

list_stmt_body_stmt
: when_stmt                                                               { $$ = $1; }
| if_feature_stmt                                                         { $$ = $1; }
| must_stmt                                                               { $$ = $1; }
| key_stmt                                                                { $$ = $1; }
| unique_stmt                                                             { $$ = $1; }
| config_stmt                                                             { $$ = $1; }
| min_elements_stmt                                                       { $$ = $1; }
| max_elements_stmt                                                       { $$ = $1; }
| ordered_by_stmt                                                         { $$ = $1; }
| status_stmt                                                             { $$ = $1; }
| description_stmt                                                        { $$ = $1; }
| reference_stmt                                                          { $$ = $1; }
| typedef_stmt                                                            { $$ = $1; }
| grouping_stmt                                                           { $$ = $1; }
| container_stmt                                                          { $$ = $1; } /* data-def-stmt */
| leaf_stmt                                                               { $$ = $1; }
| leaf_list_stmt                                                           { $$ = $1; }
| list_stmt                                                                { $$ = $1; }
| anydata_stmt                                                             { $$ = $1; }
| anyxml_stmt                                                              { $$ = $1; }
| choice_stmt                                                              { $$ = $1; }
| uses_stmt                                                                { $$ = $1; }
| action_stmt                                                              { $$ = $1; }
| notification_stmt                                                        { $$ = $1; }
| unknown_stmt                                                             { $$ = $1; } 
;

// /*    key-stmt            = key-keyword sep key-arg-str stmtend */
// key_stmt
// : 'key' key_arg ';'                                {}
// ;

// /*    key-arg-str         = < a string that matches the rule > < key-arg > */
// /*    key-arg             = node-identifier *(sep node-identifier) */
// key_arg
// : node_identifier                               {}
// | key_arg node_identifier                       {}
// ;

// /*    unique-stmt         = unique-keyword sep unique-arg-str stmtend */
// /*    unique-arg-str      = < a string that matches the rule > < unique-arg > */
// /*    unique-arg          = descendant-schema-nodeid *(sep descendant-schema-nodeid) */
// unique_stmt
// : 'unique' unique_arg ';'                         {}
// ; 

// unique_arg
// : descendant_schema_nodeid                        {}
// | unique_arg descendant_schema_nodeid             {}

// /*    choice-stmt         = choice-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [when-stmt] */
// /*                               *if-feature-stmt */
// /*                               [default-stmt] */
// /*                               [config-stmt] */
// /*                               [mandatory-stmt] */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                               *(short-case-stmt / case-stmt) */
// /*                           "}") stmtsep */
choice_stmt
: 'choice' 'IDENTIFIER' ';'                      {}
| 'choice' 'IDENTIFIER' '{' choice_body '}'      {}
;

choice_body
: choice_body_stmt                              {}
| choice_body choice_body_stmt                  {}
;

choice_body_stmt
: when_stmt                                     { $$ = $1; }
| if_feature_stmt                               { $$ = $1; }
| default_stmt                                  { $$ = $1; }
| config_stmt                                   { $$ = $1; }
| mandatory_stmt                                { $$ = $1; }
| status_stmt                                   { $$ = $1; }
| description_stmt                              { $$ = $1; }
| reference_stmt                                { $$ = $1; }
| choice_stmt                                   { $$ = $1; } /* short-case-stmt */
| container_stmt                                { $$ = $1; }
| leaf_stmt                                     { $$ = $1; }
| leaf_list_stmt                                { $$ = $1; }
| list_stmt                                     { $$ = $1; }
| anydata_stmt                                  { $$ = $1; }
| anyxml_stmt                                   { $$ = $1; }
| case_stmt                                     { $$ = $1; }
| unknown_stmt                                  { $$ = $1; } 
;

// /*    short-case-stmt     = choice-stmt / */
// /*                          container-stmt / */
// /*                          leaf-stmt / */
// /*                          leaf-list-stmt / */
// /*                          list-stmt / */
// /*                          anydata-stmt / */
// /*                          anyxml-stmt */

// /*    case-stmt           = case-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [when-stmt] */
// /*                               *if-feature-stmt */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                               *data-def-stmt */
// /*                           "}") stmtsep */
case_stmt
: 'case' 'IDENTIFIER' ';'                          {}
| 'case' 'IDENTIFIER' '{' case_stmt_body '}'       {}
;

case_stmt_body
: case_stmt_body_stmt                             {}
| case_stmt_body case_stmt_body_stmt              {}
;

case_stmt_body_stmt
: when_stmt                                       { $$ = $1; }
| if_feature_stmt                                 { $$ = $1; }
| status_stmt                                     { $$ = $1; }
| description_stmt                                { $$ = $1; }
| reference_stmt                                  { $$ = $1; }
| choice_stmt                                     { $$ = $1; } /* data-def-stmt */
| container_stmt                                  { $$ = $1; }
| leaf_stmt                                       { $$ = $1; }
| leaf_list_stmt                                  { $$ = $1; }
| list_stmt                                       { $$ = $1; }
| anydata_stmt                                    { $$ = $1; }
| anyxml_stmt                                     { $$ = $1; }
| unknown_stmt                                    { $$ = $1; } 
;

// /*    anydata-stmt        = anydata-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [when-stmt] */
// /*                               *if-feature-stmt */
// /*                               *must-stmt */
// /*                               [config-stmt] */
// /*                               [mandatory-stmt] */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                            "}") stmtsep */
anydata_stmt
: 'anydata' 'IDENTIFIER' ';'                               {}
| 'anydata' 'IDENTIFIER' '{' anydata_anyxml_stmt_body '}'  {}
;

anydata_anyxml_stmt_body
: anydata_anyxml_stmt_body_stmt                           {}
| anydata_anyxml_stmt_body anydata_anyxml_stmt_body_stmt  {}
;

anydata_anyxml_stmt_body_stmt
: when_stmt                                               { $$ = $1; }
| if_feature_stmt                                         { $$ = $1; }
| must_stmt                                               { $$ = $1; }
| config_stmt                                             { $$ = $1; }
| mandatory_stmt                                          { $$ = $1; }
| status_stmt                                             { $$ = $1; }
| description_stmt                                        { $$ = $1; }
| reference_stmt                                          { $$ = $1; }
| unknown_stmt                                            { $$ = $1; } 
;  

// /*    anyxml-stmt         = anyxml-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [when-stmt] */
// /*                               *if-feature-stmt */
// /*                               *must-stmt */
// /*                               [config-stmt] */
// /*                               [mandatory-stmt] */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                            "}") stmtsep */
anyxml_stmt
: 'anyxml' 'IDENTIFIER' ';'                               {}
| 'anyxml' 'IDENTIFIER' '{' anydata_anyxml_stmt_body '}'  {}
;

// /*    uses-stmt           = uses-keyword sep identifier-ref-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [when-stmt] */
// /*                               *if-feature-stmt */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                               *refine-stmt */
// /*                               *uses-augment-stmt */
// /*                           "}") stmtsep */
uses_stmt
: 'uses' identifier_ref ';'                    { $$ = new Yang::Ast::Uses($2); }
| 'uses' identifier_ref '{' uses_stmt_body '}' { $$ = new Yang::Ast::Uses($2, $4); }
;

uses_stmt_body
: uses_stmt_body_stmt                           { $$ = new Yang::Ast::Nodes(1, $1); }
| uses_stmt_body uses_stmt_body_stmt            { $1->push_back($2); $$ = $1; }
;

uses_stmt_body_stmt
: when_stmt                                     { $$ = $1; }
| if_feature_stmt                               { $$ = $1; }
| status_stmt                                   { $$ = $1; }
| description_stmt                              { $$ = $1; }
| reference_stmt                                { $$ = $1; }
/* | refine_stmt */
/* | uses_augment_stmt */
| unknown_stmt                                  { $$ = $1; } 
;

// /*    refine-stmt         = refine-keyword sep refine-arg-str optsep */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               *if-feature-stmt */
// /*                               *must-stmt */
// /*                               [presence-stmt] */
// /*                               [default-stmt] */
// /*                               [config-stmt] */
// /*                               [mandatory-stmt] */
// /*                               [min-elements-stmt] */
// /*                               [max-elements-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                             "}" stmtsep */

// /*    refine-arg-str      = < a string that matches the rule > */
// /*                          < refine-arg > */

// /*    refine-arg          = descendant-schema-nodeid */

// /*    uses-augment-stmt   = augment-keyword sep uses-augment-arg-str optsep */
// /*                          "{" stmtsep */
// /*                              ;; these stmts can appear in any order */
// /*                              [when-stmt] */
// /*                              *if-feature-stmt */
// /*                              [status-stmt] */
// /*                              [description-stmt] */
// /*                              [reference-stmt] */
// /*                              1*(data-def-stmt / case-stmt / */
// /*                                 action-stmt / notification-stmt) */
// /*                           "}" stmtsep */

// /*    uses-augment-arg-str = < a string that matches the rule > */
// /*                           < uses-augment-arg > */

// /*    uses-augment-arg    = descendant-schema-nodeid */

// /*    augment-stmt        = augment-keyword sep augment-arg-str optsep */
// /*                          "{" stmtsep */
// /*                              ;; these stmts can appear in any order */
// /*                              [when-stmt] */
// /*                              *if-feature-stmt */
// /*                              [status-stmt] */
// /*                              [description-stmt] */
// /*                              [reference-stmt] */
// /*                              1*(data-def-stmt / case-stmt / */
// /*                                 action-stmt / notification-stmt) */
// /*                           "}" stmtsep */
augment_stmt
: 'AUGMENT' absolute_schema_nodeid '{' augment_body '}'        {}
;

augment_body
: augment_body_stmt                                            {}
| augment_body augment_body_stmt                               {}
;

augment_body_stmt
: when_stmt                                                    { $$ = $1; }
| if_feature_stmt                                              { $$ = $1; }
| status_stmt                                                  { $$ = $1; }
| description_stmt                                             { $$ = $1; }
| reference_stmt                                               { $$ = $1; }
| case_stmt                                                    { $$ = $1; }
| container_stmt                                               { $$ = $1; } /* data-def-stmt */
| leaf_stmt                                                    { $$ = $1; }
| leaf_list_stmt                                               { $$ = $1; }
| list_stmt                                                    { $$ = $1; }
| anydata_stmt                                                 { $$ = $1; }
| anyxml_stmt                                                  { $$ = $1; }
| choice_stmt                                                  { $$ = $1; }
| uses_stmt                                                    { $$ = $1; }
| action_stmt                                                  { $$ = $1; }
| notification_stmt                                            { $$ = $1; } 
| unknown_stmt                                                 { $$ = $1; } 
;


// /*    augment-arg-str     = < a string that matches the rule > */
// /*                          < augment-arg > */

// /*    augment-arg         = absolute-schema-nodeid */

// /*    when-stmt           = when-keyword sep string optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                            "}") stmtsep */
// when_stmt
// : 'when' string ';'                      {}
// | 'when' string '{' when_stmt_body '}'   {}
// ;

// when_stmt_body
// : when_stmt_body_stmt                           {}
// | when_stmt_body when_stmt_body_stmt            {}
// ;

// when_stmt_body_stmt
// : description_stmt                              { $$ = $1; }
// | reference_stmt                                { $$ = $1; }
// | unknown_stmt                                  { $$ = $1; } 
// ;

// /*    rpc-stmt            = rpc-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               *if-feature-stmt */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                               *(typedef-stmt / grouping-stmt) */
// /*                               [input-stmt] */
// /*                               [output-stmt] */
// /*                           "}") stmtsep */
rpc_stmt
: 'rpc' 'IDENTIFIER' ';'                           {}
| 'rpc' 'IDENTIFIER' '{' rpc_action_stmt_body '}'  {}
;

rpc_action_stmt_body
: rpc_action_stmt_body_stmt                       {}
| rpc_action_stmt_body rpc_action_stmt_body_stmt  {}
;

rpc_action_stmt_body_stmt
: if_feature_stmt                                 { $$ = $1; }
| status_stmt                                     { $$ = $1; }
| description_stmt                                { $$ = $1; }
| reference_stmt                                  { $$ = $1; }
| typedef_stmt                                    { $$ = $1; }
| grouping_stmt                                   { $$ = $1; }
| input_stmt                                      { $$ = $1; }
| output_stmt                                     { $$ = $1; }
| unknown_stmt                                    { $$ = $1; } 
;

// /*    action-stmt         = action-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               *if-feature-stmt */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                               *(typedef-stmt / grouping-stmt) */
// /*                               [input-stmt] */
// /*                               [output-stmt] */
// /*                           "}") stmtsep */

// action_stmt
// : 'action 'IDENTIFIER' ';'                              {}
// | 'action' 'IDENTIFIER' '{' rpc_action_stmt_body '}'    {}
// ;


// /*    input-stmt          = input-keyword optsep */
// /*                          "{" stmtsep */
// /*                              ;; these stmts can appear in any order */
// /*                              *must-stmt */
// /*                              *(typedef-stmt / grouping-stmt) */
// /*                              1*data-def-stmt */
// /*                          "}" stmtsep */
// input_stmt
// : 'input' '{' input_output_stmt_body '}'                 {}
// ;

// input_output_stmt_body
// : input_output_stmt_body_stmt                            {}
// | input_output_stmt_body input_output_stmt_body_stmt   {}
// ;

// input_output_stmt_body_stmt
// : must_stmt                                            { $$ = $1; }
// | typedef_stmt                                         { $$ = $1; }
// | grouping_stmt                                        { $$ = $1; }
// | container_stmt                                       { $$ = $1; } /* data-def-stmt */
// | leaf_stmt                                            { $$ = $1; }
// | leaf_list_stmt                                       { $$ = $1; }
// | list_stmt                                            { $$ = $1; }
// | anydata_stmt                                         { $$ = $1; }
// | anyxml_stmt                                          { $$ = $1; }
// | choice_stmt                                          { $$ = $1; }
// | uses_stmt                                            { $$ = $1; }
// | unknown_stmt                                              { $$ = $1; } 
// ;

// /*    output-stmt         = output-keyword optsep */
// /*                          "{" stmtsep */
// /*                              ;; these stmts can appear in any order */
// /*                              *must-stmt */
// /*                              *(typedef-stmt / grouping-stmt) */
// /*                              1*data-def-stmt */
// /*                          "}" stmtsep */
// output_stmt
// : 'output' '{' input_output_stmt_body '}'                    {}
// ;

// /*    notification-stmt   = notification-keyword sep identifier-arg-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               *if-feature-stmt */
// /*                               *must-stmt */
// /*                               [status-stmt] */
// /*                               [description-stmt] */
// /*                               [reference-stmt] */
// /*                               *(typedef-stmt / grouping-stmt) */
// /*                               *data-def-stmt */
// /*                           "}") stmtsep */
notification_stmt
: 'notification' 'IDENTIFIER' ';'                             {}
| 'notification' 'IDENTIFIER' '{' notification_stmt_body '}'  {}
;

notification_stmt_body
: notification_stmt_body_stmt                                 {}
| notification_stmt_body notification_stmt_body_stmt          {}
;

notification_stmt_body_stmt
: if_feature_stmt                                             { $$ = $1; }
| must_stmt                                                   { $$ = $1; }
| status_stmt                                                 { $$ = $1; }
| description_stmt                                            { $$ = $1; }
| reference_stmt                                              { $$ = $1; }
| typedef_stmt                                                { $$ = $1; }
| grouping_stmt                                               { $$ = $1; }
| container_stmt                                              { $$ = $1; } /* data-def-stmt */
| leaf_stmt                                                   { $$ = $1; }
| leaf_list_stmt                                              { $$ = $1; }
| list_stmt                                                   { $$ = $1; }
| anydata_stmt                                                { $$ = $1; }
| anyxml_stmt                                                 { $$ = $1; }
| choice_stmt                                                 { $$ = $1; }
| uses_stmt                                                   { $$ = $1; }
| unknown_stmt                                                { $$ = $1; } 
;

// /*    deviation-stmt      = deviation-keyword sep deviation-arg-str optsep */
// /*                          "{" stmtsep */
// /*                              ;; these stmts can appear in any order */
// /*                              [description-stmt] */
// /*                              [reference-stmt] */
// /*                              (deviate-not-supported-stmt / */
// /*                                1*(deviate-add-stmt / */
// /*                                   deviate-replace-stmt / */
// /*                                   deviate-delete-stmt)) */
// /*                          "}" stmtsep */

// /*    deviation-arg-str   = < a string that matches the rule > */
// /*                          < deviation-arg > */

// /*    deviation-arg       = absolute-schema-nodeid */

// /*    deviate-not-supported-stmt = */
// /*                          deviate-keyword sep */
// /*                          not-supported-keyword-str stmtend */

// /*    deviate-add-stmt    = deviate-keyword sep add-keyword-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [units-stmt] */
// /*                               *must-stmt */
// /*                               *unique-stmt */
// /*                               [default-stmt] */
// /*                               [config-stmt] */
// /*                               [mandatory-stmt] */
// /*                               [min-elements-stmt] */
// /*                               [max-elements-stmt] */
// /*                           "}") stmtsep */

// /*    deviate-delete-stmt = deviate-keyword sep delete-keyword-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [units-stmt] */
// /*                               *must-stmt */
// /*                               *unique-stmt */
// /*                               [default-stmt] */
// /*                           "}") stmtsep */

// /*    deviate-replace-stmt = deviate-keyword sep replace-keyword-str optsep */
// /*                          (";" / */
// /*                           "{" stmtsep */
// /*                               ;; these stmts can appear in any order */
// /*                               [type-stmt] */
// /*                               [units-stmt] */
// /*                               [default-stmt] */
// /*                               [config-stmt] */
// /*                               [mandatory-stmt] */
// /*                               [min-elements-stmt] */
// /*                               [max-elements-stmt] */
// /*                           "}") stmtsep */

// /*    not-supported-keyword-str = < a string that matches the rule > < not-supported-keyword > */
// /*    add-keyword-str     = < a string that matches the rule > < add-keyword > */
// /*    delete-keyword-str  = < a string that matches the rule > < delete-keyword >
// /*    replace-keyword-str = < a string that matches the rule > < replace-keyword > */

// /*    ;; represents the usage of an extension statement */
// /*    unknown-statement   = prefix ":" identifier [sep string] optsep */
// /*                          (";" / */
// /*                           "{" optsep */
// /*                               *((yang-stmt / unknown-statement) optsep) */
// /*                            "}") stmtsep */
unknown_stmt
: 'IDENTIFIER' ':' 'IDENTIFIER' ';'                             {}
|  'IDENTIFIER' ':' 'IDENTIFIER' string ';'                     {}
/* | IDENTIFIER ':' IDENTIFIER '{' unknown_stmt_body '}' */
;


// /*    yang-stmt           = action-stmt / */
// /*                          anydata-stmt / */
// /*                          anyxml-stmt / */
// /*                          argument-stmt / */
// /*                          augment-stmt / */
// /*                          base-stmt / */
// /*                          belongs-to-stmt / */
// /*                          bit-stmt / */
// /*                          case-stmt / */
// /*                          choice-stmt / */
// /*                          config-stmt / */
// /*                          contact-stmt / */
// /*                          container-stmt / */
// /*                          default-stmt / */
// /*                          description-stmt / */
// /*                          deviate-add-stmt / */
// /*                          deviate-delete-stmt / */
// /*                          deviate-not-supported-stmt / */
// /*                          deviate-replace-stmt / */
// /*                          deviation-stmt / */
// /*                          enum-stmt / */
// /*                          error-app-tag-stmt / */
// /*                          error-message-stmt / */
// /*                          extension-stmt / */
// /*                          feature-stmt / */
// /*                          fraction-digits-stmt / */
// /*                          grouping-stmt / */
// /*                          identity-stmt / */
// /*                          if-feature-stmt / */
// /*                          import-stmt / */
// /*                          include-stmt / */
// /*                          input-stmt / */
// /*                          key-stmt / */
// /*                          leaf-list-stmt / */
// /*                          leaf-stmt / */
// /*                          length-stmt / */
// /*                          list-stmt / */
// /*                          mandatory-stmt / */
// /*                          max-elements-stmt / */
// /*                          min-elements-stmt / */
// /*                          modifier-stmt / */
// /*                          module-stmt / */
// /*                          must-stmt / */
// /*                          namespace-stmt / */
// /*                          notification-stmt / */
// /*                          ordered-by-stmt / */
// /*                          organization-stmt / */
// /*                          output-stmt / */
// /*                          path-stmt / */
// /*                          pattern-stmt / */
// /*                          position-stmt / */
// /*                          prefix-stmt / */
// /*                          presence-stmt / */
// /*                          range-stmt / */
// /*                          reference-stmt / */
// /*                          refine-stmt / */
// /*                          require-instance-stmt / */
// /*                          revision-date-stmt / */
// /*                          revision-stmt / */
// /*                          rpc-stmt / */
// /*                          status-stmt / */
// /*                          submodule-stmt / */
// /*                          typedef-stmt / */
// /*                          type-stmt / */
// /*                          unique-stmt / */
// /*                          units-stmt / */
// /*                          uses-augment-stmt / */
// /*                          uses-stmt / */
// /*                          value-stmt / */
// /*                          when-stmt / */
// /*                          yang-version-stmt / */
// /*                          yin-element-stmt */

// /*    ;; Ranges */

// /*    range-arg-str       = < a string that matches the rule > < range-arg > */
// /*    range-arg           = range-part *(optsep "|" optsep range-part) */
// range_arg
// : range_parts                                                                  {}
// ;

// range_parts
// : range_part                                                                   {}
// | range_parts '|' range_part                                                   {}
// ;

// /*    range-part          = range-boundary [optsep ".." optsep range-boundary] */
// range_part
// : range_boundary                                                               {}
// | range_boundary '..' range_boundary                                           {}
// ;

// /*    range-boundary      = min-keyword / max-keyword / integer-value / decimal-value */
// range_boundary
// : 'min'                                                                        {}
// | 'max'                                                                        {}
// | 'INTEGER'                                                                    { $$ = $1; }
// | 'DECIMAL'                                                                    { $$ = $1; }
// ;

// /*    ;; Lengths */
// /*    length-arg-str      = < a string that matches the rule > <length-arg > */
// /*    length-arg          = length-part *(optsep "|" optsep length-part) */
// length_arg
// : length_parts                                                               { $$ = $1; }
// ;

// length_parts
// : length_part                                                                {}               
// | length_parts '|' length_part                                               {}
// ;

// /*    length-part         = length-boundary [optsep ".." optsep length-boundary] */
// length_part
// : length_boundary                                                            {}
// | length_boundary '..' length_boundary                                       {}
// ;

// /*    length-boundary     = min-keyword / max-keyword / non-negative-integer-value */
// length_boundary
// : 'min'                                                                      {}
// | 'max'                                                                      {}
// | 'INTEGER'                                                                  {}
// ;

// /*    ;; Date */

// /*    date-arg-str        = < a string that matches the rule > < date-arg > */
// /*    date-arg            = 4DIGIT "-" 2DIGIT "-" 2DIGIT */

// /*    ;; Schema Node Identifiers */

// /*    schema-nodeid       = absolute-schema-nodeid / descendant-schema-nodeid */
// /*    absolute-schema-nodeid = 1*("/" node-identifier) */
// absolute_schema_nodeid
// : '/' node_identifier                                                            {}
// | absolute_schema_nodeid '/' node_identifier                                     {}
// ;

// /*    descendant-schema-nodeid = node-identifier [absolute-schema-nodeid] */
// descendant_schema_nodeid
// : node_identifier                                                                {}
// | node_identifier absolute_schema_nodeid                                         {}
// ;

// /*    node-identifier     = [prefix ":"] identifier */
// node_identifier
// : 'IDENTIFIER'                                                                   {}
// | 'IDENTIFIER' ':' IDENTIFIER                                                    {}
// ;

// /*    ;; Instance Identifiers */

// /*    instance-identifier = 1*("/" (node-identifier *predicate)) */
// /*    predicate           = "[" *WSP (predicate-expr / pos) *WSP "]" */

// /*    predicate-expr      = (node-identifier / ".") *WSP "=" *WSP ((DQUOTE string DQUOTE) / (SQUOTE string SQUOTE)) */
// /*    pos                 = non-negative-integer-value */


// /*    ;; leafref path */

// /*    path-arg-str        = < a string that matches the rule > < path-arg > */
// /*    path-arg            = absolute-path / relative-path */
// /*    absolute-path       = 1*("/" (node-identifier *path-predicate)) */
// /*    relative-path       = 1*(".." "/") descendant-path */

// /*    descendant-path     = node-identifier [*path-predicate absolute-path] */
// /*    path-predicate      = "[" *WSP path-equality-expr *WSP "]" */
// /*    path-equality-expr  = node-identifier *WSP "=" *WSP path-key-expr */
// /*    path-key-expr       = current-function-invocation *WSP "/" *WSP rel-path-keyexpr */
// /*    rel-path-keyexpr    = 1*(".." *WSP "/" *WSP) *(node-identifier *WSP "/" *WSP) *node-identifier */

// /*    ;;; Keywords, using RFC 7405 syntax for case-sensitive strings */

// /*    ;; statement keywords */
// /*    action-keyword      = %s"action" */
// /*    anydata-keyword     = %s"anydata" */
// /*    anyxml-keyword      = %s"anyxml" */
// /*    argument-keyword    = %s"argument" */
// /*    augment-keyword     = %s"augment" */
// /*    base-keyword        = %s"base" */
// /*    belongs-to-keyword  = %s"belongs-to" */
// /*    bit-keyword         = %s"bit" */
// /*    case-keyword        = %s"case" */
// /*    choice-keyword      = %s"choice" */
// /*    config-keyword      = %s"config" */
// /*    contact-keyword     = %s"contact" */
// /*    container-keyword   = %s"container" */
// /*    default-keyword     = %s"default" */
// /*    description-keyword = %s"description" */
// /*    enum-keyword        = %s"enum" */
// /*    error-app-tag-keyword = %s"error-app-tag" */
// /*    error-message-keyword = %s"error-message" */
// /*    extension-keyword   = %s"extension" */
// /*    deviation-keyword   = %s"deviation" */
// /*    deviate-keyword     = %s"deviate" */
// /*    feature-keyword     = %s"feature" */
// /*    fraction-digits-keyword = %s"fraction-digits" */
// /*    grouping-keyword    = %s"grouping" */
// /*    identity-keyword    = %s"identity" */
// /*    if-feature-keyword  = %s"if-feature" */
// /*    import-keyword      = %s"import" */
// /*    include-keyword     = %s"include" */
// /*    input-keyword       = %s"input" */
// /*    key-keyword         = %s"key" */
// /*    leaf-keyword        = %s"leaf" */
// /*    leaf-list-keyword   = %s"leaf-list" */
// /*    length-keyword      = %s"length" */
// /*    list-keyword        = %s"list" */
// /*    mandatory-keyword   = %s"mandatory" */
// /*    max-elements-keyword = %s"max-elements" */
// /*    min-elements-keyword = %s"min-elements" */
// /*    modifier-keyword    = %s"modifier" */
// /*    module-keyword      = %s"module" */
// /*    must-keyword        = %s"must" */
// /*    namespace-keyword   = %s"namespace" */
// /*    notification-keyword= %s"notification" */
// /*    ordered-by-keyword  = %s"ordered-by" */
// /*    organization-keyword= %s"organization" */
// /*    output-keyword      = %s"output" */
// /*    path-keyword        = %s"path" */
// /*    pattern-keyword     = %s"pattern" */
// /*    position-keyword    = %s"position" */
// /*    prefix-keyword      = %s"prefix" */
// /*    presence-keyword    = %s"presence" */
// /*    range-keyword       = %s"range" */
// /*    reference-keyword   = %s"reference" */
// /*    refine-keyword      = %s"refine" */
// /*    require-instance-keyword = %s"require-instance" */
// /*    revision-keyword    = %s"revision" */
// /*    revision-date-keyword = %s"revision-date" */
// /*    rpc-keyword         = %s"rpc" */
// /*    status-keyword      = %s"status" */
// /*    submodule-keyword   = %s"submodule" */
// /*    type-keyword        = %s"type" */
// /*    typedef-keyword     = %s"typedef" */
// /*    unique-keyword      = %s"unique" */
// /*    units-keyword       = %s"units" */
// /*    uses-keyword        = %s"uses" */
// /*    value-keyword       = %s"value" */
// /*    when-keyword        = %s"when" */
// /*    yang-version-keyword= %s"yang-version" */
// /*    yin-element-keyword = %s"yin-element" */

// /*    ;; other keywords */

// /*    add-keyword         = %s"add" */
// /*    current-keyword     = %s"current" */
// /*    delete-keyword      = %s"delete" */
// /*    deprecated-keyword  = %s"deprecated" */
// /*    false-keyword       = %s"false" */
// /*    invert-match-keyword = %s"invert-match" */
// /*    max-keyword         = %s"max" */
// /*    min-keyword         = %s"min" */
// /*    not-supported-keyword = %s"not-supported" */
// /*    obsolete-keyword    = %s"obsolete" */
// /*    replace-keyword     = %s"replace" */
// /*    system-keyword      = %s"system" */
// /*    true-keyword        = %s"true" */
// /*    unbounded-keyword   = %s"unbounded" */
// /*    user-keyword        = %s"user" */
// /*    and-keyword         = %s"and" */
// /*    or-keyword          = %s"or" */
// /*    not-keyword         = %s"not" */

// /*    current-function-invocation = current-keyword *WSP "(" *WSP ")" */

// /*    ;;; Basic Rules */

// /*    prefix-arg-str      = < a string that matches the rule > < prefix-arg > */
// /*    prefix-arg          = prefix */
// /*    prefix              = identifier */

// /*    identifier-arg-str  = < a string that matches the rule > < identifier-arg > */

// /*    identifier-arg      = identifier */

// /*    ;; An identifier MUST NOT start with (('X'|'x') ('M'|'m') ('L'|'l')) */
// /*    identifier          = (ALPHA / "_") *(ALPHA / DIGIT / "_" / "-" / ".") */

// /*    identifier-ref-arg-str = < a string that matches the rule > < identifier-ref-arg > */
// /*    identifier-ref-arg  = identifier-ref */
// identifier_ref
// : 'IDENTIFIER'                            {}
// | 'IDENTIFIER' ':' 'IDENTIFIER'           {}
// ;

// /*    identifier-ref      = [prefix ":"] identifier */

string
: 'UNQUOTED_STRING'                       { $$ = $1; }
| quoted_string                           { $$ = $1; }
;

quoted_string
: 'QUOTED_STRING_PART'                    { $$ = $1; }
| quoted_string '+' 'QUOTED_STRING_PART'  {}
;

// /*    string              = < an unquoted string as returned by > */
// /*                          < the scanner, that matches the rule > */
// /*                          < yang-string > */

// /*    yang-string        = *yang-char */

// /*    ;; any Unicode or ISO/IEC 10646 character including tab, carriage */
// /*    ;; return, and line feed, but excluding the other C0 control */
// /*    ;; characters, the surrogate blocks, and the noncharacters. */
// /*    yang-char = %x9 / %xA / %xD / %x20-D7FF / */
// /*                                ; exclude surrogate blocks %xD800-DFFF */
// /*               %xE000-FDCF /    ; exclude noncharacters %xFDD0-FDEF */
// /*               %xFDF0-FFFD /    ; exclude noncharacters %xFFFE-FFFF */
// /*               %x10000-1FFFD /  ; exclude noncharacters %x1FFFE-1FFFF */
// /*               %x20000-2FFFD /  ; exclude noncharacters %x2FFFE-2FFFF */
// /*               %x30000-3FFFD /  ; exclude noncharacters %x3FFFE-3FFFF */
// /*               %x40000-4FFFD /  ; exclude noncharacters %x4FFFE-4FFFF */
// /*               %x50000-5FFFD /  ; exclude noncharacters %x5FFFE-5FFFF */
// /*               %x60000-6FFFD /  ; exclude noncharacters %x6FFFE-6FFFF */
// /*               %x70000-7FFFD /  ; exclude noncharacters %x7FFFE-7FFFF */
// /*               %x80000-8FFFD /  ; exclude noncharacters %x8FFFE-8FFFF */
// /*               %x90000-9FFFD /  ; exclude noncharacters %x9FFFE-9FFFF */
// /*               %xA0000-AFFFD /  ; exclude noncharacters %xAFFFE-AFFFF */
// /*               %xB0000-BFFFD /  ; exclude noncharacters %xBFFFE-BFFFF */
// /*               %xC0000-CFFFD /  ; exclude noncharacters %xCFFFE-CFFFF */
// /*               %xD0000-DFFFD /  ; exclude noncharacters %xDFFFE-DFFFF */
// /*               %xE0000-EFFFD /  ; exclude noncharacters %xEFFFE-EFFFF */
// /*               %xF0000-FFFFD /  ; exclude noncharacters %xFFFFE-FFFFF */
// /*               %x100000-10FFFD  ; exclude noncharacters %x10FFFE-10FFFF */

// /*    integer-value       = ("-" non-negative-integer-value)  / non-negative-integer-value */

// /*    non-negative-integer-value = "0" / positive-integer-value */

// /*    positive-integer-value = (non-zero-digit *DIGIT) */

// /*    zero-integer-value  = 1*DIGIT */

// /*    stmtend             = optsep (";" / "{" stmtsep "}") stmtsep */

// /*    sep                 = 1*(WSP / line-break) */
// /*                          ; unconditional separator */

// /*    optsep              = *(WSP / line-break) */

// /*    stmtsep             = *(WSP / line-break / unknown-statement) */

// /*    line-break          = CRLF / LF */

// /*    non-zero-digit      = %x31-39 */

// /*    decimal-value       = integer-value ("." zero-integer-value) */

// /*    SQUOTE              = %x27 */
// /*                          ; ' (Single Quote) */

// /*    ;;; RFC 5234 core rules. */

// /*    ALPHA               = %x41-5A / %x61-7A */
// /*                          ; A-Z / a-z */

// /*    CR                  = %x0D */
// /*                          ; carriage return */

// /*    CRLF                = CR LF */
// /*                          ; Internet standard new line */

// /*    DIGIT               = %x30-39 */
// /*                          ; 0-9 */

// /*    DQUOTE              = %x22 */
// /*                          ; double quote */

// /*    HEXDIG              = DIGIT / */
// /*                          %x61 / %x62 / %x63 / %x64 / %x65 / %x66 */
// /*                          ; only lower-case a..f */

// /*    HTAB                = %x09 */
// /*                          ; horizontal tab */

// /*    LF                  = %x0A */
// /*                          ; linefeed */

// /*    SP                  = %x20 */
// /*                          ; space */

// /*    VCHAR               = %x21-7E */
// /*                          ; visible (printing) characters */

// /*    WSP                 = SP / HTAB */
// /*                          ; whitespace */

%%
