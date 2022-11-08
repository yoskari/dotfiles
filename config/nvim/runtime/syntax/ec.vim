" Vim syntax file
" Language:     ec
" Maintainer:   Oskari Ylönen <oskari.ylonen@iki.fi>
" Last Change:  November 8, 2022

" Syntax definitions {{{1
" Basic keywords {{{2
syn keyword   ecConditional switch if else
syn keyword   ecRepeat for loop while
syn keyword   ecTypedef type nextgroup=ecIdentifier skipwhite skipempty
syn keyword   ecStructure struct enum nextgroup=ecIdentifier skipwhite skipempty
syn keyword   ecUnion union nextgroup=ecIdentifier skipwhite skipempty contained
syn match ecUnionContextual /\<union\_s\+\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*/ transparent contains=ecUnion
syn keyword   ecOperator    as

syn match     ecAssert      "\<assert\(\w\)*!" contained
syn match     ecPanic       "\<panic\(\w\)*!" contained
syn keyword   ecKeyword     break
syn keyword   ecKeyword     box nextgroup=ecBoxPlacement skipwhite skipempty
syn keyword   ecKeyword     continue
syn keyword   ecKeyword     extern nextgroup=ecExternCrate,ecObsoleteExternMod skipwhite skipempty
syn keyword   ecKeyword     function nextgroup=ecFuncName skipwhite skipempty
syn keyword   ecKeyword     in impl var
syn keyword   ecKeyword     export nextgroup=ecPubScope skipwhite skipempty
syn keyword   ecKeyword     return
syn keyword   ecSuper       super
syn keyword   ecKeyword     use nextgroup=ecModPath skipwhite skipempty
" FIXME: Scoped impl's name is also fallen in this category
syn keyword   ecKeyword     mod trait nextgroup=ecIdentifier skipwhite skipempty
syn keyword   ecStorage     static const
syn match ecDefault /\<default\ze\_s\+\(impl\|fn\|type\|const\)\>/

syn keyword   ecInvalidBareKeyword crate

syn keyword ecPubScopeCrate crate contained
syn match ecPubScopeDelim /[()]/ contained
syn match ecPubScope /([^()]*)/ contained contains=ecPubScopeDelim,ecPubScopeCrate,ecSuper,ecModPath,ecModPathSep,ecSelf transparent

syn keyword   ecExternCrate crate contained nextgroup=ecIdentifier,ecExternCrateString skipwhite skipempty
" This is to get the `bar` part of `extern crate "foo" as bar;` highlighting.
syn match   ecExternCrateString /".*"\_s*as/ contained nextgroup=ecIdentifier skipwhite transparent skipempty contains=ecString,ecOperator
syn keyword   ecObsoleteExternMod mod contained nextgroup=ecIdentifier skipwhite skipempty

syn match     ecIdentifier  contains=ecIdentifierPrime "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn match     ecFuncName    "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained

syn region    ecBoxPlacement matchgroup=ecBoxPlacementParens start="(" end=")" contains=TOP contained
" Ideally we'd have syntax rules set up to match arbitrary expressions. Since
" we don't, we'll just define temporary contained rules to handle balancing
" delimiters.
syn region    ecBoxPlacementBalance start="(" end=")" containedin=ecBoxPlacement transparent
syn region    ecBoxPlacementBalance start="\[" end="\]" containedin=ecBoxPlacement transparent
" {} are handled by ecFoldBraces

syn region ecMacroRepeat matchgroup=ecMacroRepeatDelimiters start="$(" end=")" contains=TOP nextgroup=ecMacroRepeatCount
syn match ecMacroRepeatCount ".\?[*+]" contained
syn match ecMacroVariable "$\w\+"

" Reserved (but not yet used) keywords {{{2
syn keyword   ecReservedKeyword alignof become do offsetof priv pure sizeof typeof unsized yield abstract virtual final override macro

" Built-in types {{{2
syn keyword   ecType        Boolean UInt8 Uint16 UInt32 UInt64 UInt128 Float32
syn keyword   ecType        Float64 Int8 Int16 Int32 Int64 Int128 String Self
syn keyword   ecType        Bytes

