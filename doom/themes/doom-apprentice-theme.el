;; doom-apprentice-theme.el --- a more Apprentice version of doom-one -*- no-byte-compile: t; -*-
;;; Commentary:
(require 'doom-themes)
;;; Code:
;;
(defgroup doom-apprentice-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-apprentice-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-apprentice-theme
  :type 'boolean)

(defcustom doom-apprentice-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-apprentice-theme
  :type 'boolean)

(defcustom doom-apprentice-comment-bg doom-apprentice-brighter-comments
  "If non-nil, comments will have a subtle, darker background.
Enhancing their legibility."
  :group 'doom-apprentice-theme
  :type 'boolean)

(defcustom doom-apprentice-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-apprentice-theme
  :type '(choice integer boolean))

;; Define names to match original apprentice vim ruby template
(setq  almost_black '("#1c1c1c")
       darker_grey  '("#262626")
       dark_grey    '("#303030")
       grey         '("#444444")
       medium_grey  '("#585858")
       light_grey   '("#6c6c6c")
       lighter_grey '("#bcbcbc")
       white        '("#ffffff")
       purple       '("#5f5f87")
       light_purple '("#8787af")
       green        '("#5f875f")
       light_green  '("#87af87")
       aqua         '("#5f8787")
       light_aqua   '("#5fafaf")
       blue         '("#5f87af")
       light_blue   '("#8fafd7")
       red          '("#af5f5f")
       orange       '("#ff8700")
       ocre         '("#87875f")
       yellow       '("#ffffaf"))

;;
(def-doom-theme doom-apprentice
  "A dark theme based off of xero's Apprentice VIM colorscheme"

  ((bg         darker_grey)
   (bg-alt     darker_grey)
   (base0      almost_black)
   (base1      darker_grey)
   (base2      dark_grey)
   (base3      grey)
   (base4      medium_grey)
   (base5      light_grey)
   (base6      lighter_grey)
   (base7      '("#9ca0a4"))
   (base8      '("#faf4c6"))
   (fg         lighter_grey)
   (fg-alt     medium_grey)

   (grey       light_grey)
   (red        red)
   (orange     orange)
   (green      green)
   (green-br   light_green)
   (teal       '("#578F8F" "#44b9b1" ))
   (yellow     ocre)
   (blue       light_blue)
   (dark-blue  blue)
   (magenta    purple)
   (violet     light_purple)
   (cyan       light_aqua)
   (dark-cyan  aqua)
   ;; face categories
   (highlight      cyan)
   (vertical-bar   base0)
   (selection      base5)
   (builtin        blue)
   (comments       (if doom-apprentice-brighter-comments dark-cyan medium_grey))
   (doc-comments   (if doom-apprentice-brighter-comments (doom-lighten dark-cyan 0.15) (doom-darken grey 0.1)))
   (constants      teal)
   (functions      base8)
   (keywords       blue)
   (methods        magenta)
   (operators      green-br)
   (type           violet)
   (strings        green)
   (variables      base8)
   (numbers        yellow)
   (region         base3)
   (error          red)
   (warning        orange)
   (success        green)
   (vc-modified    yellow)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (hidden-alt `(,(car bg-alt) "black" "black"))
   (-modeline-pad
    (when doom-apprentice-padded-modeline
      (if (integerp doom-apprentice-padded-modeline) doom-apprentice-padded-modeline 4)))

   (modeline-fg     "#bbc2cf")
   (modeline-fg-alt (doom-blend blue grey (if doom-apprentice-brighter-modeline 0.4 0.08)))

   (modeline-bg
    (if doom-apprentice-brighter-modeline
        `("#383f58" ,@(cdr base1))
      `(,(car base3) ,@(cdr base0))))
   (modeline-bg-l
    (if doom-apprentice-brighter-modeline
        modeline-bg
      `(,(doom-darken (car bg) 0.15) ,@(cdr base1))))
   (modeline-bg-inactive   (doom-darken bg 0.20))
   (modeline-bg-inactive-l `(,(doom-darken (car bg-alt) 0.2) ,@(cdr base0))))

  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   (cursor :background blue)
   (font-lock-comment-face
    :foreground comments
    :background (if doom-apprentice-comment-bg (doom-darken bg-alt 0.095)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)
   (mode-line-buffer-id :foreground green-br :bold bold)
   ((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground blue :bold bold)

   (doom-modeline-bar :background (if doom-apprentice-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-path :foreground (if doom-apprentice-brighter-modeline base8 blue) :bold bold)

   (mode-line
    :background base3 :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,base3)))
   (mode-line-inactive
    :background bg-alt :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if doom-apprentice-brighter-modeline base8 highlight))
   (fringe :background base2)
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; notmuch
   (notmuch-wash-cited-text  :foreground comments :background bg)
   (notmuch-message-summary-face  :foreground constants :background bg)
   ;; mu4e
   (mu4e-  :foreground comments :background bg)
   (notmuch-message-summary-face  :foreground constants :background bg)
   ;; general email
   (message-mml  :foreground violet :background bg)

   ;; tooltip and company
   (tooltip              :background bg-alt :foreground fg)
   (company-tooltip-selection     :background base3)

   ;; markdown-mode
   (markdown-header-face :inherit 'bold :foreground red)
   ;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground dark-cyan)
   (rainbow-delimiters-depth-2-face :foreground teal)
   (rainbow-delimiters-depth-3-face :foreground dark-blue)
   (rainbow-delimiters-depth-4-face :foreground green)
   (rainbow-delimiters-depth-5-face :foreground violet)
   (rainbow-delimiters-depth-6-face :foreground green)
   (rainbow-delimiters-depth-7-face :foreground orange)
   ;; org-mode
   ((org-block &override) :background bg-alt)
   ((org-block-begin-line &override) :background bg-alt)
   ((org-block-end-line &override) :background bg-alt)
   (org-hide :foreground hidden)
   (solaire-org-hide-face :foreground hidden-alt)

   ;; rjsx-mode
   (rjsx-tag :foreground blue)
   (rjsx-tag-bracket-face :foreground base8)
   (rjsx-attr :foreground magenta :slant 'italic :weight 'medium)
   )


  ;; --- extra variables --------------------
  ;; ()

  )

;;; doom-apprentice-theme.el ends here
