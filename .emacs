;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


;;========================================
;;          啓動讀取來源
;;========================================

;; 設定 melpa 安裝源
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)
;;掃描指定目錄讀取自訂的 el  ;;(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/plugins/")

;;記住 emacs 上次的所有紀錄， (kill-ring，命令記錄……)，局部變量，寄存器，打開的文件，修改過的文件和最後修改的位置
(require 'session) 
(add-hook 'after-init-hook 'session-initialize)

;;保存 Emacs 的``桌面環境'' — buffers、以及 buffer 的文件名、major modes 和位置等等，下一次 Emacs 啟動的時候就會自動加載
(desktop-save-mode 1)


;;========================================
;;          常駐設置
;;========================================


(setq inhibit-startup-message t);關閉起動時閃屏

(setq visible-bell t);關閉出錯時的提示聲

(show-paren-mode t);顯示括號匹配

(column-number-mode t);在狀態列顯示列號

;;(global-hl-line-mode 1) ;;當前行高亮顯示

;;(tool-bar-mode -1);;隱藏工具列

;;(menu-bar-mode -1);;隱藏選單

(setq frame-title-format "%n%F/%b");;在窗口的標題欄上顯示文件名稱

;;(global-linum-mode 1);;顯示行號,佔資源

(setq lazy-highlight-cleanup nil);;讓 Isearch 不會再主動清除搜尋的高亮顯示

;; (display-time-mode t) ;; 啟用時間顯示設置，在 minibuffer 上面的那個槓上

(setq auto-image-file-mode t) ;;讓 Emacs 可以直接打開/顯示圖片。


;;鼠標滾輪，默認的滾動太快，這裡改為 3 行
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

;;防止頁面滾動時跳動，scroll-margin 3 可以在靠近屏幕邊沿 3 行時就開始滾動，可以很好的看到上下文。
(setq scroll-step 1
  scroll-margin 3
  scroll-conservatively 10000)

;;同名檔案不混淆（同名檔案同時開啟時，會在 buffer 加上目錄名稱）
(require 'uniquify)
(setq
uniquify-buffer-name-style 'post-forward
uniquify-separator ":")

;;;;;;;;
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))
;;	  (define-key org-bullets-bullet-map [mouse-1] nil) ;這行是禁止滑鼠點擊摺疊，如果需要滑鼠點擊摺疊則把這行註解掉。
	  )

;;;;;;以 y/n 替代 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;支持 emacs 和外部程序的拷貝粘貼
(setq x-select-enable-clipboard t)

(delete-selection-mode 1) ;; 將刪除功能配置成與其他編輯器相同，選中一段文字之後輸入字符會替換掉你選中的文字。

;;自動斷行，每行 80 個字符
;;(add-hook 'message-mode-hook (lambda ()
;;(setq fill-column 80)
;;(turn-on-auto-fill)))

;;約會提醒
(setq appt-issue-message t)

;; 設置 tab 大小為 4 個空格，要插入 tab 則使用  C-q tab
;; (setq default-tab-width 4)
;; (setq-default indent-tabs-mode nil)

;;========================================
;;          基本設定
;;========================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(org-agenda-files
   (quote
    ("/home/kevin/inbox/doc/Getting Started with Orgzly.org" "/home/kevin/inbox/doc/List.org" "/home/kevin/inbox/doc/calendar.org" "/home/kevin/inbox/doc/capture.org" "/home/kevin/inbox/doc/diary.org" "/home/kevin/inbox/doc/expense.org" "/home/kevin/inbox/doc/famous_saying.org" "/home/kevin/inbox/doc/gold.org" "/home/kevin/inbox/doc/reference.org" "/home/kevin/inbox/doc/secret.org" "/home/kevin/inbox/doc/write.org")))
 '(org-capture-templates
   (quote
    (("f" "名言佳句" plain
      (file+headline "/home/kevin/inbox/doc/famous_saying.org" "暫存")
      "*** %?")
     ("s" "schedule" entry
      (file+headline "/home/kevin/inbox/doc/calendar.org" "schedule")
      "** %?
 SCHEDULED: %t
")
     ("d" "diary" plain
      (file+datetree+prompt "/home/kevin/inbox/doc/diary.org")
      "")
     ("c" "collect everything" entry
      (file "/home/kevin/inbox/doc/capture.org")
      "")
     ("w" "web capture" entry
      (file+headline "/home/kevin/inbox/doc/capture.org" "網路資料")
      ""))))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Noto Sans Mono CJK TC" :foundry "GOOG" :slant normal :weight normal :height 128 :width normal)))))


