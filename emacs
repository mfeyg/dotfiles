(setq inhibit-splash-screen t)
(require 'color-theme)
(color-theme-initialize)
(color-theme-arjen)
;; AUCTeX
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
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
 '(menu-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
