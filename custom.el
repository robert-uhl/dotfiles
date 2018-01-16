(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#3b4252" "#bf616a" "#a3be8c" "#ebcb8b" "#81a1c1" "#b48ead" "#8fbcbb" "#d8dee9"])
 '(ansi-term-color-vector
   [unspecified "#2e3440" "#88c0d0" "#bf616a" "#5e81ac" "#ebcb8b" "#a3be8c" "#ebcb8b" "#d8dee9"])
 '(company-tooltip-flip-when-above nil)
 '(custom-enabled-themes (quote (nord)))
 '(custom-safe-themes
   (quote
    ("527df6ab42b54d2e5f4eec8b091bd79b2fa9a1da38f5addd297d1c91aa19b616" "25c06a000382b6239999582dfa2b81cc0649f3897b394a75ad5a670329600b45" "7527f3308a83721f9b6d50a36698baaedc79ded9f6d5bd4e9a28a22ab13b3cb1" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(erc-track-enable-keybindings t)
 '(fci-rule-color "#434c5e")
 '(flycheck-gometalinter-deadline "24s")
 '(godoc-command "godoc")
 '(magit-commit-arguments (quote ("--gpg-sign=DB4E40B6B7E04753")))
 '(magit-fetch-arguments nil)
 '(nord-comment-brightness 20)
 '(notmuch-saved-searches
   (quote
    ((:name "inbox" :query "tag:inbox" :key "i")
     (:name "suckless" :query "folder:Gmail/suckless tag:new")
     (:name "unread" :query "tag:unread" :key "u")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "d")
     (:name "all mail" :query "*" :key "a"))))
 '(nrepl-message-colors
   (quote
    ("#bf616a" "#d08770" "#ebcb8b" "#a3be8c" "#BFEBBF" "#88c0d0" "#81a1c1" "#b48ead")))
 '(package-selected-packages
   (quote
    (base16-theme nord-theme ledger-mode lua-mode helm-go-package toml-mode smex ido-completing-read+ flx-ido transmission dired-du uuidgen use-package helm-notmuch offlineimap protobuf-mode direnv deft golint zop-to-char zenburn-theme yaml-mode which-key web-mode volatile-highlights uuid undo-tree smartrep smartparens smart-mode-line slime slack rainbow-mode rainbow-delimiters ov operate-on-number move-text markdown-mode magit json-mode js2-mode imenu-anywhere helm-projectile helm-descbinds helm-ag guru-mode grizzl gotest god-mode go-projectile gitignore-mode gitconfig-mode git-timemachine gist geiser flycheck-gometalinter expand-region elisp-slime-nav editorconfig easy-kill discover-my-major diminish diff-hl crux company-go company-auctex company-anaconda cdlatex browse-kill-ring beacon anzu ace-window)))
 '(password-store-password-length 22)
 '(pdf-view-midnight-colors (quote ("#d8dee9" . "#3b4252")))
 '(safe-local-variable-values
   (quote
    ((Lowercase . YES)
     (Base . 10)
     (Syntax . COMMON-LISP)
     (Package . XLIB))))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 587)
 '(vc-annotate-background "#2e3440")
 '(vc-annotate-color-map
   (quote
    ((20 . "#8fbcbb")
     (40 . "#88c0d0")
     (60 . "#81a1c1")
     (80 . "#5e81ac")
     (100 . "#b48ead")
     (120 . "#a3be8c")
     (140 . "#ebcb8b")
     (160 . "#d08770")
     (180 . "#bf616a")
     (200 . "#eceff4")
     (220 . "#e5e9f0")
     (240 . "#d8dee9"))))
 '(vc-annotate-very-old-color "#d8dee9"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lui-time-stamp-face ((t (:foreground "#81a1c1"))))
 '(slack-message-output-header ((t (:foreground "#b48ead" :weight bold :height 1.0)))))