" Things from the libstd v1 prelude (src/libstd/prelude/v1.rs) {{{2
" This section is just straight transformation of the contents of the prelude,
" to make it easy to update.

" Reexported core operators {{{3
syn keyword   ecTrait       Copy Send Sized Sync
syn keyword   ecTrait       Drop Fn FnMut FnOnce

" Reexported functions {{{3
" There’s no point in highlighting these; when one writes drop( or drop::< it
" gets the same highlighting anyway, and if someone writes `let drop = …;` we
" don’t really want *that* drop to be highlighted.
"syn keyword ecFunction drop

" Reexported types and traits {{{3
syn keyword ecTrait Box
syn keyword ecTrait ToOwned
syn keyword ecTrait Clone
syn keyword ecTrait PartialEq PartialOrd Eq Ord
syn keyword ecTrait AsRef AsMut Into From
syn keyword ecTrait Default
syn keyword ecTrait Iterator Extend IntoIterator
syn keyword ecTrait DoubleEndedIterator ExactSizeIterator
syn keyword ecEnum Option
syn keyword ecEnumVariant Some None
syn keyword ecEnum Result
syn keyword ecEnumVariant Ok Err
syn keyword ecTrait SliceConcatExt
syn keyword ecTrait String ToString
syn keyword ecTrait Vec

" Other syntax {{{2
syn keyword   ecSelf        self
syn keyword   ecBoolean     TRUE FALSE

" If foo::bar changes to foo.bar, change this ("::" to "\.").
" If foo::bar changes to Foo::bar, change this (first "\w" to "\u").
syn match     ecModPath     "\w\(\w\)*::[^<]"he=e-3,me=e-3
syn match     ecModPathSep  "::"

syn match     ecFuncCall    "\w\(\w\)*("he=e-1,me=e-1
syn match     ecFuncCall    "\w\(\w\)*::<"he=e-3,me=e-3 " foo::<T>();

" This is merely a convention; note also the use of [A-Z], restricting it to
" latin identifiers rather than the full Unicode uppercase. I have not used
" [:upper:] as it depends upon 'noignorecase'
"syn match     ecCapsIdent    display "[A-Z]\w\(\w\)*"

syn match     ecOperator     display "\%(+\|-\|/\|*\|=\|\^\|&\||\|!\|>\|<\|%\)=\?"
" This one isn't *quite* right, as we could have binary-& with a reference
syn match     ecSigil        display /&\s\+[&~@*][^)= \t\r\n]/he=e-1,me=e-1
syn match     ecSigil        display /[&~@*][^)= \t\r\n]/he=e-1,me=e-1
" This isn't actually correct; a closure with no arguments can be `|| { }`.
" Last, because the & in && isn't a sigil
syn match     ecOperator     display "&&\|||"
" This is ecArrowCharacter rather than ecArrow for the sake of matchparen,
" so it skips the ->; see http://stackoverflow.com/a/30309949 for details.
syn match     ecArrowCharacter display "->"
syn match     ecQuestionMark display "?\([a-zA-Z]\+\)\@!"

syn match     ecMacro       '\w\(\w\)*!' contains=ecAssert,ecPanic
syn match     ecMacro       '#\w\(\w\)*' contains=ecAssert,ecPanic

syn match     ecEscapeError   display contained /\\./
syn match     ecEscape        display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match     ecEscapeUnicode display contained /\\u{\x\{1,6}}/
syn match     ecStringContinuation display contained /\\\n\s*/
syn region    ecString      start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=ecEscape,ecEscapeError,ecStringContinuation
syn region    ecString      start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=ecEscape,ecEscapeUnicode,ecEscapeError,ecStringContinuation,@Spell
syn region    ecString      start='b\?r\z(#*\)"' end='"\z1' contains=@Spell

syn region    ecAttribute   start="#!\?\[" end="\]" contains=ecString,ecDerive,ecCommentLine,ecCommentBlock,ecCommentLineDocError,ecCommentBlockDocError
syn region    ecDerive      start="derive(" end=")" contained contains=ecDeriveTrait
" This list comes from src/libsyntax/ext/deriving/mod.rs
" Some are deprecated (Encodable, Decodable) or to be removed after a new snapshot (Show).
syn keyword   ecDeriveTrait contained Clone Hash RustcEncodable RustcDecodable Encodable Decodable PartialEq Eq PartialOrd Ord Rand Show Debug Default FromPrimitive Send Sync Copy

