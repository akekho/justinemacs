;;; init.el

(let ((myfont "DejaVu Sans Mono-7"))
  (set-frame-font myfont)
  (add-to-list 'default-frame-alist (cons 'font myfont)))

(global-set-key (kbd "C-v") 'pager-page-down)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "M-v") 'pager-page-up)
(global-set-key (kbd "M-Q") 'lob/unfill-paragraph)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
(global-set-key (kbd "M-.") 'find-tag)
(global-set-key (kbd "M-,") 'pop-tag-mark)
(global-set-key (kbd "C-x \\") 'align-regexp)
(global-set-key (kbd "C-x f") 'lob/recentf-ido-find-file)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x t") 'transpose-lines)
(global-set-key (kbd "C-x C-t") 'other-window)
(global-set-key (kbd "C-x C-i") 'ido-imenu)
(global-set-key (kbd "C-x C-n") 'next-error)
(global-set-key (kbd "C-x C-p") 'previous-error)
(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x M-m") 'shell)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
(global-set-key (kbd "C-M-h") 'backward-kill-word)
(global-set-key (kbd "C-c n") 'lob/cleanup-buffer)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "C-h a") 'apropos)
(global-set-key (kbd "C-x C-r") 'replace-string)
(global-set-key (kbd "C-x C-l") 'replace-regexp)
(global-set-key (kbd "C-x C-r") 'replace-string)
(global-set-key (kbd "C-x C-l") 'replace-regexp)
(global-set-key (kbd "<f1>") 'man)
(global-set-key (kbd "<f2>") 'lob/recompile)
(global-set-key (kbd "<f3>") 'lob/sudo)
(global-set-key (kbd "<f4>") 'lob/face-at-point)
(global-set-key (kbd "<f5>") 'toggle-truncate-lines)
(global-set-key (kbd "<f6>") 'gud-next)
(global-set-key (kbd "C-<f6>") 'gud-nexti)
(global-set-key (kbd "<f7>") 'gud-step)
(global-set-key (kbd "C-<f7>") 'gud-stepi)
(global-set-key (kbd "<f8>") 'gud-finish)
(global-set-key (kbd "C-<f8>") 'gud-cont)
(global-set-key (kbd "<f9>") 'gud-up)
(global-set-key (kbd "C-<f9>") 'gud-down)
(global-set-key (kbd "<f10>") 'compile)
(global-set-key (kbd "C-<f10>") 'gdb)
(global-set-key (kbd "C-x <f10>") 'jart/fix-gdb-gui)

(if (string= (getenv "USER") "jart")
    (progn
      (global-set-key (kbd "C-u") ctl-x-map)
      (global-set-key (kbd "C-h") 'delete-backward-char)
      (global-set-key (kbd "M-h") 'backward-kill-word)
      (global-set-key (kbd "C-x C-h") 'help)
      (global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
      (global-set-key (kbd "C-x C-g") 'grep-find)
      (global-set-key (kbd "C-x b") 'ibuffer)
      (global-unset-key (kbd "C-/"))))

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(setq lob/vendor-dirs (list dotfiles-dir
                            (concat dotfiles-dir "vendor")
                            (concat dotfiles-dir "vendor/magit")
                            (concat dotfiles-dir "vendor/yasnippet")
                            (concat dotfiles-dir "vendor/coffee-mode")))
(dolist (dir lob/vendor-dirs) (add-to-list 'load-path dir))
(add-to-list 'custom-theme-load-path (concat dotfiles-dir "themes"))

(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(setq-default c-file-style nil)
(setq-default fill-column 79)
(setq-default truncate-lines t)
(setq-default save-place t)
(setq-default css-indent-offset 2)
(setq-default coffee-tab-width 2)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tooltip-mode) (tooltip-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
;; (unless window-system
;;   (if (fboundp 'menu-bar-mode) (menu-bar-mode -1)))
(when window-system
  (mouse-wheel-mode t)
  (blink-cursor-mode -1)
  (add-hook 'before-make-frame-hook 'lob/turn-off-tool-bar))

(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10)

(setq frame-title-format '(buffer-file-name "%f - justinemacs" ("%b"))
      autoload-file (concat dotfiles-dir "loaddefs.el")
      custom-file (concat dotfiles-dir "custom.el")
      save-place-file (concat dotfiles-dir "places")
      transient-mark-mode t
      make-backup-files nil
      visible-bell nil
      gdb-many-windows t
      ring-bell-function 'ignore
      echo-keystrokes 0.1
      font-lock-maximum-decoration t
      inhibit-startup-message t
      column-number-mode t
      color-theme-is-global t
      shift-select-mode nil
      mouse-yank-at-point t
      diff-switches "-u"
      require-final-newline t
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'forward
      ediff-window-setup-function 'ediff-setup-windows-plain
      lob/is-windows (not (null (memq system-type '(ms-dos windows-nt cygwin))))
      lob/is-unix (not (null (memq system-type
                                   '(gnu/linux darwin berkeley-unix cygwin))))
      lob/is-linux (not (null (memq system-type '(gnu/linux))))
      lob/is-mac (not (null (memq system-type '(darwin))))
      lob/is-colorful (>= (display-color-cells) 256))

(auto-fill-mode 1)
(setq comment-auto-fill-only-comments t)

(if (fboundp 'x-cut-buffer-or-selection-value)
    (setq x-select-enable-clipboard t
          interprogram-paste-function 'x-cut-buffer-or-selection-value))
(defalias 'yes-or-no-p 'y-or-n-p)
(random t)
(delete 'try-expand-line hippie-expand-try-functions-list)
(delete 'try-expand-list hippie-expand-try-functions-list)

(show-paren-mode 1)
(recentf-mode 1)
(global-font-lock-mode t)
(auto-compression-mode t)
(delete-selection-mode 1)
(show-paren-mode 1)

;; This asks emacs to complain when I use tabs, break the 80 character rule,
;; or insert trailing whitespace.
(require 'whitespace)
(setq whitespace-style '(face empty tabs tab-mark lines-tail trailing))
(setq whitespace-line-column 80)
(global-whitespace-mode 1)

(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'lob-defuns)
(require 'lob-c)
(require 'lob-lisp)
(require 'lob-python)

(lob/regen-autoloads)

(add-hook 'lob/coding-hook 'lob/pretty-lambdas)

(if (and (not window-system)
         (string= (getenv "TERM") "xterm-256color"))
    (load-theme 'justine256 t)
  (load-theme 'zenburn t))

;; (load-theme 'zenburn t)
;; (load-theme 'justine256 t)
;; (load-theme 'adwaita t)
;; (load-theme 'deeper-blue t)
;; (load-theme 'dichromacy t)
;; (load-theme 'light-blue t)
;; (load-theme 'manoj-dark t)
;; (load-theme 'misterioso t)
;; (load-theme 'tango t)
;; (load-theme 'tango-dark t)
;; (load-theme 'tsdh-light t)
;; (load-theme 'tsdh-dark t)
;; (load-theme 'wheatgrass t)
;; (load-theme 'whiteboard t)
;; (load-theme 'wombat t)

(require 'yasnippet)
(yas-global-mode 1)
(setq yas/root-directory (list (concat dotfiles-dir "snippets")))

(setq rst-adornment-faces-alist (quote ((t . highlight-current-line)
                                        (t . font-lock-keyword-face)
                                        (1 . font-lock-keyword-face)
                                        (2 . font-lock-keyword-face)
                                        (3 . font-lock-keyword-face)
                                        (4 . font-lock-keyword-face)
                                        (5 . font-lock-keyword-face)
                                        (6 . font-lock-keyword-face))))

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.less$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.clj$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

(eval-after-load 'go-mode
  '(progn
     (define-key go-mode-map (kbd "<return>") 'newline-and-indent)))

(server-start)
