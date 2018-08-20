set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="jellybeans-stripped"

hi SpecialKey term=bold ctermfg=238 ctermbg=234 guifg=#444444 guibg=#1c1c1c
hi link EndOfBuffer NonText
hi NonText term=bold ctermfg=240 ctermbg=233 guifg=#606060 guibg=#151515
hi Directory term=bold ctermfg=186 guifg=#dad085
hi ErrorMsg term=standout ctermbg=88 guibg=#902020
hi IncSearch term=reverse cterm=reverse gui=reverse
hi Search term=reverse cterm=underline ctermfg=217 ctermbg=16 gui=underline guifg=#f0a0c0 guibg=#302028
hi! link MoreMsg Special
hi ModeMsg term=bold cterm=bold gui=bold
hi LineNr term=underline ctermfg=59 ctermbg=233 guifg=#605958 guibg=#151515
hi CursorLineNr term=bold ctermfg=188 guifg=#ccc5c4
hi Question term=standout ctermfg=71 guifg=#65C254
hi StatusLine term=bold,reverse ctermfg=16 ctermbg=253 gui=italic guifg=#000000 guibg=#dddddd
hi StatusLineNC term=reverse ctermfg=231 ctermbg=235 gui=italic guifg=#ffffff guibg=#403c41
hi VertSplit term=reverse ctermfg=243 ctermbg=16 guifg=#777777 guibg=#403c41
hi Title term=bold cterm=bold ctermfg=71 gui=bold guifg=#70b950
hi Visual term=reverse ctermbg=237 guibg=#404040
hi VisualNOS term=bold,underline cterm=bold,underline gui=bold,underline
hi WarningMsg term=standout ctermfg=224 guifg=Red
hi WildMenu term=standout ctermfg=217 ctermbg=16 guifg=#f0a0c0 guibg=#302028
hi Folded term=standout ctermfg=145 ctermbg=236 gui=italic guifg=#a0a8b0 guibg=#384048
hi FoldColumn term=standout ctermfg=59 ctermbg=234 guifg=#535D66 guibg=#1f1f1f
hi DiffAdd term=bold ctermfg=193 ctermbg=22 guifg=#D2EBBE guibg=#437019
hi DiffChange term=bold ctermbg=24 guibg=#2B5B77
hi DiffDelete term=bold ctermfg=16 ctermbg=52 guifg=#40000A guibg=#700009
hi DiffText term=reverse cterm=reverse ctermfg=81 ctermbg=16 gui=reverse guifg=#8fbfdc guibg=#000000
hi SignColumn term=standout ctermfg=243 ctermbg=236 guifg=#777777 guibg=#333333
hi! link Conceal Operator
hi SpellBad term=reverse cterm=underline ctermbg=88 gui=underline guibg=#902020 guisp=Red
hi SpellCap term=reverse cterm=underline ctermbg=20 gui=underline guibg=#0000df guisp=Blue
hi SpellRare term=reverse cterm=underline ctermbg=53 gui=underline guibg=#540063 guisp=Magenta
hi SpellLocal term=underline cterm=underline ctermbg=23 gui=underline guibg=#2D7067 guisp=Cyan
hi Pmenu ctermfg=231 ctermbg=240 guifg=#ffffff guibg=#606060
hi PmenuSel ctermfg=232 ctermbg=255 guifg=#101010 guibg=#eeeeee
hi PmenuSbar ctermbg=248 guibg=Grey
hi PmenuThumb ctermbg=15 guibg=White
hi TabLine term=underline ctermfg=16 ctermbg=145 gui=italic guifg=#000000 guibg=#b0b8c0
hi TabLineSel term=bold cterm=bold ctermfg=16 ctermbg=255 gui=bold,italic guifg=#000000 guibg=#f0f0f0
hi TabLineFill term=reverse ctermfg=103 guifg=#9098a0
hi CursorColumn term=reverse ctermbg=234 guibg=#1c1c1c
hi CursorLine term=underline ctermbg=234 guibg=#1c1c1c
hi ColorColumn term=reverse ctermbg=16 guibg=#000000
hi link QuickFixLine Search
hi StatusLineTerm term=bold,reverse cterm=bold ctermfg=0 ctermbg=121 gui=bold guifg=bg guibg=LightGreen
hi StatusLineTermNC term=reverse ctermfg=0 ctermbg=121 guifg=bg guibg=LightGreen
hi Cursor ctermfg=233 ctermbg=153 guifg=#151515 guibg=#b0d0f0
hi lCursor guifg=bg guibg=fg
hi MatchParen term=reverse cterm=bold ctermfg=231 ctermbg=60 gui=bold guifg=#ffffff guibg=#556779
hi Normal ctermfg=188 ctermbg=233 guifg=#e8e8d3 guibg=#151515
hi ToolbarLine term=underline ctermbg=242 guibg=Grey50
hi ToolbarButton cterm=bold ctermfg=0 ctermbg=7 gui=bold guifg=Black guibg=LightGrey
hi Comment term=bold ctermfg=244 gui=italic guifg=#888888
hi Constant term=underline ctermfg=167 guifg=#cf6a4c
hi Special term=bold ctermfg=107 guifg=#799d6a
hi Identifier term=underline ctermfg=183 guifg=#c6b6ee
hi Statement term=bold ctermfg=103 guifg=#8197bf
hi PreProc term=underline ctermfg=110 guifg=#8fbfdc
hi Type term=underline ctermfg=215 guifg=#ffb964
hi Underlined term=underline cterm=underline ctermfg=81 gui=underline guifg=#80a0ff
hi Ignore ctermfg=0 guifg=bg
hi! link Error ErrorMsg
hi Todo term=standout cterm=bold ctermfg=251 gui=bold guifg=#c7c7c7
hi String ctermfg=107 guifg=#99ad6a
hi link Character Constant
hi link Number Constant
hi link Boolean Constant
hi link Float Number
hi Function ctermfg=222 guifg=#fad07a
hi link Conditional Statement
hi link Repeat Statement
hi link Label Statement
hi link Operator Structure
hi link Keyword Statement
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi StorageClass ctermfg=179 guifg=#c59f6f
hi Structure ctermfg=110 guifg=#8fbfdc
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi Delimiter ctermfg=66 guifg=#668799
hi link SpecialComment Special
hi link Debug Special
hi clear WhitespaceEOL
hi StringDelimiter ctermfg=58 guifg=#556633
hi link diffRemoved Constant
hi link diffAdded String
hi link phpFunctions Function
hi link phpSuperglobal Identifier
hi link phpQuoteSingle StringDelimiter
hi link phpQuoteDouble StringDelimiter
hi link phpBoolean Constant
hi link phpNull Constant
hi link phpArrayPair Operator
hi link phpOperator Normal
hi link phpRelation Normal
hi link phpVarSelector Identifier
hi link pythonOperator Statement
hi link rubySharpBang Comment
hi rubyClass ctermfg=30 guifg=#447799
hi rubyIdentifier ctermfg=183 guifg=#c6b6fe
hi link rubyConstant Type
hi link rubyFunction Function
hi rubyInstanceVariable ctermfg=183 guifg=#c6b6fe
hi rubySymbol ctermfg=104 guifg=#7697d6
hi link rubyGlobalVariable rubyInstanceVariable
hi link rubyModule rubyClass
hi rubyControl ctermfg=104 guifg=#7597c6
hi link rubyString String
hi link rubyStringDelimiter StringDelimiter
hi link rubyInterpolationDelimiter Identifier
hi rubyRegexpDelimiter ctermfg=53 guifg=#540063
hi rubyRegexp ctermfg=162 guifg=#dd0093
hi rubyRegexpSpecial ctermfg=126 guifg=#a40073
hi rubyPredefinedIdentifier ctermfg=168 guifg=#de5577
hi link erlangAtom rubySymbol
hi link erlangBIF rubyPredefinedIdentifier
hi link erlangFunction rubyPredefinedIdentifier
hi link erlangDirective Statement
hi link erlangNode Identifier
hi link elixirAtom rubySymbol
hi link javaScriptValue Constant
hi link javaScriptRegexpString rubyRegexp
hi link javaScriptTemplateVar StringDelim
hi clear StringDelim
hi link javaScriptTemplateDelim Identifier
hi link javaScriptTemplateString String
hi link coffeeRegExp javaScriptRegexpString
hi link luaOperator Conditional
hi link cFormat Identifier
hi link cOperator Constant
hi link objcClass Type
hi link cocoaClass objcClass
hi link objcSubclass objcClass
hi link objcSuperclass objcClass
hi link objcDirective rubyClass
hi link objcStatement Constant
hi link cocoaFunction Function
hi link objcMethodName Identifier
hi link objcMethodArg Normal
hi link objcMessageName Identifier
hi link vimOper Normal
hi link htmlTag Statement
hi link htmlEndTag htmlTag
hi link htmlTagName htmlTag
hi link xmlTag Statement
hi link xmlEndTag xmlTag
hi link xmlTagName xmlTag
hi link xmlEqual xmlTag
hi link xmlEntity Special
hi link xmlEntityPunct xmlEntity
hi link xmlDocTypeDecl PreProc
hi link xmlDocTypeKeyword PreProc
hi link xmlProcessingDelim xmlAttrib
hi clear xmlAttrib
hi DbgCurrent ctermfg=195 ctermbg=25 guifg=#DEEBFE guibg=#345FA8
hi DbgBreakPt ctermbg=53 guibg=#4F0037
hi IndentGuidesOdd ctermbg=235 guibg=#232323
hi IndentGuidesEven ctermbg=234 guibg=#1b1b1b
hi link TagListFileName Directory
hi PreciseJumpTarget ctermfg=155 ctermbg=22 guifg=#B9ED67 guibg=#405026
hi link ExchangeRegion IncSearch
hi link _exchange_region ExchangeRegion
hi link vimTodo Todo
hi link vimCommand Statement
hi clear vimStdPlugin
hi link vimOption PreProc
hi link vimErrSetting vimError
hi link vimAutoEvent Type
hi link vimGroup Type
hi link vimHLGroup vimGroup
hi link vimFuncName Function
hi clear vimGlobal
hi link vimSubst vimCommand
hi link vimNumber Number
hi link vimAddress vimMark
hi link vimAutoCmd vimCommand
hi clear vimIsCommand
hi clear vimExtCmd
hi clear vimFilter
hi link vimLet vimCommand
hi link vimMap vimCommand
hi link vimMark Number
hi clear vimSet
hi link vimSyntax vimCommand
hi clear vimUserCmd
hi clear vimCmdSep
hi link vimVar Identifier
hi link vimFBVar vimVar
hi link vimInsert vimString
hi link vimBehaveModel vimBehave
hi link vimBehaveError vimError
hi link vimBehave vimCommand
hi link vimFTCmd vimCommand
hi link vimFTOption vimSynType
hi link vimFTError vimError
hi clear vimFiletype
hi clear vimAugroup
hi clear vimExecute
hi link vimNotFunc vimCommand
hi clear vimFunction
hi link vimFunctionError vimError
hi link vimLineComment vimComment
hi link vimSpecFile Identifier
hi clear vimOperParen
hi link vimComment Comment
hi link vimString String
hi link vimRegister SpecialChar
hi link vimCmplxRepeat SpecialChar
hi clear vimRegion
hi clear vimSynLine
hi link vimNotation Special
hi link vimCtrlChar SpecialChar
hi link vimFuncVar Identifier
hi link vimContinue Special
hi clear vimSetEqual
hi link vimAugroupKey vimCommand
hi link vimAugroupError vimError
hi link vimEnvvar PreProc
hi link vimFunc vimError
hi link vimParenSep Delimiter
hi link vimSep Delimiter
hi link vimOperError Error
hi link vimFuncKey vimCommand
hi link vimFuncSID Special
hi link vimAbb vimCommand
hi clear vimEcho
hi link vimEchoHL vimCommand
hi clear vimIf
hi link vimHighlight vimCommand
hi link vimNorm vimCommand
hi link vimUnmap vimMap
hi link vimUserCommand vimCommand
hi clear vimFuncBody
hi clear vimFuncBlank
hi link vimPattern Type
hi link vimSpecFileMod vimSpecFile
hi clear vimEscapeBrace
hi link vimSetString vimString
hi clear vimSubstRep
hi clear vimSubstRange
hi link vimUserAttrb vimSpecial
hi link vimUserAttrbError Error
hi link vimUserAttrbKey vimOption
hi link vimUserAttrbCmplt vimSpecial
hi link vimUserCmdError Error
hi link vimUserAttrbCmpltFunc Special
hi link vimCommentString vimString
hi link vimPatSepErr vimPatSep
hi link vimPatSep SpecialChar
hi link vimPatSepZ vimPatSep
hi link vimPatSepZone vimString
hi link vimPatSepR vimPatSep
hi clear vimPatRegion
hi link vimNotPatSep vimString
hi link vimStringCont vimString
hi link vimSubstTwoBS vimString
hi link vimSubstSubstr SpecialChar
hi clear vimCollection
hi clear vimSubstPat
hi link vimSubst1 vimSubst
hi link vimSubstDelim Delimiter
hi clear vimSubstRep4
hi link vimSubstFlagErr vimError
hi clear vimCollClass
hi link vimCollClassErr vimError
hi link vimSubstFlags Special
hi link vimMarkNumber vimNumber
hi link vimPlainMark vimMark
hi link vimPlainRegister vimRegister
hi link vimSetMod vimOption
hi link vimSetSep Statement
hi link vimMapMod vimBracket
hi clear vimMapLhs
hi clear vimAutoCmdSpace
hi clear vimAutoEventList
hi clear vimAutoCmdSfxList
hi link vimEchoHLNone vimGroup
hi link vimMapBang vimCommand
hi clear vimMapRhs
hi link vimMapModKey vimFuncSID
hi link vimMapModErr vimError
hi clear vimMapRhsExtend
hi clear vimMenuBang
hi clear vimMenuPriority
hi link vimMenuName PreProc
hi link vimMenuMod vimMapMod
hi link vimMenuNameMore vimMenuName
hi clear vimMenuMap
hi clear vimMenuRhs
hi link vimBracket Delimiter
hi link vimUserFunc Normal
hi link vimElseIfErr Error
hi link vimBufnrWarn vimWarn
hi clear vimNormCmds
hi link vimGroupSpecial Special
hi clear vimGroupList
hi link vimSynError Error
hi link vimSynContains vimSynOption
hi link vimSynKeyContainedin vimSynContains
hi link vimSynNextgroup vimSynOption
hi link vimSynType vimSpecial
hi clear vimAuSyntax
hi link vimSynCase Type
hi link vimSynCaseError vimError
hi clear vimClusterName
hi link vimGroupName vimGroup
hi link vimGroupAdd vimSynOption
hi link vimGroupRem vimSynOption
hi clear vimIskList
hi link vimIskSep Delimiter
hi link vimSynKeyOpt vimSynOption
hi clear vimSynKeyRegion
hi link vimMtchComment vimComment
hi link vimSynMtchOpt vimSynOption
hi link vimSynRegPat vimString
hi clear vimSynMatchRegion
hi clear vimSynMtchCchar
hi clear vimSynMtchGroup
hi link vimSynPatRange vimString
hi link vimSynNotPatRange vimSynRegPat
hi link vimSynRegOpt vimSynOption
hi link vimSynReg Type
hi link vimSynMtchGrp vimSynOption
hi clear vimSynRegion
hi clear vimSynPatMod
hi link vimSyncC Type
hi clear vimSyncLines
hi clear vimSyncMatch
hi link vimSyncError Error
hi clear vimSyncLinebreak
hi clear vimSyncLinecont
hi clear vimSyncRegion
hi link vimSyncGroupName vimGroupName
hi link vimSyncKey Type
hi link vimSyncGroup vimGroupName
hi link vimSyncNone Type
hi clear vimHiLink
hi link vimHiClear vimHighlight
hi clear vimHiKeyList
hi link vimHiCtermError vimError
hi clear vimHiBang
hi link vimHiGroup vimGroupName
hi link vimHiAttrib PreProc
hi link vimFgBgAttrib vimHiAttrib
hi link vimHiAttribList vimError
hi clear vimHiCtermColor
hi clear vimHiFontname
hi clear vimHiGuiFontname
hi link vimHiGuiRgb vimNumber
hi link vimHiTerm Type
hi link vimHiCTerm vimHiTerm
hi link vimHiStartStop vimHiTerm
hi link vimHiCtermFgBg vimHiTerm
hi link vimHiGui vimHiTerm
hi link vimHiGuiFont vimHiTerm
hi link vimHiGuiFgBg vimHiTerm
hi link vimHiKeyError vimError
hi clear vimHiTermcap
hi link vimHiNmbr Number
hi link vimCommentTitle PreProc
hi clear vimCommentTitleLeader
hi link vimSearchDelim Statement
hi link vimSearch vimString
hi link vimEmbedError vimError
hi clear vimPythonRegion
hi link pythonStatement Statement
hi link pythonFunction Function
hi link pythonConditional Conditional
hi link pythonRepeat Repeat
hi link pythonException Exception
hi link pythonInclude Include
hi link pythonAsync Statement
hi link pythonDecorator Define
hi link pythonDecoratorName Function
hi link pythonDoctestValue Define
hi clear pythonMatrixMultiply
hi link pythonTodo Todo
hi link pythonComment Comment
hi link pythonQuotes String
hi link pythonEscape Special
hi link pythonString String
hi link pythonTripleQuotes pythonQuotes
hi link pythonSpaceError Error
hi link pythonDoctest Special
hi link pythonRawString String
hi link pythonNumber Number
hi link pythonBuiltin Function
hi clear pythonAttribute
hi link pythonExceptions Structure
hi clear pythonSync
hi link vimScriptDelim Comment
hi clear vimAugroupSyncA
hi link vimError Error
hi link vimKeyCodeError vimError
hi link vimWarn WarningMsg
hi link vimAuHighlight vimHighlight
hi link vimAutoCmdOpt vimOption
hi link vimAutoSet vimCommand
hi link vimCondHL vimCommand
hi link vimElseif vimCondHL
hi link vimFold Folded
hi link vimSynOption Special
hi link vimHLMod PreProc
hi link vimKeyCode vimSpecFile
hi link vimKeyword Statement
hi link vimSpecial Type
hi link vimStatement Statement
hi airline_x ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_x_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_x_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_y ctermfg=231 ctermbg=235 guifg=#ffffff guibg=#262626
hi airline_y_bold term=bold cterm=bold ctermfg=231 ctermbg=235 gui=bold guifg=#ffffff guibg=#262626
hi airline_y_red ctermfg=160 ctermbg=235 guifg=#ff0000 guibg=#262626
hi airline_z ctermfg=189 ctermbg=25 guifg=#d8dee9 guibg=#0d61ac
hi airline_z_bold term=bold cterm=bold ctermfg=189 ctermbg=25 gui=bold guifg=#d8dee9 guibg=#0d61ac
hi airline_z_red ctermfg=160 ctermbg=25 guifg=#ff0000 guibg=#0d61ac
hi airline_term ctermfg=85 ctermbg=232 guifg=#9cffd3 guibg=#202020
hi airline_term_bold term=bold cterm=bold ctermfg=85 ctermbg=232 gui=bold guifg=#9cffd3 guibg=#202020
hi airline_term_red ctermfg=160 ctermbg=232 guifg=#ff0000 guibg=#202020
hi airline_error ctermfg=232 ctermbg=160 guifg=#000000 guibg=#990000
hi airline_error_bold term=bold cterm=bold ctermfg=232 ctermbg=160 gui=bold guifg=#000000 guibg=#990000
hi airline_error_red ctermfg=160 ctermbg=160 guifg=#ff0000 guibg=#990000
hi airline_a ctermfg=189 ctermbg=25 guifg=#d8dee9 guibg=#0d61ac
hi airline_a_bold term=bold cterm=bold ctermfg=189 ctermbg=25 gui=bold guifg=#d8dee9 guibg=#0d61ac
hi airline_a_red ctermfg=160 ctermbg=25 guifg=#ff0000 guibg=#0d61ac
hi airline_b ctermfg=231 ctermbg=235 guifg=#ffffff guibg=#262626
hi airline_b_bold term=bold cterm=bold ctermfg=231 ctermbg=235 gui=bold guifg=#ffffff guibg=#262626
hi airline_b_red ctermfg=160 ctermbg=235 guifg=#ff0000 guibg=#262626
hi airline_c ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_c_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_c_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_warning ctermfg=232 ctermbg=166 guifg=#000000 guibg=#df5f00
hi airline_warning_bold term=bold cterm=bold ctermfg=232 ctermbg=166 gui=bold guifg=#000000 guibg=#df5f00
hi airline_warning_red ctermfg=160 ctermbg=166 guifg=#ff0000 guibg=#df5f00
hi airline_a_to_airline_b ctermfg=25 ctermbg=235 guifg=#0d61ac guibg=#262626
hi airline_b_to_airline_c ctermfg=235 ctermbg=233 guifg=#262626 guibg=#151515
hi airline_c_to_airline_x ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_x_to_airline_y ctermfg=235 ctermbg=233 guifg=#262626 guibg=#151515
hi airline_y_to_airline_z ctermfg=25 ctermbg=235 guifg=#0d61ac guibg=#262626
hi airline_c1_inactive ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_b_to_airline_c_bold term=bold cterm=bold ctermfg=235 ctermbg=233 gui=bold guifg=#262626 guibg=#151515
hi airline_b_to_airline_c_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_y_to_airline_z_bold term=bold cterm=bold ctermfg=25 ctermbg=235 gui=bold guifg=#0d61ac guibg=#262626
hi airline_y_to_airline_z_red ctermfg=160 ctermbg=235 guifg=#ff0000 guibg=#262626
hi airline_c_to_airline_x_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c_to_airline_x_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_x_to_airline_y_bold term=bold cterm=bold ctermfg=235 ctermbg=233 gui=bold guifg=#262626 guibg=#151515
hi airline_x_to_airline_y_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_a_to_airline_b_bold term=bold cterm=bold ctermfg=25 ctermbg=235 gui=bold guifg=#0d61ac guibg=#262626
hi airline_a_to_airline_b_red ctermfg=160 ctermbg=235 guifg=#ff0000 guibg=#262626
hi link UtlUrl Underlined
hi clear UtlTag
hi link YcmErrorSign Error
hi link YcmWarningSign Todo
hi link YcmErrorLine SyntasticErrorLine
hi clear SyntasticErrorLine
hi link YcmWarningLine SyntasticWarningLine
hi clear SyntasticWarningLine
hi link YcmErrorSection SpellBad
hi link YcmWarningSection SpellCap
hi airline_c1_to_airline_x ctermfg=233 guifg=#151515 guibg=#151515
hi airline_c2_inactive ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_x_inactive ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_x_inactive_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_x_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_y_inactive ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_y_inactive_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_y_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_z_inactive ctermfg=243 ctermbg=235 guifg=#666666 guibg=#262626
hi airline_z_inactive_bold term=bold cterm=bold ctermfg=243 ctermbg=235 gui=bold guifg=#666666 guibg=#262626
hi airline_z_inactive_red ctermfg=160 ctermbg=235 guifg=#ff0000 guibg=#262626
hi airline_term_inactive ctermfg=85 ctermbg=232 guifg=#9cffd3 guibg=#202020
hi airline_term_inactive_bold term=bold cterm=bold ctermfg=85 ctermbg=232 gui=bold guifg=#9cffd3 guibg=#202020
hi airline_term_inactive_red ctermfg=160 ctermbg=232 guifg=#ff0000 guibg=#202020
hi airline_error_inactive ctermfg=232 ctermbg=160 guifg=#000000 guibg=#990000
hi airline_error_inactive_bold term=bold cterm=bold ctermfg=232 ctermbg=160 gui=bold guifg=#000000 guibg=#990000
hi airline_error_inactive_red ctermfg=160 ctermbg=160 guifg=#ff0000 guibg=#990000
hi airline_a_inactive ctermfg=243 ctermbg=235 guifg=#666666 guibg=#262626
hi airline_a_inactive_bold term=bold cterm=bold ctermfg=243 ctermbg=235 gui=bold guifg=#666666 guibg=#262626
hi airline_a_inactive_red ctermfg=160 ctermbg=235 guifg=#ff0000 guibg=#262626
hi airline_b_inactive ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_b_inactive_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_b_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c1_inactive_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_c1_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_warning_inactive ctermfg=232 ctermbg=166 guifg=#000000 guibg=#df5f00
hi airline_warning_inactive_bold term=bold cterm=bold ctermfg=232 ctermbg=166 gui=bold guifg=#000000 guibg=#df5f00
hi airline_warning_inactive_red ctermfg=160 ctermbg=166 guifg=#ff0000 guibg=#df5f00
hi airline_x_to_airline_y_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c1_to_airline_x_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c_to_airline_x_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_a_to_airline_b_inactive ctermfg=235 ctermbg=233 guifg=#262626 guibg=#151515
hi airline_y_to_airline_z_inactive ctermfg=235 ctermbg=233 guifg=#262626 guibg=#151515
hi airline_b_to_airline_c_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c1_to_airline_x_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c1_to_airline_x_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c2_to_airline_x ctermfg=233 guifg=#151515 guibg=#151515
hi airline_c1_to_airline_x_inactive_inactive guifg=#151515 guibg=#151515
hi airline_c1_to_airline_x_inactive_inactive_bold term=bold cterm=bold gui=bold guifg=#151515 guibg=#151515
hi airline_c1_to_airline_x_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c_to_airline_x_inactive_inactive guifg=#151515 guibg=#151515
hi airline_c_to_airline_x_inactive_inactive_bold term=bold cterm=bold gui=bold guifg=#151515 guibg=#151515
hi airline_c_to_airline_x_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_a_to_airline_b_inactive_inactive guifg=#262626 guibg=#151515
hi airline_a_to_airline_b_inactive_inactive_bold term=bold cterm=bold gui=bold guifg=#262626 guibg=#151515
hi airline_a_to_airline_b_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_x_to_airline_y_inactive_inactive guifg=#151515 guibg=#151515
hi airline_x_to_airline_y_inactive_inactive_bold term=bold cterm=bold gui=bold guifg=#151515 guibg=#151515
hi airline_x_to_airline_y_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c_inactive_inactive guifg=#151515 guibg=#151515
hi airline_b_to_airline_c_inactive_inactive_bold term=bold cterm=bold gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_y_to_airline_z_inactive_inactive guifg=#262626 guibg=#151515
hi airline_y_to_airline_z_inactive_inactive_bold term=bold cterm=bold gui=bold guifg=#262626 guibg=#151515
hi airline_y_to_airline_z_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c2_inactive_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_c2_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c2_to_airline_x_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c2_to_airline_x_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c2_to_airline_x_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c2_to_airline_x_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c_inactive ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_c_inactive_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_c_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c2_to_airline_x_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c2_to_airline_x_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi link helpHeadline Statement
hi link helpSectionDelim PreProc
hi link helpIgnore Ignore
hi link helpExample Comment
hi link helpBar Ignore
hi link helpStar Ignore
hi link helpHyperTextJump Identifier
hi link helpHyperTextEntry String
hi link helpBacktick Ignore
hi clear helpNormal
hi link helpVim Identifier
hi link helpOption Type
hi link helpCommand Comment
hi link helpHeader PreProc
hi clear helpGraphic
hi link helpNote Todo
hi link helpWarning Todo
hi link helpDeprecated Todo
hi link helpSpecial Special
hi clear helpLeadBlank
hi link helpNotVi Special
hi link helpComment Comment
hi link helpConstant Constant
hi link helpString String
hi link helpCharacter Character
hi link helpNumber Number
hi link helpBoolean Boolean
hi link helpFloat Float
hi link helpIdentifier Identifier
hi link helpFunction Function
hi link helpStatement Statement
hi link helpConditional Conditional
hi link helpRepeat Repeat
hi link helpLabel Label
hi link helpOperator Operator
hi link helpKeyword Keyword
hi link helpException Exception
hi link helpPreProc PreProc
hi link helpInclude Include
hi link helpDefine Define
hi link helpMacro Macro
hi link helpPreCondit PreCondit
hi link helpType Type
hi link helpStorageClass StorageClass
hi link helpStructure Structure
hi link helpTypedef Typedef
hi link helpSpecialChar SpecialChar
hi link helpTag Tag
hi link helpDelimiter Delimiter
hi link helpSpecialComment SpecialComment
hi link helpDebug Debug
hi link helpUnderlined Underlined
hi link helpError Error
hi link helpTodo Todo
hi link helpURL String
hi link scalaKeyword Keyword
hi link scalaOperator Normal
hi link scalaPackage Include
hi clear scalaFqn
hi link scalaImport Include
hi clear scalaFqnSet
hi link scalaBoolean Boolean
hi link scalaDef Keyword
hi link scalaDefName Function
hi link scalaVal Keyword
hi clear scalaValName
hi link scalaVar Keyword
hi clear scalaVarName
hi link scalaClass Keyword
hi link scalaClassName Special
hi link scalaObject Keyword
hi link scalaTrait Keyword
hi link scalaDefSpecializer Function
hi link scalaClassSpecializer Special
hi link scalaConstructorSpecializer scalaConstructor
hi link scalaConstructor Special
hi clear scalaRoot
hi clear scalaMethodCall
hi link scalaType Type
hi link scalaTodo Todo
hi link scalaLineComment Comment
hi link scalaComment Comment
hi link htmlError Error
hi link htmlSpecialChar Special
hi link javaScriptExpression javaScript
hi link htmlString String
hi link htmlValue String
hi clear htmlTagN
hi link htmlTagError htmlError
hi link htmlArg Type
hi link htmlEvent javaScript
hi link htmlCssDefinition Special
hi link htmlSpecialTagName Exception
hi link htmlCommentPart Comment
hi link htmlCommentError htmlError
hi link htmlComment Comment
hi link htmlPreStmt PreProc
hi link htmlPreError Error
hi link htmlPreAttr String
hi link htmlPreProc PreProc
hi link htmlPreProcAttrError Error
hi link htmlPreProcAttrName PreProc
hi link htmlLink Underlined
hi clear javaScript
hi htmlBoldUnderline term=bold,underline cterm=bold,underline gui=bold,underline
hi htmlBoldItalic term=bold,italic cterm=bold,italic gui=bold,italic
hi htmlBold term=bold cterm=bold gui=bold
hi htmlBoldUnderlineItalic term=bold,underline,italic cterm=bold,underline,italic gui=bold,underline,italic
hi link htmlBoldItalicUnderline htmlBoldUnderlineItalic
hi link htmlUnderlineBold htmlBoldUnderline
hi htmlUnderlineItalic term=underline,italic cterm=underline,italic gui=underline,italic
hi htmlUnderline term=underline cterm=underline gui=underline
hi link htmlUnderlineBoldItalic htmlBoldUnderlineItalic
hi link htmlUnderlineItalicBold htmlBoldUnderlineItalic
hi link htmlItalicBold htmlBoldItalic
hi link htmlItalicUnderline htmlUnderlineItalic
hi htmlItalic term=italic cterm=italic gui=italic
hi link htmlItalicBoldUnderline htmlBoldUnderlineItalic
hi link htmlItalicUnderlineBold htmlBoldUnderlineItalic
hi link htmlH1 Title
hi link htmlH2 htmlH1
hi link htmlH3 htmlH2
hi link htmlH4 htmlH3
hi link htmlH5 htmlH4
hi link htmlH6 htmlH5
hi link htmlTitle Title
hi clear cssStyle
hi link htmlHead PreProc
hi link javaScriptCommentTodo Todo
hi link javaScriptLineComment Comment
hi clear javaScriptCommentSkip
hi link javaScriptComment Comment
hi link javaScriptSpecial Special
hi link javaScriptStringD String
hi link javaScriptStringS String
hi link javaScriptSpecialCharacter javaScriptSpecial
hi link javaScriptNumber javaScriptValue
hi link javaScriptConditional Conditional
hi link javaScriptRepeat Repeat
hi link javaScriptBranch Conditional
hi link javaScriptOperator Operator
hi link javaScriptType Type
hi link javaScriptStatement Statement
hi link javaScriptBoolean Boolean
hi link javaScriptNull Keyword
hi link javaScriptIdentifier Identifier
hi link javaScriptLabel Label
hi link javaScriptException Exception
hi link javaScriptMessage Keyword
hi link javaScriptGlobal Keyword
hi link javaScriptMember Keyword
hi link javaScriptDeprecated Exception
hi link javaScriptReserved Keyword
hi link javaScriptFunction Function
hi link javaScriptBraces Function
hi clear javaScriptParens
hi link javaScriptCharacter Character
hi link javaScriptError Error
hi link javaScrParenError javaScriptError
hi link javaScriptDebug Debug
hi link javaScriptConstant Label
hi link jsNoise Noise
hi clear jsObjectProp
hi link jsFuncCall Function
hi link jsPrototype Special
hi link jsTaggedTemplate StorageClass
hi link jsDot Noise
hi link jsParensError Error
hi link jsStorageClass StorageClass
hi clear jsDestructuringBlock
hi clear jsDestructuringArray
hi clear jsVariableDef
hi clear jsFlowDefinition
hi link jsOperatorKeyword jsOperator
hi link jsOperator Operator
hi link jsBooleanTrue Boolean
hi link jsBooleanFalse Boolean
hi link jsImport Include
hi link jsModuleAsterisk Noise
hi clear jsModuleKeyword
hi clear jsModuleGroup
hi clear jsFlowImportType
hi link jsExport Include
hi link jsExportDefault StorageClass
hi clear jsFlowTypeStatement
hi link jsModuleAs Include
hi link jsFrom Include
hi link jsModuleComma jsNoise
hi link jsExportDefaultGroup jsExportDefault
hi link jsString String
hi clear jsFlowTypeKeyword
hi link jsSpecial Special
hi clear jsTemplateExpression
hi link jsTemplateString String
hi link jsNumber Number
hi link jsFloat Float
hi link jsTemplateBraces Noise
hi link jsRegexpCharClass Character
hi link jsRegexpBoundary SpecialChar
hi link jsRegexpBackRef SpecialChar
hi link jsRegexpQuantifier SpecialChar
hi link jsRegexpOr Conditional
hi link jsRegexpMod SpecialChar
hi link jsRegexpGroup jsRegexpString
hi link jsRegexpString String
hi link jsObjectSeparator Noise
hi link jsObjectShorthandProp jsObjectKey
hi clear jsFunctionKey
hi clear jsObjectValue
hi clear jsObjectKey
hi link jsObjectKeyString String
hi link jsBrackets Noise
hi clear jsFuncArgs
hi clear jsObjectKeyComputed
hi link jsObjectColon jsNoise
hi link jsObjectFuncName Function
hi link jsObjectMethodType Type
hi link jsObjectStringKey String
hi link jsNull Type
hi link jsReturn Statement
hi link jsUndefined Type
hi link jsNan Number
hi link jsThis Special
hi link jsSuper Constant
hi clear jsBlock
hi link jsBlockLabel Identifier
hi link jsBlockLabelKey jsBlockLabel
hi link jsStatement Statement
hi link jsConditional Conditional
hi clear jsParenIfElse
hi link jsCommentIfElse jsComment
hi clear jsIfElseBlock
hi clear jsParenSwitch
hi link jsRepeat Repeat
hi clear jsParenRepeat
hi link jsForAwait Keyword
hi link jsDo Repeat
hi clear jsRepeatBlock
hi link jsLabel Label
hi link jsSwitchColon Noise
hi clear jsSwitchCase
hi link jsTry Exception
hi clear jsTryCatchBlock
hi link jsFinally Exception
hi clear jsFinallyBlock
hi link jsCatch Exception
hi clear jsParenCatch
hi link jsException Exception
hi link jsAsyncKeyword Keyword
hi clear jsSwitchBlock
hi link jsGlobalObjects Constant
hi link jsGlobalNodeObjects Constant
hi link jsExceptions Constant
hi link jsBuiltins Constant
hi clear jsFutureKeys
hi link jsDomErrNo Constant
hi link jsDomNodeConsts Constant
hi link jsHtmlEvents Special
hi clear jsSpreadExpression
hi clear jsBracket
hi link jsParens Noise
hi clear jsParen
hi link jsParensDecorator jsParens
hi clear jsParenDecorator
hi link jsParensIfElse jsParens
hi link jsParensRepeat jsParens
hi link jsCommentRepeat jsComment
hi link jsParensSwitch jsParens
hi link jsParensCatch jsParens
hi link jsFuncParens Noise
hi clear jsFuncArgCommas
hi link jsComment Comment
hi clear jsFuncArgExpression
hi link jsRestExpression jsFuncArgs
hi clear jsFlowArgumentDef
hi link jsCommentFunction jsComment
hi clear jsFuncBlock
hi clear jsFlowReturn
hi link jsClassBraces Noise
hi link jsClassFuncName jsFuncName
hi link jsClassMethodType Type
hi link jsArrowFunction Type
hi link jsArrowFuncArgs jsFuncArgs
hi link jsGenerator jsFunction
hi link jsDecorator Special
hi link jsClassProperty jsObjectKey
hi clear jsClassPropertyComputed
hi link jsClassStringKey String
hi clear jsClassBlock
hi link jsFuncBraces Noise
hi link jsIfElseBraces Noise
hi link jsTryCatchBraces Noise
hi link jsFinallyBraces Noise
hi link jsSwitchBraces Noise
hi link jsRepeatBraces Noise
hi link jsDestructuringBraces Noise
hi link jsDestructuringProperty jsFuncArgs
hi link jsDestructuringAssignment jsObjectKey
hi link jsDestructuringNoise Noise
hi clear jsDestructuringPropertyComputed
hi clear jsDestructuringPropertyValue
hi link jsObjectBraces Noise
hi clear jsObject
hi link jsBraces Noise
hi link jsModuleBraces Noise
hi link jsSpreadOperator Operator
hi link jsRestOperator Operator
hi link jsTernaryIfOperator Operator
hi clear jsTernaryIf
hi link jsFuncName Function
hi clear jsFlowFunctionGroup
hi link jsFuncArgOperator jsFuncArgs
hi link jsArguments Special
hi link jsFunction Type
hi link jsClassKeyword Keyword
hi link jsExtendsKeyword Keyword
hi link jsClassNoise Noise
hi clear jsFlowClassFunctionGroup
hi clear jsFlowClassGroup
hi link jsCommentClass jsComment
hi link jsClassDefinition jsFuncName
hi clear jsClassValue
hi clear jsFlowClassDef
hi clear jsDestructuringValue
hi clear jsDestructuringValueAssignment
hi link jsCommentTodo Todo
hi link jsEnvComment PreProc
hi link jsDecoratorFunction Function
hi link jsCharacter Character
hi link jsBranch Conditional
hi link jsError Error
hi link jsOf Operator
hi clear Noise
hi link jsDomElemAttrs Label
hi link jsDomElemFuncs PreProc
hi link jsHtmlElemAttrs Label
hi link jsHtmlElemFuncs PreProc
hi link jsCssStyles Label
hi link htmlCssStyleComment Comment
hi link htmlScriptTag htmlTag
hi link htmlEventSQ htmlEvent
hi link htmlEventDQ htmlEvent
hi link vbConditional Conditional
hi link vbOperator Operator
hi link vbBoolean Boolean
hi link vbConst Constant
hi link vbRepeat Repeat
hi link vbEvents Special
hi link vbFunction Identifier
hi link vbMethods PreProc
hi link vbStatement Statement
hi link vbKeyword Statement
hi link vbTodo Todo
hi link vbTypes Type
hi link vbDefine Constant
hi link vbNumber Number
hi link vbFloat Float
hi link vbString String
hi link vbComment Comment
hi link vbLineNumber Comment
hi link vbTypeSpecifier Type
hi link vbError Error
hi link vbIdentifier Identifier
hi link cssTagName Statement
hi clear cssDefinition
hi link cssSelectorOp Special
hi link cssSelectorOp2 Special
hi link cssUnicodeEscape Special
hi link cssStringQ String
hi link cssStringQQ String
hi clear cssAttributeSelector
hi link cssIdentifier Function
hi link cssMediaType Special
hi link cssMedia Special
hi link cssMediaComma Normal
hi clear cssMediaBlock
hi link cssBraces Function
hi link cssError Error
hi link cssComment Comment
hi link cssURL String
hi link cssValueInteger Number
hi link cssValueNumber Number
hi link cssValueLength Number
hi link cssValueAngle Number
hi link cssValueTime Number
hi link cssValueFrequency Number
hi clear cssFontDescriptorBlock
hi link cssFontDescriptor Special
hi link cssFontProp StorageClass
hi link cssFontAttr Type
hi link cssCommonAttr Type
hi link cssFontDescriptorProp StorageClass
hi link cssFontDescriptorFunction Constant
hi link cssUnicodeRange Constant
hi link cssFontDescriptorAttr Type
hi link cssFunctionName Function
hi link cssColor Constant
hi link cssFunction Constant
hi link cssImportant Special
hi link cssColorProp StorageClass
hi link cssColorAttr Type
hi link cssTextProp StorageClass
hi link cssTextAttr Type
hi link cssBoxProp StorageClass
hi link cssBoxAttr Type
hi link cssGeneratedContentProp StorageClass
hi link cssGeneratedContentAttr Type
hi link cssAuralAttr Type
hi link cssPagingProp StorageClass
hi link cssPagingAttr Type
hi link cssUIProp StorageClass
hi link cssUIAttr Type
hi link cssRenderAttr Type
hi link cssRenderProp StorageClass
hi link cssAuralProp StorageClass
hi link cssTableProp StorageClass
hi link cssTableAttr Type
hi link cssInclude Include
hi link cssBraceError Error
hi link cssPseudoClassId PreProc
hi clear cssPseudoClass
hi link cssPseudoClassLang Constant
hi clear cssSpecialCharQQ
hi clear cssSpecialCharQ
hi link cssClassName Function
hi clear cssLength
hi clear cssString
hi link htmlStyleArg htmlString
hi clear htmlHighlight
hi clear htmlHighlightSkip
hi link htmlStatement Statement
hi link htmlSpecial Special
hi link coffeeStatement Statement
hi link coffeeRepeat Repeat
hi link coffeeConditional Conditional
hi link coffeeException Exception
hi link coffeeKeyword Keyword
hi link coffeeOperator Operator
hi link coffeeExtendedOp coffeeOperator
hi link coffeeSpecialOp SpecialChar
hi link coffeeBoolean Boolean
hi link coffeeGlobal Type
hi link coffeeSpecialVar Special
hi link coffeeSpecialIdent Identifier
hi link coffeeObject Structure
hi link coffeeConstant Constant
hi link coffeeEscape SpecialChar
hi clear coffeeInterp
hi link coffeeString String
hi link coffeeNumber Number
hi link coffeeFloat Float
hi link coffeeReservedError Error
hi link coffeeObjAssign Identifier
hi link coffeeTodo Todo
hi link coffeeComment Comment
hi link coffeeBlockComment coffeeComment
hi link coffeeHeregexComment coffeeComment
hi link coffeeEmbedDelim Delimiter
hi clear coffeeEmbed
hi link coffeeInterpDelim PreProc
hi link coffeeRegexCharSet coffeeRegex
hi link coffeeRegex String
hi link coffeeHeregexCharSet coffeeHeregex
hi link coffeeHeregex coffeeRegex
hi link coffeeHeredoc String
hi link coffeeSpaceError Error
hi link coffeeSemicolonError Error
hi link coffeeDotAccess coffeeExtendedOp
hi link coffeeProtoAccess coffeeExtendedOp
hi link coffeeCurly coffeeBlock
hi clear coffeeCurlies
hi link coffeeBracket coffeeBlock
hi clear coffeeBrackets
hi link coffeeParen coffeeBlock
hi clear coffeeParens
hi link coffeeBlock coffeeSpecialOp
hi link cjsxEntityPunct Type
hi link cjsxEntity Statement
hi link cjsxAttribProperty Type
hi clear cjsxAttrib
hi link cjsxElement Function
hi clear cjsxBody
hi clear cjsxOpenTag
hi link cjsxTagName Function
hi clear coffeeScript
hi link glslConditional Conditional
hi link glslRepeat Repeat
hi link glslStatement Statement
hi link glslTodo Todo
hi link glslCommentL glslComment
hi link glslCommentStart glslComment
hi link glslComment Comment
hi link glslPreCondit PreCondit
hi link glslDefine Define
hi link glslTokenConcat glslPreProc
hi link glslPredefinedMacro Macro
hi link glslPreProc PreProc
hi link glslBoolean Boolean
hi link glslDecimalInt glslInteger
hi link glslOctalInt glslInteger
hi link glslHexInt glslInteger
hi link glslFloat Float
hi link glslSwizzle Identifier
hi link glslStructure Structure
hi link glslIdentifier Identifier
hi link glslIdentifierPrime glslIdentifier
hi link glslType Type
hi link glslQualifier StorageClass
hi link glslBuiltinConstant Constant
hi link glslBuiltinVariable Identifier
hi link glslBuiltinFunction Function
hi link glslInteger Number
hi clear ShaderScript
hi clear lessDefinition
hi link lessComment Comment
hi clear lessClassChar
hi link lessVariable Special
hi link lessMixinChar Special
hi link lessAmpersandChar Special
hi link lessFunction Function
hi clear lessNestedSelector
hi clear lessVariableAssignment
hi link lessVariableValue Constant
hi clear lessOperator
hi link lessDefault Special
hi link lessNestedProperty Type
hi link lessClass PreProc
hi clear lessStyle
hi link scalaDocTags Special
hi link scalaDocComment Comment
hi link scalaEmptyString String
hi link scalaUnicode Special
hi link scalaMultiLineString String
hi link scalaStringEscape Special
hi link scalaString String
hi link scalaSymbol Special
hi link scalaChar String
hi link scalaNumber Number
hi link scalaXmlQuote Special
hi link scalaXmlEscape Normal
hi link scalaXmlString String
hi link scalaXmlTag Include
hi link scalaXmlStart Include
hi link scalaXml String
hi link scalaXmlComment Comment
hi link scalaXmlEscapeSpecial Special
hi link scalaTypeSpecializer scalaType
hi clear rgnScala
hi airline_c3_inactive ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_b_to_airline_c3 guifg=#262626 guibg=#151515
hi airline_c3_to_airline_x ctermfg=233 guifg=#151515 guibg=#151515
hi airline_c3_inactive_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_c3_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c3_to_airline_x_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_b_to_airline_c3_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c3_to_airline_x_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c3_to_airline_x_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c3_to_airline_x_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c3_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_b_to_airline_c3_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c3_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c3_bold term=bold cterm=bold gui=bold guifg=#262626 guibg=#151515
hi airline_b_to_airline_c3_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c3_to_airline_x_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c3_to_airline_x_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c3_to_airline_x_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c3_to_airline_x_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c2_to_airline_x_inactive_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c2_to_airline_x_inactive_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_a_to_airline_b_inactive_bold term=bold cterm=bold ctermfg=235 ctermbg=233 gui=bold guifg=#262626 guibg=#151515
hi airline_a_to_airline_b_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c_to_airline_x_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c_to_airline_x_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_x_to_airline_y_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_x_to_airline_y_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c3_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c3_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c1_to_airline_x_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c1_to_airline_x_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_y_to_airline_z_inactive_bold term=bold cterm=bold ctermfg=235 ctermbg=233 gui=bold guifg=#262626 guibg=#151515
hi airline_y_to_airline_z_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi link plugNumber Number
hi link plug1 Title
hi link plugBracket Structure
hi link plugX Exception
hi link plug2 Repeat
hi link plugDash Special
hi link plugPlus Constant
hi link plugStar Boolean
hi link plugMessage Function
hi link plugName Label
hi link plugSha Identifier
hi link plugTag Constant
hi link plugInstall Function
hi link plugUpdate Type
hi link plugRelDate Comment
hi link plugEdge PreProc
hi clear plugCommit
hi link plugNotLoaded Comment
hi link plugError Error
hi link plugDeleted Ignore
hi link plugH2 Type
hi clear airline_c4_inactive
hi clear airline_c5_inactive
hi airline_b_to_airline_c5 guifg=#262626 guibg=#151515
hi airline_c5_to_airline_x ctermfg=233 guifg=#151515 guibg=#151515
hi clear airline_c5_inactive_bold
hi clear airline_c5_inactive_red
hi airline_b_to_airline_c5_inactive ctermfg=233 guifg=#151515 guibg=#151515
hi airline_c5_to_airline_x_inactive ctermfg=233 guifg=#151515 guibg=#151515
hi airline_b_to_airline_c5_bold term=bold cterm=bold gui=bold guifg=#262626 guibg=#151515
hi airline_b_to_airline_c5_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c5_to_airline_x_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c5_to_airline_x_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c5_to_airline_x_inactive_inactive guifg=#151515 guibg=#151515
hi airline_c5_to_airline_x_inactive_inactive_bold term=bold cterm=bold gui=bold guifg=#151515 guibg=#151515
hi airline_c5_to_airline_x_inactive_inactive_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c5_inactive_inactive guifg=#151515 guibg=#151515
hi airline_b_to_airline_c5_inactive_inactive_bold term=bold cterm=bold gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c5_inactive_inactive_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c5_to_airline_x_inactive_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c5_to_airline_x_inactive_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c5_inactive_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c5_inactive_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi clear airline_c6_inactive
hi clear airline_c7_inactive
hi clear airline_c8_inactive
hi airline_b_to_airline_c8 guifg=#262626 guibg=#151515
hi airline_c8_to_airline_x ctermfg=233 guifg=#151515 guibg=#151515
hi clear airline_c8_inactive_bold
hi clear airline_c8_inactive_red
hi airline_b_to_airline_c8_inactive ctermfg=233 guifg=#151515 guibg=#151515
hi airline_c8_to_airline_x_inactive ctermfg=233 guifg=#151515 guibg=#151515
hi airline_c8_to_airline_x_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c8_to_airline_x_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c8_bold term=bold cterm=bold gui=bold guifg=#262626 guibg=#151515
hi airline_b_to_airline_c8_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c8_to_airline_x_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c8_to_airline_x_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c8_to_airline_x_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c8_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_b_to_airline_c8_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c8_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi clear airline_c9_inactive
hi airline_b_to_airline_c9 guifg=#262626 guibg=#151515
hi airline_c9_to_airline_x ctermfg=233 guifg=#151515 guibg=#151515
hi clear airline_c9_inactive_bold
hi clear airline_c9_inactive_red
hi airline_b_to_airline_c9_inactive ctermfg=233 guifg=#151515 guibg=#151515
hi airline_c9_to_airline_x_inactive ctermfg=233 guifg=#151515 guibg=#151515
hi airline_b_to_airline_c9_bold term=bold cterm=bold gui=bold guifg=#262626 guibg=#151515
hi airline_b_to_airline_c9_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c9_to_airline_x_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c9_to_airline_x_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c9_to_airline_x_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c9_to_airline_x_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c9_to_airline_x_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c9_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_b_to_airline_c9_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c9_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c10_inactive ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_b_to_airline_c10 ctermfg=235 guifg=#262626 guibg=#151515
hi airline_c10_to_airline_x ctermfg=233 guifg=#151515 guibg=#151515
hi airline_c10_inactive_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_c10_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c10_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c10_to_airline_x_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c11_inactive ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_c10_to_airline_x_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c10_to_airline_x_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c10_bold term=bold cterm=bold ctermfg=235 gui=bold guifg=#262626 guibg=#151515
hi airline_b_to_airline_c10_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c10_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_b_to_airline_c10_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c10_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c10_to_airline_x_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c10_to_airline_x_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c10_to_airline_x_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c11_to_airline_x ctermfg=233 guifg=#151515 guibg=#151515
hi airline_c11_inactive_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_c11_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c11_to_airline_x_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c11_to_airline_x_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c11_to_airline_x_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c11_to_airline_x_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c11_to_airline_x_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c11_to_airline_x_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c8_inactive_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c8_inactive_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c9_inactive_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c9_inactive_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c9_to_airline_x_inactive_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c9_to_airline_x_inactive_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c10_to_airline_x_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c10_to_airline_x_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c11_to_airline_x_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c11_to_airline_x_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c10_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c10_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c8_to_airline_x_inactive_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c8_to_airline_x_inactive_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c12_inactive ctermfg=59 ctermbg=233 guifg=#4f5b66 guibg=#151515
hi airline_b_to_airline_c12 ctermfg=235 guifg=#262626 guibg=#151515
hi airline_c12_to_airline_x ctermfg=233 guifg=#151515 guibg=#151515
hi airline_c12_inactive_bold term=bold cterm=bold ctermfg=59 ctermbg=233 gui=bold guifg=#4f5b66 guibg=#151515
hi airline_c12_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c12_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c12_to_airline_x_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_b_to_airline_c12_bold term=bold cterm=bold ctermfg=235 gui=bold guifg=#262626 guibg=#151515
hi airline_b_to_airline_c12_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_c12_to_airline_x_bold term=bold cterm=bold ctermfg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c12_to_airline_x_red ctermfg=160 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c12_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_b_to_airline_c12_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c12_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c12_to_airline_x_inactive_inactive ctermfg=233 ctermbg=233 guifg=#151515 guibg=#151515
hi airline_c12_to_airline_x_inactive_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c12_to_airline_x_inactive_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_b_to_airline_c12_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_b_to_airline_c12_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
hi airline_c12_to_airline_x_inactive_bold term=bold cterm=bold ctermfg=233 ctermbg=233 gui=bold guifg=#151515 guibg=#151515
hi airline_c12_to_airline_x_inactive_red ctermfg=160 ctermbg=233 guifg=#ff0000 guibg=#151515
