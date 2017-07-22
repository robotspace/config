;;; chinese-calendar.el --- calendar for chinese

;; Copyright (C) 2004  Free Software Foundation, Inc.

;; Author: Charles Wang <charleswang@peoplemail.com.cn>
;; Keywords: calendar, i18n

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; installation:
;;  put the following line in your .emacs
;;
;;                (add-to-path 'load-path "path/where/to/chinese-calendar.el"
;;                (require 'chinese-calendar)
;;; Code:


(require 'calendar)
(require 'cal-china)

(defun wcy-calendar-remapkey())
(add-hook 'calendar-load-hook 'wcy-calendar-remapkey)

(defun wcy-calendar-move-hook ()
  (wcy-calender-set-mode-line))
(add-hook 'calendar-move-hook 'wcy-calendar-move-hook)

(defun wcy-calendar-init-windows-hook()
  (wcy-calender-set-mode-line))
(add-hook 'initial-calendar-window-hook 'wcy-calendar-init-windows-hook)


(setq chinese-calendar-celestial-stem
  ["��" "��" "��" "��" "��" "��" "��" "��" "��" "��"])
(setq chinese-calendar-terrestrial-branch
  ["��" "��" "��" "î" "��" "��" "��" "δ" "��" "��" "��" "��"])

(setq chinese-number ["һ" "��" "��" "��" "��" "��" "��" "��" "��" "ʮ"])
(defun wcy-chinese-day-name (date)
  (let ((day  (calendar-day-of-week date)))
    (concat "����" 
            (if (eq day 0)
                "��"
              (aref chinese-number (1- day))))))

(defun wcy-calendar-display-form (date)
  (let* ((dayname (wcy-chinese-day-name date))
         (day   (extract-calendar-day date))
         (month (extract-calendar-month date))
         (year  (extract-calendar-year date)))
    (format "%4d��%2d��%2d�� %s" year month day dayname)))
;;

(setq chinese-date-diary-pattern 
      '(( year " *��" month " *��" day "�� *[^/��0-9]")
        ( year "-" month "-" day "[^0-9]")
        (day "/" month "[^/0-9]")
        (day "/" month "/" year "[^0-9]")
        (backup day " *" monthname "\\W+\\<\\([^*0-9]\\|\\([0-9]+[:aApP]\\)\\)")
        (day " *" monthname " *" year "[^0-9]")
        (dayname "\\W")))
(setq calendar-date-display-form '((wcy-calendar-display-form date)))
(setq diary-date-forms chinese-date-diary-pattern)

(defun wcy-count-chinese-character (string)
  (length (remq nil
                (mapcar 'multibyte-string-p 
                        (mapcar 'char-to-string string)))))

(setq wcy-chinese-month-name ["����" "����" "����" "����" "����" "����" "����" "����" "����" "ʮ��" "ʮһ��" "����"])
(setq wcy-chinese-day-name 
      [
       "��һ" "����" "����" "����" "����" "����" "����" "����" "����" "��ʮ" 
       "ʮһ" "ʮ��" "ʮ��" "ʮ��" "ʮ��" "ʮ��" "ʮ��" "ʮ��" "ʮ��"  "إ"
       "إһ" "إ��" "إ��" "إ��" "إ��" "إ��" "إ��" "إ��" "إ��" "��ʮ"
       "ئһ" "ئ��" "ئ��" "ئ��" "ئ��" "ئ��" "ئ��" "ئ��" "ئ��" "ئʮ"
       ])

(defun wcy-chinese-date-string (date)
  (let* ((a-date (calendar-absolute-from-gregorian date))
         (c-date (calendar-chinese-from-absolute a-date))
         (cycle (car c-date))
         (year (car (cdr c-date)))
         (month (car (cdr (cdr c-date))))
         (day (car (cdr (cdr (cdr c-date)))))
         (this-month (calendar-absolute-from-chinese
                      (list cycle year month 1)))
         (next-month (calendar-absolute-from-chinese
                      (list (if (= year 60) (1+ cycle) cycle)
                            (if (= (floor month) 12) (1+ year) year)
                            (calendar-mod (1+ (floor month)) 12)
                            1)))
         (m-cycle (% (+ (* year 5) (floor month)) 60)))
    (format "ũ��%s��%s%s%s"
            ;;cycle
            ;;year 
            (calendar-chinese-sexagesimal-name year)
            (if (not (integerp month))
                "��"
              (if (< 30 (- next-month this-month))
                  ""
                ""))
            (aref wcy-chinese-month-name (1- (floor month)))
            (aref wcy-chinese-day-name (1- day))
            )))

(defun wcy-calender-set-mode-line ()
  (let* ((date (calendar-cursor-to-date))
         (s1 (calendar-date-string date t))
         (s2 (wcy-chinese-date-string date))
         (x (list s1 s2))
         (y (make-string (apply '+  (mapcar 'wcy-count-chinese-character x )) ? )))
    (progn
      (setq calendar-mode-line-format 
            (append x (list y)))
      (update-calendar-mode-line)
      (force-mode-line-update))))
    
;;; the following function is copied from calendar.el or cal-china.el
;;; because they don't conform with the chinese traditional presentation.

(defun calendar-chinese-sexagesimal-name (n)
  "The N-th name of the Chinese sexagesimal cycle.
N congruent to 1 gives the first name, N congruent to 2 gives the second name,
..., N congruent to 60 gives the sixtieth name."
  (format "%s%s"
          (aref chinese-calendar-celestial-stem (% (1- n) 10))
          (aref chinese-calendar-terrestrial-branch (% (1- n) 12))))

(defun generate-calendar-month (month year indent)
  "Produce a calendar for MONTH, YEAR on the Gregorian calendar.
The calendar is inserted in the buffer starting at the line on which point
is currently located, but indented INDENT spaces.  The indentation is done
from the first character on the line and does not disturb the first INDENT
characters on the line."
  (let* ((blank-days;; at start of month
          (mod
           (- (calendar-day-of-week (list month 1 year))
              calendar-week-start-day)
           7))
	 (last (calendar-last-day-of-month month year)))
   (goto-char (point-min))
   (calendar-insert-indented
    (calendar-string-spread
     (list (format "%d��%d��" year month)) ?  20)
    indent t)
   (calendar-insert-indented "" indent);; Go to proper spot
   (calendar-for-loop i from 0 to 6 do
      (insert (calendar-day-name (mod (+ calendar-week-start-day i) 7)
                                 2 t))
      (insert " "))
   (calendar-insert-indented "" 0 t);; Force onto following line
   (calendar-insert-indented "" indent);; Go to proper spot
   ;; Add blank days before the first of the month
   (calendar-for-loop i from 1 to blank-days do (insert "   "))
   ;; Put in the days of the month
   (calendar-for-loop i from 1 to last do
      (insert (format "%2d " i))
      (add-text-properties
       (- (point) 3) (1- (point))
       '(mouse-face highlight
	 help-echo "mouse-2: menu of operations for this date"))
      (and (zerop (mod (+ i blank-days) 7))
           (/= i last)
           (calendar-insert-indented "" 0 t)    ;; Force onto following line
           (calendar-insert-indented "" indent)))));; Go to proper spot


(setq general-holidays 
      '((holiday-fixed 1 1 "Ԫ��")
        (holiday-chinese-new-year )
        (holiday-fixed 3 8 "��Ů��")
        (holiday-fixed 3 12 "ֲ����")
        (holiday-fixed 5 1 "�Ͷ���")
        (holiday-fixed 5 4 "�����")
        (holiday-fixed 6 1 "��ͯ��")
        (holiday-fixed 9 10 "��ʦ��")
        (holiday-fixed 10 1 "�����")))

(setq local-holidays nil)
(setq christian-holidays nil)
(setq hebrew-holidays  nil)
(setq islamic-holidays nil)

(setq other-holidays 
      '((holiday-fixed 2 14 "���˽�")
        (holiday-fixed 4 1 "���˽�")
        (holiday-fixed 12 25 "ʥ����")
        (holiday-float 5 0 2 "ĸ�׽�")
        (holiday-float 6 0 3 "���׽�")
        (holiday-float 11 4 4 "�ж���")))

(setq calendar-holidays
      (append general-holidays local-holidays other-holidays))

(defun holiday-chinese-new-year ()
  "Date of Chinese New Year."
  (let ((m displayed-month)
        (y displayed-year))
    (increment-calendar-month m y 1)
    (if (< m 5)
        (let ((chinese-new-year
               (calendar-gregorian-from-absolute
                (car (cdr (assoc 1 (chinese-year y)))))))
          (if (calendar-date-is-visible-p chinese-new-year)
          (list
           (list chinese-new-year
                 (format "%s�괺��"
                         (calendar-chinese-sexagesimal-name (+ y 57))))))))))
(setq solar-n-hemi-seasons
  '( "����" "����" "���"  "����"))
(setq solar-s-hemi-seasons
  '("���" "����" "����" "����"))
(provide 'chinese-calendar)
;;; chinese-calendar.el ends here