;;========================================
;;          org-mode 設定
;;========================================

;; 開啓 txt 檔案時自動載入 org-mode
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

;; 新增連結快速鍵
(global-set-key "\C-cl" 'org-store-link)

;; 新增 aggregate.el
;; https://github.com/tbanel/orgaggregate
;; http://rubikitch.com/2014/12/02/org-aggregate/
;;M-x package-list-packages ;;Then browse the list of available packages and install orgtbl-aggregate ;;Alternatively, you can download the lisp files, and load them:
(load-file "~/.emacs.d/plugins/orgtbl-aggregate.el")
(load-file "~/.emacs.d/plugins/org-insert-dblock.el") ;; optional, extends C-c C-c i

;;Agenda 設定
(global-set-key "\C-ca" 'org-agenda) 
(global-set-key [f11] 'org-agenda-list) ;按 F11 就顯示 agenda-list
(setq org-agenda-include-diary t);整合 diary mode 和 org 的 agenda mode
(setq org-agenda-ndays 15);; 設定 Agenda 預設視圖爲 自訂天數。

;; 添加 Org-mode 文本內語法高亮
(require 'org)
(setq org-src-fontify-natively t)

;;啟用 org capture 快速鍵 (也可直接輸入 alt+X  org-capture 啟動)
(define-key global-map "\C-cc" 'org-capture)

;; emacs org-mode 自動換行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil))) 

;;設置 sentence-end 可以識別中文標點。不用在 fill 時在句號後插入兩個空格。
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

;; org-mode 的 支援語法
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (ditaa . t)
   (dot . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (haskell . nil)
   (latex . t)
   (ledger . t)
   (ocaml . nil)
   (octave . t)
   (python . t)
   (ruby . t)
   (screen . nil)
   (sh . t)
   (sql . nil)
   (sqlite . t)))

;; 新增快速語法模板 TEMPLATE，輸入 <d 後按 TAB
(add-to-list 'org-structure-template-alist
             '("d" "#+NAME: ?\n#+BEGIN_SRC dot :file /home/kevin/inbox/media/dot/圖檔名稱.png :exports results\n\n#+END_SRC") ;; dot 語法，圖檔名稱手工改爲想要的檔名
	     )

;; 設定優先級範圍和默認任務的優先級
(setq org-highest-priority ?A) (setq org-lowest-priority ?D) (setq
org-default-priority ?B)
;; 優先級醒目外觀
(setq org-priority-faces
'(
(?A . (:background "dark" :foreground "red" :weight bold))
(?B . (:background "dark" :foreground "yellow" :weight bold))
(?C . (:background "dark" :foreground "Green" :weight bold))
(?D . (:background "dark" :foreground "DodgerBlue" :weight bold))
))
;;;  M-x list-colors-display 顯示Emacs所有的顏色，方便我們來進行配色

;; 粗體文字格式 高亮
(defface hi-red-b '((t (:foreground "#ff46ff"))) t) (defun org-bold-highlight () (interactive) (hi-lock-mode) (highlight-regexp "[ \\t]\\(\\*\\(\\S-[^*]+\\S-\\|[^*]\\{1,2\\}\\)\\*\\)[ \\t\\n]*" 'hi-red-b)) (add-hook 'org-mode-hook 'org-bold-highlight)
;; 作者：匿名用户;; 链接：https://www.zhihu.com/question/28830039/answer/47043443;; 来源：知乎;; 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


;;========================================
;;           操作設定
;;========================================


;; =============
;;  快速鍵複製整行還有刪除整行
;;  C-w 剪下整行，M-w 複製整行，C-k 剪下光標所在處到行尾，M-k 複製光標所在處到行尾
;;  Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line (before check-position activate)
(if (member major-mode
'(emacs-lisp-mode scheme-mode lisp-mode
c-mode c++-mode objc-mode js-mode
latex-mode plain-tex-mode))
(if (and (eolp) (not (bolp)))
(progn (forward-char 1)
(just-one-space 0)
(backward-char 1)))))

