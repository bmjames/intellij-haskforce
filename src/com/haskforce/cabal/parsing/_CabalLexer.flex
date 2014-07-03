package com.haskforce.cabal.parsing;

import com.intellij.lexer.FlexLexer;
import com.haskforce.cabal.psi.CabalTypes.*;

%%

%{
  public _CabalLexer() { this((java.io.Reader)null); }
%}

%class _CabalLexer
%implements FlexLexer
%unicode
%ignorecase
%function advance
%type IElementType
%eof{  return;
%eof}

LINE_TERMINATOR = \r|\n|\r\n
INPUT_CHAR      = [^\r\n]
WHITE_SPACE     = {LINE_TERMINATOR} | [ \t\f]
COMMENT         = "--" {INPUT_CHAR}* {LINE_TERMINATOR}?

%state VALUE

%%

/**
  * 3.1. Package descriptions
  * http://www.haskell.org/ghc/docs/7.0.3/html/Cabal/authors.html#pkg-descr
  */
<YYINITIAL> "name"                    { return NAME; }
<YYINITIAL> "version"                 { return VERSION; }
<YYINITIAL> "cabal-version"           { return CABAL_VERSION; }
<YYINITIAL> "build-type"              { return BUILD_TYPE; }
<YYINITIAL> "license"                 { return LICENSE; }
<YYINITIAL> "license-file"            { return LICENSE_FILE; }
<YYINITIAL> "copyright"               { return COPYRIGHT; }
<YYINITIAL> "author"                  { return AUTHOR; }
<YYINITIAL> "maintainer"              { return MAINTAINER; }
<YYINITIAL> "stability"               { return STABILITY; }
<YYINITIAL> "homepage"                { return HOMEPAGE; }
<YYINITIAL> "bug-reports"             { return BUG_REPORTS; }
<YYINITIAL> "package-url"             { return PACKAGE_URL; }
<YYINITIAL> "synopsis"                { return SYNOPSIS; }
<YYINITIAL> "description"             { return DESCRIPTION; }
<YYINITIAL> "category"                { return CATEGORY; }
<YYINITIAL> "tested-with"             { return TESTED_WITH; }
<YYINITIAL> "data-files"              { return DATA_FILES; }
<YYINITIAL> "data-dir"                { return DATA_DIR; }
<YYINITIAL> "extra-source-files"      { return EXTRA_SOURCE_FILES; }
<YYINITIAL> "extra-tmp-files"         { return EXTRA_TMP_FILES; }
<YYINITIAL> "exposed-modules"         { return EXPOSED_MODULES; }
<YYINITIAL> "exposed"                 { return EXPOSED; }
<YYINITIAL> "main-is"                 { return MAIN_IS; }
<YYINITIAL> "build-depends"           { return BUILD_DEPENDS; }
<YYINITIAL> "other-modules"           { return OTHER_MODULES; }
<YYINITIAL> "hs-source-dirs"          { return HS_SOURCE_DIRS; }
<YYINITIAL> "extensions"              { return EXTENSIONS; }
<YYINITIAL> "build-tools"             { return BUILD_TOOLS; }
<YYINITIAL> "buildable"               { return BUILDABLE; }
<YYINITIAL> "ghc-options"             { return GHC_OPTIONS; }
<YYINITIAL> "ghc-prof-options"        { return GHC_PROF_OPTIONS; }
<YYINITIAL> "ghc-shared-options"      { return GHC_SHARED_OPTIONS; }
<YYINITIAL> "hugs-options"            { return HUGS_OPTIONS; }
<YYINITIAL> "nhc98-options"           { return NHC98_OPTIONS; }
<YYINITIAL> "includes"                { return INCLUDES; }
<YYINITIAL> "install-includes"        { return INSTALL_INCLUDES; }
<YYINITIAL> "include-dirs"            { return INCLUDE_DIRS; }
<YYINITIAL> "c-sources"               { return C_SOURCES; }
<YYINITIAL> "extra-libraries"         { return EXTRA_LIBRARIES; }
<YYINITIAL> "extra-lib-dirs"          { return EXTRA_LIB_DIRS; }
<YYINITIAL> "cc-options"              { return CC_OPTIONS; }
<YYINITIAL> "ld-options"              { return LD_OPTIONS; }
<YYINITIAL> "pkgconfig-depends"       { return PKGCONFIG_DEPENDS; }
<YYINITIAL> "frameworks"              { return FRAMEWORKS; }

<YYINITIAL> {COMMENT}                 { return COMMENT; }

<YYINITIAL> ":"                       { yybegin(VALUE); return COLON; }

<VALUE> {
    {LINE_TERMINATOR}                       { yybegin(YYINITIAL); }
    {LINE_TERMINATOR}? [ \t\f]*             { /* ignore */ }
    [^]                                     { return VALUE; }
}
