;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; start template
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;;(add-to-list 'load-path "/usr")
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "/usr/share/emacs/site-lisp/ac-dict")
;(ac-config-default)

;(split-window-below) ;split window vertical
;(split-window-right) ;split window horizontal


;full screen
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
)

;maximize
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
)
;maximize automatically
(my-fullscreen)

   (add-to-list 'load-path "~/.emacs.d/site-lisp")

;add for lua mode
    (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
    (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
    (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;add for switch window
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "C-x 1") 'switch-window-then-maximize)
(global-set-key (kbd "C-x 2") 'switch-window-then-split-below)
(global-set-key (kbd "C-x 3") 'switch-window-then-split-right)
(global-set-key (kbd "C-x 0") 'switch-window-then-delete)

;; the following lines are for ibus ime.
(add-to-list 'load-path "~/.emacs.d/ibus-el-0.2.1")
(require 'ibus)
;(require 'python-xlib)
(add-hook 'after-init-hook 'ibus-mode-on)
(setq ibus-agent-file-name "~/.emacs.d/ibus-el/ibus-el-agent")
;; Use C-SPC to toggle input status
(ibus-define-common-key (kbd "C-SPC") nil)
(global-set-key (kbd "C-SPC") 'ibus-toggle)


;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to unified diffs
(setq diff-switches "-u")
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
;; '(default-input-method "chinese-py-punct")
 '(fill-column 80)
 '(global-font-lock-mode t nil (font-lock))
 '(indent-tabs-mode t)
 '(show-paren-mode t nil (paren)))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

;; disable bell
(setq visible-bell t)

;; close starting message
(setq inhibit-start-message t)

;;display the column number and line number
(setq column-number-mode t)
(setq line-number-mode t)

;;use the middle key of mouse
(setq mouse-yank-at-point t)

;;set the large kill ring
(setq kill-ring-max 200)

;;Set c program stype
(add-hook 'c-mode-hook 'linux-c-mode)
(setq imenu-sort-function 'imenu--sort-by-name)
(defun linux-c-mode()
  (define-key c-mode-map [return] 'newline-and-indent)
  (interactive)
  (c-set-style "K&R")
;;  (c-toggle-auto-state)
;;  (c-toggle-hungry-state)
  (setq c-basic-offset 8)
  (imenu-add-menubar-index)
  (which-function-mode)
)

;;Set c++ program stype
(add-hook 'c++-mode-hook 'linux-cpp-mode)
(defun linux-cpp-mode()
  (define-key c++-mode-map [return] 'newline-and-indent)
  (define-key c++-mode-map [(control c) (c)] 'compile)
  (interactive)
  (c-set-style "K&R")
  (c-toggle-auto-state)
  (c-toggle-hungry-state)
  (setq c-basic-offset 8)
  (imenu-add-menubar-index)
  (which-function-mode)
)

;; use recursive minibuffer
(setq enable-recursive-minibuffers t)

;; display buffer name
(setq frame-title-format "emacs@%f")

;; display the image file
;(auto-image-file-mode)

;; highlight
(global-font-lock-mode t)

;; set backup functions
(setq version-control t)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq kept-old-versions 2)
(setq dired-kept-versions 1)

;; set the personal information

(setq user-full-name "LiZhenpeng")
(setq user-mail-address "LiZhenpeng, <lizhenpeng@sohu.com>")

;; enable copy and delete the directory
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

;; auto instert
(setq auto-insert t)
(setq auto-insert-query t)
(add-hook 'find-file-hooks 'auto-insert)

;; template file
(require 'template)
(template-initialize)
;;lizp add for cscope!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
(require 'xcscope)
(require 'nginx-mode)
;;lizp add for cedet
;;(load-file "/usr/cedet-1.0pre7/common/cedet.el")
;;(global-ede-mode 1)                      ; Enable the Project management system
;;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
;;(global-srecode-minor-mode 1)            ; Enable template insertion menu
;;lizp add for jdee
;;(add-to-list 'load-path (expand-file-name "/usr/jdee-2.4.0.1/lisp"))
;;(add-to-list 'load-path (expand-file-name "/usr/cedet-1.0pre7/common"))
;;(add-to-list 'load-path (expand-file-name "/usr/elib"))
;;(require 'jde)
;;lizp add for jdk
;;(setq jde-jdk-registry '(("1.5.0.18" . "/usr/java/jdk1.5.0_18")))
;;(setq jde-jdk '("1.5.0.18"))
;(require 'jde)
;;(setq jde-jdk-doc-url "file:///usr/java/jdk1.5.0_18/docs/index.html")
;;(setq jde-enable-abbrev-mode t)

;;lizp add for emacs shell
(setq shell-file-name "/bin/bash")
;;lizp add for clipboard
(setq x-select-enable-clipboard t)

;; set compile and save keys
(defun du-onekey-compile () 
  "Save buffers and start compile" 
  (interactive) 
  (save-some-buffers t) 
  (compile compile-command)) 
(global-set-key [C-f5] 'compile)
(global-set-key [f5] 'du-onekey-compile)

;; set GOTO line
(global-set-key [(meta g)] 'goto-line)
(global-set-key [(f1)] 'manual-entry)
;(global-set-key [(f3)] 'cvs-examine)
(global-set-key [(f3)] 'tags-loop-continue)
(global-set-key [(f4)] 'dired)
(global-set-key [f8] 'undo)             ;
(global-set-key [f9] 'view-mode);
(global-set-key [f10] 'my-maximized)
(global-set-key [f11] 'my-fullscreen)
(global-set-key [f12] 'shell)

;; set TAGS key
(global-set-key [(f7)] 'visit-tags-table)
(global-set-key [(meta \.)] '(lambda () (interactive) (lev/find-tag t)))
(global-set-key [(meta \,)] 'delete-other-windows)
(global-set-key [(control \.)] 'lev/find-tag)
(global-set-key [(control \,)] 'pop-tag-mark)
(global-set-key (kbd "C-M-,") 'find-tag)
;; lizp delete the following line for C-f is default key to move cusor to the nest char.
;;(global-set-key [(control f)] 'tags-apropos)
(global-set-key [(control F)] 'tags-search)



(defun lev/find-tag (&optional show-only)
  "Show tag in other window with no prompt in minibuf."
  (interactive)
  (let ((default (funcall (or find-tag-default-function
                              (get major-mode 'find-tag-default-function)
                              'find-tag-default))))
    (if show-only
        (progn (find-tag-other-window default)
               (shrink-window (- (window-height) 15))
               (recenter 1)
               (other-window 1))
      (find-tag default))))

;; set chinese
(set-language-environment 'UTF-8)
(set-keyboard-coding-system 'euc-cn)
(set-clipboard-coding-system 'euc-cn)
(set-terminal-coding-system 'euc-cn)
(set-buffer-file-coding-system 'euc-cn)
(set-selection-coding-system 'euc-cn)
(modify-coding-system-alist 'process "*" 'euc-cn)
(setq default-process-coding-system 
            '(euc-cn . euc-cn))
(setq-default pathname-coding-system 'euc-cn)

;; Display the line number
(set-scroll-bar-mode nil)   ; no scroll bar, even in x-window system (recommended)
;;(require 'wb-line-number)
;;(wb-line-number-toggle)
(global-linum-mode 1) ; always show line numbers


;;自动换行功能。
(add-hook 'message-mode-hook
   (lambda ()
     (setq fill-column 72);;
     (turn-on-auto-fill)))
(setq message-cite-function 'message-cite-original-without-signature)





(global-set-key "\C-c\C-o" 'occur)
;; occur 功能，列出当前 buffer 中匹配的行。如果你在 Emacs 阅读这篇说明，试试
;; M-x occur RET chunyu RET 和 C-u 2 M-x occur RET chunyu RET。

(global-set-key "\M-/" 'hippie-expand)
;; 自动补全，M-/ 原来的绑定 dabbrev-expand 也是这个功能，然而 hippie-expand
;; 功能更强而且可以扩展。

(global-set-key "\M-o" 'other-window)
;; 除了在 Dired buffer 中，基本都可以用来 other-window。

(fset 'yes-or-no-p 'y-or-n-p)
;; 改变 Emacs 固执的要你回答 yes 的行为。按 y 或空格键表示 yes，n 表示 no。



;;禁用启动信息
(setq inhibit-startup-message t)

;;光标靠近鼠标的时候，让鼠标自动让开，别挡住视线
(mouse-avoidance-mode 'animate)

;;防止页面滚动时跳动
(setq scroll-margin 3
      scroll-conservatively 10000)

;;显示日期
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time)

;; which-func-mode 在模式行中显示当前行在哪个函数中。
(add-hook 'c-mode-common-hook
            (which-func-mode 1))

(cond ((not window-system)
       ;; 如果不在 window 环境中(字符界面时)
       (setq frame-background-mode 'dark)
       ;; 设置背景为黑的，这样 Emacs 的很多缺省颜色会和黑色背景协调。
       (eval-after-load "log-view"
         ;; 设置 log-view 的颜色。
         '(progn
            (set-face-attribute 'log-view-file-face nil :foreground "blue" :weight 'bold)
            (set-face-attribute 'log-view-message-face nil :foreground "yellow" :weight 'bold))))

      ((eq window-system 'x)
       ;; 如果在 X Window 中

       (setq visible-bell t)
       ;; X Window 中的 visible-bell 还是很好看的。

       (setq x-stretch-cursor nil)
       ;; 如果设置为 t，光标在 TAB 字符上会显示为一个大方块 :)。

       (scroll-bar-mode -1)
       (tool-bar-mode -1)
       ;; 不要 tool-bar 和 scroll-bar。

       ;;不要 menu-bar。
       (menu-bar-mode -1)

       (setq default-frame-alist
             ;; 缺省的颜色设置。
             `((vertical-scroll-bars)
               (top . 0) (left . 0) (width . 111) (height . 48)
               (background-color . "DarkSlateGrey")
               (foreground-color . "Wheat")
               (cursor-color     . "gold1")
               (mouse-color      . "gold1")
               ;;(font . "9x15")
		))

       ;; 其他颜色设置。
       (if (facep 'mode-line)
           (set-face-attribute 'mode-line nil :foreground "DarkSlateGrey" :background "Wheat"))
       (if (facep 'fringe)
           (set-face-attribute 'fringe nil :foreground "limegreen" :background "gray30"))
       (if (facep 'tool-bar)
           (set-face-background 'tool-bar "DarkSlateGrey"))
       (if (facep 'menu)
           (face-spec-set 'menu '((t (:foreground "Wheat" :background "DarkSlateGrey")))))
       (if (facep 'trailing-whitespace)
           (set-face-background 'trailing-whitespace "SeaGreen1"))
       (if (facep 'minibuffer-prompt)
           (face-spec-set 'minibuffer-prompt '((t (:foreground "cyan")))))))
(put 'upcase-region 'disabled nil)
