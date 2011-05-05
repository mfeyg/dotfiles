(setq inhibit-splash-screen t)
(require 'color-theme)
(color-theme-initialize)
(color-theme-arjen)
;; AUCTeX
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t) 
(setq TeX-parse-self t) 
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
;; Haskell Mode
(load "haskell-mode.el" nil t t)
(load "haskell-ghci.el" nil t t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(load "haskell-font-lock.el" nil t t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-font-lock)
(load "haskell-indentation.el" nil t t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(load "inf-haskell.el" nil t t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(TeX-view-program-list (quote (("zathura" "zathura %s.pdf"))))
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "zathura") (output-html "xdg-open"))))
 '(menu-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
;;--------------------------------------------------------------------
;; Lines enabling gnuplot-mode

;; move the files gnuplot.el to someplace in your lisp load-path or
;; use a line like
;;  (setq load-path (append (list "/path/to/gnuplot") load-path))

;; these lines enable the use of gnuplot mode
  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))

;; This line binds the function-9 key so that it opens a buffer into
;; gnuplot mode 
  (global-set-key [(f9)] 'gnuplot-make-buffer)

;; end of line for gnuplot-mode
;;--------------------------------------------------------------------
