(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(company-tooltip-flip-when-above nil)
 '(custom-safe-themes
   (quote
    ("67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(erc-track-enable-keybindings t)
 '(flycheck-gometalinter-deadline "24s")
 '(magit-commit-arguments (quote ("--gpg-sign=DB4E40B6B7E04753")))
 '(magit-fetch-arguments nil)
 '(notmuch-saved-searches
   (quote
    ((:name "inbox" :query "tag:inbox" :key "i")
     (:name "suckless" :query "folder:Gmail/suckless tag:new")
     (:name "unread" :query "tag:unread" :key "u")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "d")
     (:name "all mail" :query "*" :key "a"))))
 '(package-selected-packages
   (quote
    (smex ido-completing-read+ flx-ido transmission dired-du uuidgen use-package helm-notmuch offlineimap protobuf-mode direnv deft golint zop-to-char zenburn-theme yaml-mode which-key web-mode volatile-highlights uuid undo-tree smartrep smartparens smart-mode-line slime slack rainbow-mode rainbow-delimiters ov operate-on-number move-text markdown-mode magit json-mode js2-mode imenu-anywhere helm-projectile helm-descbinds helm-ag guru-mode grizzl gotest god-mode go-projectile gitignore-mode gitconfig-mode git-timemachine gist geiser flycheck-gometalinter expand-region elisp-slime-nav editorconfig easy-kill discover-my-major diminish diff-hl crux company-go company-auctex company-anaconda cdlatex browse-kill-ring beacon anzu ace-window)))
 '(safe-local-variable-values
   (quote
    ((Lowercase . YES)
     (Base . 10)
     (Syntax . COMMON-LISP)
     (Package . XLIB))))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 587))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lui-time-stamp-face ((t (:foreground "#7cb8bb"))))
 '(slack-message-output-header ((t (:foreground "#dc8cc3" :weight bold :height 1.0)))))