" Number literals
syn match     ecDecNumber   display "\<[0-9][0-9_]*\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     ecHexNumber   display "\<0x[a-fA-F0-9_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     ecOctNumber   display "\<0o[0-7_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     ecBinNumber   display "\<0b[01_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="

" Special case for numbers of the form "1." which are float literals, unless followed by
" an identifier, which makes them integer literals with a method call or field access,
" or by another ".", which makes them integer literals followed by the ".." token.
" (This must go first so the others take precedence.)
syn match     ecFloat       display "\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\|\.\)\@!"
" To mark a number as a normal float, it must have at least one of the three things integral values don't have:
" a decimal point and more numbers; an exponent; and a type suffix.
syn match     ecFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)\="
syn match     ecFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f32\|f64\)\="
syn match     ecFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)"

" For the benefit of delimitMate
syn region ecLifetimeCandidate display start=/&'\%(\([^'\\]\|\\\(['nrt0\\\"]\|x\x\{2}\|u{\x\{1,6}}\)\)'\)\@!/ end=/[[:cntrl:][:space:][:punct:]]\@=\|$/ contains=ecSigil,ecLifetime
syn region ecGenericRegion display start=/<\%('\|[^[cntrl:][:space:][:punct:]]\)\@=')\S\@=/ end=/>/ contains=ecGenericLifetimeCandidate
syn region ecGenericLifetimeCandidate display start=/\%(<\|,\s*\)\@<='/ end=/[[:cntrl:][:space:][:punct:]]\@=\|$/ contains=ecSigil,ecLifetime

"ecLifetime must appear before ecCharacter, or chars will get the lifetime highlighting
syn match     ecLifetime    display "\'\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*"
syn match     ecLabel       display "\'\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*:"
syn match   ecCharacterInvalid   display contained /b\?'\zs[\n\r\t']\ze'/
" The groups negated here add up to 0-255 but nothing else (they do not seem to go beyond ASCII).
syn match   ecCharacterInvalidUnicode   display contained /b'\zs[^[:cntrl:][:graph:][:alnum:][:space:]]\ze'/
syn match   ecCharacter   /b'\([^\\]\|\\\(.\|x\x\{2}\)\)'/ contains=ecEscape,ecEscapeError,ecCharacterInvalid,ecCharacterInvalidUnicode
syn match   ecCharacter   /'\([^\\]\|\\\(.\|x\x\{2}\|u{\x\{1,6}}\)\)'/ contains=ecEscape,ecEscapeUnicode,ecEscapeError,ecCharacterInvalid

syn match ecShebang /\%^#![^[].*/
syn region ecCommentLine                                                  start="//"                      end="$"   contains=ecTodo,@Spell
syn region ecCommentLineDoc                                               start="//\%(//\@!\|!\)"         end="$"   contains=ecTodo,@Spell
syn region ecCommentLineDocError                                          start="//\%(//\@!\|!\)"         end="$"   contains=ecTodo,@Spell contained
syn region ecCommentBlock             matchgroup=ecCommentBlock         start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=ecTodo,ecCommentBlockNest,@Spell
syn region ecCommentBlockDoc          matchgroup=ecCommentBlockDoc      start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=ecTodo,ecCommentBlockDocNest,@Spell
syn region ecCommentBlockDocError     matchgroup=ecCommentBlockDocError start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=ecTodo,ecCommentBlockDocNestError,@Spell contained
syn region ecCommentBlockNest         matchgroup=ecCommentBlock         start="/\*"                     end="\*/" contains=ecTodo,ecCommentBlockNest,@Spell contained transparent
syn region ecCommentBlockDocNest      matchgroup=ecCommentBlockDoc      start="/\*"                     end="\*/" contains=ecTodo,ecCommentBlockDocNest,@Spell contained transparent
syn region ecCommentBlockDocNestError matchgroup=ecCommentBlockDocError start="/\*"                     end="\*/" contains=ecTodo,ecCommentBlockDocNestError,@Spell contained transparent
" FIXME: this is a really ugly and not fully correct implementation. Most
" importantly, a case like ``/* */*`` should have the final ``*`` not being in
" a comment, but in practice at present it leaves comments open two levels
" deep. But as long as you stay away from that particular case, I *believe*
" the highlighting is correct. Due to the way Vim's syntax engine works
" (greedy for start matches, unlike Rust's tokeniser which is searching for
" the earliest-starting match, start or end), I believe this cannot be solved.
" Oh you who would fix it, don't bother with things like duplicating the Block
" rules and putting ``\*\@<!`` at the start of them; it makes it worse, as
" then you must deal with cases like ``/*/**/*/``. And don't try making it
" worse with ``\%(/\@<!\*\)\@<!``, either...

