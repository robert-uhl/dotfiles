;;; buhl --- personal preferences to overlay on prelude

;;; Commentary:
;;;
;;; This is a collection of preferences I've added on to prelude since
;;; April 2015.  In many — but not all — cases I credit the original
;;; source for various keybindings &c.

;;; Code:

;; FIXME: install flycheck-gometalinter
;;(set-frame-font "Source Code Pro:pixelsize=18:antialias=true:autohint=true")
(setq default-frame-alist '((font . "Source Code Pro:pixelsize=18:antialias=true:autohint=true")))

(require 'prelude-helm-everywhere)

;; required for flycheck to DTRT
(require 'flycheck-gometalinter)
;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-gometalinter-setup))
;; (setq-default flycheck-emacs-lisp-load-path 'inherit)

(prelude-require-packages '(markdown-mode uuid))

(setq-default gofmt-command "goimports")
;;(add-to-list 'load-path "~/code/go/src/github.com/dougm/goflymake")
;;(require 'go-flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
;; this should be the default!
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "M-.") #'godef-jump)))


(require 'w3m-load)
(require 'cl-lib)
(require 'company)

(setq-default abbrev-mode t)
;;(require 'go-autocomplete)
;;(require 'auto-complete-config)
;;(ac-config-default)

(display-time-mode -1)
(global-hl-line-mode 1)
(add-hook 'dired-mode-hook 'hl-line-mode)

(setq prelude-guru nil)
;;(setq scroll-conservatively 1)
(scroll-bar-mode -1)

(require 'golint)

(setf kubernetes-server "http://127.0.0.1:8080/")

(require 'grep) ;; makes ag search work in projectile

;; this fixes an error message about CDPATH in zsh when running M-x dirs
(add-hook 'shell-mode-hook (lambda () (when (string-equal (getenv "SHELL") "/bin/zsh") (setf comint-process-echoes t))))

;; update deft

(require 'deft)
(setf deft-directory "~/notes/"
      deft-extensions (cons "org" (remove "org" deft-extensions))
      deft-use-filename-as-title t
      deft-use-filter-string-for-filename t)

;; variable pitch in org-mode
;;(add-hook 'org-mode-hook (lambda () (variable-pitch-mode t)))

(defun buhl/adjoin-to-list-or-symbol (element list-or-symbol)
  ;; copied from http://stackoverflow.com/a/16819449
  (let ((list (if (not (listp list-or-symbol))
                  (list list-or-symbol)
                list-or-symbol)))
    (require 'cl-lib)
    (cl-adjoin element list)))

(eval-after-load "org"
  '(mapc
    (lambda (face)
      (set-face-attribute
       face nil
       :inherit
       (buhl/adjoin-to-list-or-symbol
        'fixed-pitch
        (face-attribute face :inherit))))
    (list 'org-code 'org-block 'org-table 'org-block-background)))

;; set up some nice Lisp stuff
(require 'slime)
(require 'hyperspec)
(setf common-lisp-hyperspec-root "file:///usr/share/doc/hyperspec/")
(push 'slime-indentation slime-contribs)
(slime-setup)

;;; from https://github.com/laynor/emacs-conf/blob/master/packages/sm-package-slime.el
(defadvice hyperspec-lookup (around browse-with-eww activate)
  "Show hyperspec in eww."
  (flet ((browse-url (url) (eww-browse-url url)))
    ad-do-it))

;; make protobufs not hideous
(defconst my-protobuf-style
  '((c-basic-offset . 2)))

(add-hook 'protobuf-mode-hook
          (lambda () (c-add-style "my-style" my-protobuf-style t)))

;;;; erc
(require 'erc)
(when (file-exists-p (expand-file-name "~/.erc-auth"))
  (require 'erc-services)
  (erc-services-mode 1)
  (load "~/.erc-auth")
  (setq erc-prompt-for-nickserv-password nil))

;;;; slack
(require 'slack)
(when (file-exists-p (expand-file-name "~/.slack-auth"))
  (load "~/.slack-auth"))

(add-hook 'slack-mode-hook #'flyspell-mode)
(add-hook 'slack-mode-hook #'emojify-mode)
;; some good stuff from http://endlessparentheses.com/keep-your-slack-distractions-under-control-with-emacs.html?source=rss
(setq slack-prefer-current-team t
      slack-display-team-name nil
      slack-buffer-function #'switch-to-buffer)
(define-key ctl-x-map "j" #'slack-select-rooms)
(define-key ctl-x-map (kbd "C-j") #'slack-select-unread-rooms)
(define-key slack-mode-map (kbd "C-c C-d") #'slack-message-delete)
(define-key slack-mode-map (kbd "C-c C-e") #'slack-message-edit)
(define-key slack-mode-map (kbd "C-c C-k") #'slack-channel-leave)

(defun buhl/company-slack-backend (command &optional arg &rest ignored)
  "Completion backend for slack chats.  It currently understands
@USER; adding #CHANNEL should be a simple matter of programming."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-slack-backend))
    (prefix (when (and (eq major-mode 'slack-mode) (looking-back "\\W@\\(\\w*\\)")) (match-string 1)))
    (candidates (remove-if-not
                 (lambda (x)
                   (s-starts-with-p arg x))
                 (mapcar #'first (slack-user-names slack-current-team))))
    (meta (format "%s%s"
                  (slack-user-presence-to-string (slack-user-find-by-name arg slack-current-team))
                  arg))))

(add-to-list 'company-backends 'buhl/company-slack-backend)

;;;; alert

(setf alert-default-style 'libnotify)

;;;; gpg stuff
(defun buhl/gpg-agent-reload-info ()
  "Reload the ~/.gnupg/gpg-agent-info-$HOSTNAME file."
  (interactive)
  (with-temp-buffer
    (insert-file (expand-file-name (format "~/.gnupg/gpg-agent-info-%s" (system-name))))
    (goto-char (point-min))
    (while (re-search-forward "\\([A-Z_]+\\)=\\(.*\\)" nil t)
      (setenv (match-string 1) (match-string 2)))))

(eval-after-load "virtualenvwrapper"
  '(venv-set-location "/home/buhl/venvs/"))

(require 'direnv)
(direnv-mode)
;;(add-hook 'find-file-hook 'direnv-update-environment)
;;(add-hook 'buffer-list-update-hook 'direnv-update-environment)

(require 'emojify)
(setq emojify-user-emojis
      '((":pipe:" . (("name" . "Pipe")
                     ("image" . "/home/buhl/.emoji/sanda_halo-emoji.png")
                     ("style" . "github")))
        (":yak:" . (("name" . "Yak")
                    ("image" . "/home/buhl/.emoji/yak.png")
                    ("style" . "github")))
        (":deathstar:" . (("name" . "Death star")
                          ("image" . "/home/buhl/.emoji/deathstar.png")
                          ("style" . "github")))
        (":poppy:" . (("name" . "Poppy")
                      ("image" . "/home/buhl/.emoji/poppy.png")
                      ("style" . "github")))
        (":bleuet:" . (("name" . "Bleuet")
                       ("image" . "/home/buhl/.emoji/bleuet.png")
                       ("style" . "github")))))

(when (featurep 'emojify)
  (emojify-set-emoji-data))

(defvar buhl/frame-name-to-firefox-profile-alist nil)
(defvar buhl/default-firefox-profile "Default")

(define-advice browse-url-firefox (:around (func url &optional new-window) buhl/choose-firefox-profile)
  (let ((browse-url-firefox-arguments
         (concatenate 'list
                      browse-url-firefox-arguments
                      (list
                       "-P"
                       (or (cdr (assoc (frame-parameter nil 'name) buhl/frame-name-to-firefox-profile-alist)) buhl/default-firefox-profile)))))
    (funcall func url new-window)))

;; (require 'symon)
;; (symon-mode 1)

;; (load "/home/buhl/src/pair-mode/pair-mode.el")

(setq recenter-positions '(top middle bottom))

(autoload 'notmuch "notmuch" "notmuch mail" t)

(defun buhl/compile ()
  ;; from http://nullprogram.com/blog/2017/08/22/
  (interactive)
  (let ((default-directory (locate-dominating-file "." "Makefile")))
    (compile "make")))

(display-time)

(global-set-key "\C-cs" 'slime-selector)

(provide 'buhl)

;;; buhl.el ends here
