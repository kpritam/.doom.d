;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Pritam Kadam"
      user-mail-address "phkadam2008@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;; You will most likely need to adjust this font size for your system!

(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 16 :weight 'regular)
      ;; doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font Mono") ; inherits `doom-font''s :size
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 16)
      doom-unicode-font (font-spec :family "FiraCode Nerd Font Mono" :size 20)
      doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 20))
(setq-default line-spacing 0.2)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq which-key-idle-delay 0.01)

;; Set frame transparency
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (set-frame-parameter (selected-frame) 'alpha '(95 . 95))

(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")

(use-package! prettier-js
  :after js2-mode
  :init
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'js2-jsx-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode))

(eval-after-load 'web-mode
    '(progn
       (add-hook 'web-mode-hook #'add-node-modules-path)
       (add-hook 'web-mode-hook #'prettier-js-mode)))

(after! projectile
  (setq projectile-project-search-path '("~/projects/tmtsoftware/" "~/projects/kpritam")))

(setq! doom-themes-treemacs-theme "doom-colors")
(doom-themes-treemacs-config)

;; Modeline
(setq! doom-modeline-icon (display-graphic-p)
       doom-modeline-major-mode-icon t
       doom-modeline-lsp t
       doom-modeline-buffer-file-name-style 'truncate-with-project
       doom-modeline-buffer-encoding nil)
;; Show battery usage
(ignore-errors (display-battery-mode))
;; Disable buffer size
(size-indication-mode nil)

(use-package lsp-metals)
(after! lsp
  (setq company-minimum-prefix-length   1
        company-idle-delay              0.0
        lsp-lens-enable            t))

(map! :leader
      (:prefix ("-" . "open file")
       :desc "Edit agenda file" "a" #'(lambda () (interactive) (find-file "~/Org/agenda.org"))
       :desc "Edit todo file" "t" #'(lambda () (interactive) (find-file "~/Org/todo.org"))
       :desc "Edit doom config.el" "c" #'(lambda () (interactive) (find-file "~/.doom.d/config.el"))
       :desc "Edit doom init.el" "i" #'(lambda () (interactive) (find-file "~/.doom.d/init.el"))
       :desc "Edit doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.doom.d/packages.el"))))