(defadvice kill-ring-save (before slick-copy activate compile)
"When called interactively with no active region, copy a single line
instead."
(interactive (if mark-active (list (region-beginning) (region-end))
(message "Copied line")
(list (line-beginning-position)
(line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
"When called interactively with no active region, kill a single line
instead."
(interactive
(if mark-active (list (region-beginning) (region-end))
(list (line-beginning-position)
(line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
"Copy lines (as many as prefix argument) in the kill ring"
(interactive "p")
(kill-ring-save (point)
(line-end-position))
;; (line-beginning-position (+ 1 arg)))
(message "%d line%s copied" arg (if (= 1 arg) "" "s")))
(global-set-key (kbd "M-k") 'qiang-copy-line)

;; ==============
;;recents 最近開啟的檔案，C-x C-r
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 35)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; ===============
;;啟用 ibuffer(比預設的那個 buffer selector 好用一點)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;;(global-set-key [(f4)] 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; ================
;; smex 輸入 M-x 後 會顯示可用模式，方便輸入指令，且會記憶之前操作過的指令
(load "~/.emacs.d/plugins/smex.el")
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; ================
;; 按下 C-= 可以快速增加選取範圍，C--可以減少範圍。
;; https://github.com/magnars/expand-region.el
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; =================
;;;;;; Helm 系列功能
;; 安裝 Helm 後，用 helm-occur 取代內建的搜尋功能
;; 用 helm-show-kill-ring 取代 內建的 kill-ring 功能
;; 取代 buffer 管理 還有 開啓檔案列表
(require 'helm-config)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
;;(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;;; ==================
;; 按[f2] 快速打開配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs"))
(global-set-key [f2] 'open-init-file) ;; 將函數 open-init-file 綁定到 [f2] 鍵上

;;;; ==================
;; emacs-neotree
(add-to-list 'load-path "/some/path/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;;;; ==================
;;; 代碼參考線: fill-column-indicator   安裝  M-x package-install fill-column-indicator
;;; 默認不顯示，快捷鍵綁定到 M-|，隨時切換。
;; (require 'fill-column-indicator)
;; (setq fci-rule-color "#D15FEE")
;; (setq fci-rule-column 80)
;; (define-globalized-minor-mode
;;   global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; ;;(global-fci-mode 1)
;; (global-set-key (kbd "M-|") 'global-fci-mode)

;;;; =================
;; 快速移動列表 A 只能在同個 Buffer 操作，優點是可少輸入檔案名稱
;; 可以用 C-c C-w (org-refile)：會把當前光標下的 entry 移動到另一個 heading 下（會自動調整 heading 的級別）。
;; 默認目的地是當前 buffer 中的一級 heading，可透過 org-refile-targets 調整目的地。
;; 設置目的地為當前 buffer 中一級和二級 heading
;; (setq org-refile-targets (list (cons nil (cons :maxlevel 2))))

;;;; ================
;; 快速移動列表 B  可以在其他 Buffer 操作，需多輸入 buffer 名稱
;; 可以用 C-c C-w (org-refile)  跨 buffer 移動到其他檔案，輸入位置像這樣 Work.org/Appointments 可按 TAB 補全。
;; 用 C-c M-w (org-copy)   跨 buffer 複製到其他檔案
;; any headline with level <= 2 is a target
(setq org-refile-targets '((nil :maxlevel . 2)
                                ; all top-level headlines in the
                                ; current buffer are used (first) as a
                                ; refile target
                           (org-agenda-files :maxlevel . 2)))
;; provide refile targets as paths, including the file name
;; (without directory) as level 1 of the path
(setq org-refile-use-outline-path 'file)
;; allow to create new nodes (must be confirmed by the user) as
;; refile targets
(setq org-refile-allow-creating-parent-nodes 'confirm)
;; refile only within the current buffer
(defun my/org-refile-within-current-buffer ()
  "Move the entry at point to another heading in the current buffer."
  (interactive)
  (let ((org-refile-targets '((nil :maxlevel . 5))))
    (org-refile)))

;;;; ================ 視窗操作
;; 快速把焦點移動到其他 buffer，emacs 內建是按下 C-x o  來切換 buffer。
;; 這樣就可以用 Alt+Shift+s/z/x/c 來向上/下/左/右切換 window，而且在標準 qwerty 鍵盤上可以單手操作。如果你有其他更偏好的 key-binding 請自行修改。
(global-set-key (kbd "M-S") 'windmove-up)
(global-set-key (kbd "M-X") 'windmove-down)
(global-set-key (kbd "M-C") 'windmove-right)
(global-set-key (kbd "M-Z") 'windmove-left)

(global-set-key "\C-xk" 'kill-this-buffer) ;; 按下 C-x k 立即關閉掉當前的 buffer

;;;; ================
;; switch-window 選擇數字快速移動到其他 Buffer ，取代原本的快速鍵
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;;;; ================
;; window分割快捷鍵
(global-set-key (kbd "M-1") 'delete-other-windows) ;; 關閉其他
(global-set-key (kbd "M-2") 'split-window-below) ;; 分割上下
(global-set-key (kbd "M-3") 'split-window-right) ;; 分割左右
(global-set-key (kbd "M-4") 'delete-window) ;; 關閉此頁	

;;;; ================
;; 對調兩個 Buffer 
(defun transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))
(global-set-key (kbd "M-9") 'transpose-buffers)


;;========================================
;;           常用模式 MODE
;;========================================

;; ================
;;undo-tree-mode 還原樹模式
;;(提醒：redo 會變成 C-?)
;;C-x u 進入 undo-tree-visualizer-mode，t 顯示時間戳。
(require 'undo-tree)
(global-undo-tree-mode)

;; =============================
;; (global-set-key [f9] 'view-mode)        ; 只讀方式查看文件

;; =============================
;; 讓 emacs 增加 todo.txt 模式
(load "todotxt")
(require 'todotxt)
(add-to-list 'auto-mode-alist '("\\todo.txt\\'" . todotxt-mode))
(global-set-key (kbd "C-x t") 'todotxt)

;; =============================
;; markdown-mode
(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
;;(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; =============================
;; 自動補全模式 auto-complete-config，自動填滿的好用功能
;; 輸入 M-x auto-complete-mode 啟用，M-n/p 上下選擇
;; 請自訂字典還有 el 位址
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20160310.2248")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20160310.2248/dict")
(ac-config-default)

;; =============================
;; autorevert stuff 跟其他編輯器共用文件時，即時更新文件變化
(autoload 'auto-revert-mode "autorevert" nil t)
(autoload 'turn-on-auto-revert-mode "autorevert" nil nil)
(autoload 'global-auto-revert-mode "autorevert" nil t)
(global-auto-revert-mode 1)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; =============================
;; Occur Mode 把所有的搜索結果都列到一個名為 *Occur* buffer 中。使用 M-s o 調用 occur 函數，搜索當前文檔。
;;   M-g n : 下一個匹配項
;;  M-g p : 上一個匹配項
;;  e : 進入 occur-edit-mode，可以編輯搜索結果
;;  C-c C-c : 退出編輯模式
;;  g : 刷新搜索結果
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s o") 'occur-dwim)

;; =============================
;; 縮寫補全 M-x abbrev-mode 
;; 使用下面的代碼我們可以開啟 abbrev 模式並定義一個縮寫表，每當我們輸入下面的縮寫並以空格結束時，Emacs 就會將其自動展開成為我們所需要的字符串。
;; 在要縮寫的字串後面輸入 C-x a i g  後輸入想要轉換輸出的字串
;; 記錄過的縮寫字串會自動儲存 The abbrevs are automatically saved between sessions in a file ~/.abbrev_defs.
;; 範本  https://www.emacswiki.org/emacs/AbbrevMode#toc6  
(abbrev-mode 1)
(setq abbrev-file-name             ;; tell emacs where to read abbrev
        "~/.emacs.d/abbrev_defs")    ;; definitions from...
(setq-default abbrev-mode t)

;; ================================
;; org-present-mode 讓文件變成像是 PPT 幻燈片一樣 且鎖定唯讀
(autoload 'org-present "org-present" nil t)
(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                ; (org-present-big) ;進入模式後，讓字體變大
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                ; (org-present-small) ;退出模式後，讓字體變小
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))
;; Then start the minor mode with:  M-x org-present
;; Keys are:
;;     left/right for movement
;;     C-c C-= for large txt
;;     C-c C-- for small text
;;     C-c C-q for quit (which will return you back to vanilla org-mode)
;;     C-c < and C-c > to jump to first/last slide

;; =============================
;; which-key 快速鍵提示  M-x package-install which-key   按下快速鍵後，會提示後面該按什麼
(add-to-list 'load-path "path/to/which-key.el")
(require 'which-key)
(which-key-mode)
;;;; 顯示在底部 Side Window Bottom Option
;; (which-key-setup-side-window-bottom)
;;;; 顯示在右邊
;;;;(which-key-setup-side-window-right)
;;;; 顯示在右邊若是沒空間顯示在下方
(which-key-setup-side-window-right-bottom)

;; =============================
;; 自動啓動 Ledger-mode
(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
(add-to-list 'load-path
             (expand-file-name "/home/kevin/.emacs.d/plugins/ledger-mode"))
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))
;; http://melpa.org/#/ledger-mode

;; =============================
;; 使用 C-x d 就可以進入 Dired Mode
(put 'dired-find-alternate-file 'disabled nil) ;; 讓 Dired Mode 只使用一個視窗
;; 基本操作
;;     Enter 開啟檔案
;;     + 創建目錄
;;     g 刷新目錄
;;     C 拷貝
;;     D 刪除
;;     R 重命名/移動檔案
;;     d 標記刪除
;;     u 取消標記
;;     x 執行所有的標記
;;     Z 以 gzip 壓縮/解壓縮
;;     m 	標記單一檔案
;;     u 	反標記單一檔案
;;     U 	反標記所有已標記的檔案
;;     % m	標記符合特定表達式的檔案
;;     ^ 	回上一層 (../)
;;     a 	在當前 buffer 開新目錄

;; =============================
;; yasnippet-mode 模板替換系統  https://github.com/joaotavora/yasnippet
;; install
;; $ cd ~/.emacs.d/plugins
;; $ git clone --recursive https://github.com/capitaomorte/yasnippet
;; Add the following in your .emacs file:
;; (add-to-list 'load-path  "~/.emacs.d/plugins/yasnippet")
;; (require 'yasnippet)
;; (yas-global-mode 1)
;; Add your own snippets to ~/.emacs.d/snippets by placing files there or invoking yas-new-snippet.

;; =============================
(require 'hungry-delete) ;; 使用 Backspace 時儘可能的刪除多餘空格
(global-hungry-delete-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;  備份與加密
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 設定一下制作備份時的版本控制，這樣更加安全。
;; 保留最原始的兩個版本和最新的五個版本。並且備份的時候，備份文件是複本，而不是原件。 
;; (setq version-control t)
;; (setq kept-old-versions 2)
;; (setq kept-new-versions 5)
;; (setq delete-old-versions t)
;; (setq backup-directory-alist '(("." . "~/.autosave"))) ;;設定自動備份檔案儲存的目錄
;; (setq backup-by-copying t)

;;org-mode 加密設定
(require 'org-crypt)
;; 當被加密的部份要存入硬碟時，自動加密回去
(org-crypt-use-before-save-magic)
;; 設定要加密的 tag 標籤為 secret
(setq org-crypt-tag-matcher "secret")
;; 避免 secret 這個 tag 被子項目繼承 造成重複加密
;; (但是子項目還是會被加密喔)
(setq org-tags-exclude-from-inheritance (quote ("secret")))
;; 用於加密的 GPG 金鑰
;; 可以設定任何 ID 或是設成 nil 來使用對稱式加密 (symmetric encryption)
(setq org-crypt-key nil)
;; M-x org-decrypt-entry  顯示加密內容


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;        行事曆設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 圖形化行事曆
(require 'calfw-org)
;; Then, M-x cfw:open-org-calendar.
;; You can choose agenda items with cfw:org-agenda-schedule-args, like following code: 
(global-set-key [f5] 'cfw:open-org-calendar)
;; (setq cfw:org-agenda-schedule-args '(:timestamp))
(setq cfw:org-overwrite-default-keybinding t)
;; key 	function
;; g 	Refresh data and re-draw contents (cfw:refresh-calendar-buffer)
;; j 	Goto the specified date (cfw:org-goto-date)
;; k 	org-capture
;; x 	Close calfw and other buffers opened by calfw-org (cfw:org-clean-exit)
;; d 	Day view (cfw:change-view-day)
;; v d 	Day view (cfw:change-view-day)
;; v w 	1 Week view (cfw:change-view-week)
;; v m 	Month View (cfw:change-view-month)

(setq calendar-week-start-day 1);;設定星期的第 1 天是星期一

;;插入日期，格式為習慣的 YYYY/mm/dd（星期），使用方法為 C-c d
(defun my-insert-date ()
    (interactive)
    (insert (format-time-string "%Y-%m-%d 週%a " (current-time))))
  (global-set-key (kbd "C-c d") 'my-insert-date)

;;;;;;;;;;新增台灣日曆
;;(add-to-list 'load-path "~/.emacs.d/")
(require 'taiwan-holidays)
(setq mark-holidays-in-calendar t)
(setq taiwan-holidays-important-holidays taiwan-holidays-taiwan-holidays)
(setq calendar-holidays taiwan-holidays-important-holidays)