syn keyword ecTodo contained TODO FIXME XXX NB NOTE

" Folding rules {{{2
" Trivial folding rules to begin with.
" FIXME: use the AST to make really good folding
syn region ecFoldBraces start="{" end="}" transparent fold

" Default highlighting {{{1
hi def link ecDecNumber       ecNumber
hi def link ecHexNumber       ecNumber
hi def link ecOctNumber       ecNumber
hi def link ecBinNumber       ecNumber
hi def link ecIdentifierPrime ecIdentifier
hi def link ecTrait           ecType
hi def link ecDeriveTrait     ecTrait

hi def link ecMacroRepeatCount   ecMacroRepeatDelimiters
hi def link ecMacroRepeatDelimiters   Macro
hi def link ecMacroVariable Define
hi def link ecSigil         StorageClass
hi def link ecEscape        Special
hi def link ecEscapeUnicode ecEscape
hi def link ecEscapeError   Error
hi def link ecStringContinuation Special
hi def link ecString        String
hi def link ecCharacterInvalid Error
hi def link ecCharacterInvalidUnicode ecCharacterInvalid
hi def link ecCharacter     Character
hi def link ecNumber        Number
hi def link ecBoolean       Boolean
hi def link ecEnum          ecType
hi def link ecEnumVariant   ecConstant
hi def link ecConstant      Constant
hi def link ecSelf          Constant
hi def link ecFloat         Float
hi def link ecArrowCharacter ecOperator
hi def link ecOperator      Operator
hi def link ecKeyword       Keyword
hi def link ecTypedef       Keyword " More precise is Typedef, but it doesn't feel right for Rust
hi def link ecStructure     Keyword " More precise is Structure
hi def link ecUnion         ecStructure
hi def link ecPubScopeDelim Delimiter
hi def link ecPubScopeCrate ecKeyword
hi def link ecSuper         ecKeyword
hi def link ecReservedKeyword Error
hi def link ecRepeat        Conditional
hi def link ecConditional   Conditional
hi def link ecIdentifier    Identifier
hi def link ecCapsIdent     ecIdentifier
hi def link ecModPath       Include
hi def link ecModPathSep    Delimiter
hi def link ecFunction      Function
hi def link ecFuncName      Function
hi def link ecFuncCall      Function
hi def link ecShebang       Comment
hi def link ecCommentLine   Comment
hi def link ecCommentLineDoc SpecialComment
hi def link ecCommentLineDocError Error
hi def link ecCommentBlock  ecCommentLine
hi def link ecCommentBlockDoc ecCommentLineDoc
hi def link ecCommentBlockDocError Error
hi def link ecAssert        PreCondit
hi def link ecPanic         PreCondit
hi def link ecMacro         Macro
hi def link ecType          Type
hi def link ecTodo          Todo
hi def link ecAttribute     PreProc
hi def link ecDerive        PreProc
hi def link ecDefault       StorageClass
hi def link ecStorage       StorageClass
hi def link ecObsoleteStorage Error
hi def link ecLifetime      Special
hi def link ecLabel         Label
hi def link ecInvalidBareKeyword Error
hi def link ecExternCrate   ecKeyword
hi def link ecObsoleteExternMod Error
hi def link ecBoxPlacementParens Delimiter
hi def link ecQuestionMark  Special

" Other Suggestions:
" hi ecAttribute ctermfg=cyan
" hi ecDerive ctermfg=cyan
" hi ecAssert ctermfg=yellow
" hi ecPanic ctermfg=red
" hi ecMacro ctermfg=magenta

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "ec"
