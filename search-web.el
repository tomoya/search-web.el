;;; search-web.el --- Post web search queries using `browse-url'.
;; -*- coding: utf-8; -*-

;; Copyright (C) 2009 Tomoya Otake
;; Author: Tomoya Otake <tomoya.ton@gmail.com>

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation; either version 2, or (at your
;; option) any later version.

;; This file is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; * Description

;; Post web search queries using `browse-url'.
;; 
;; There is useing style 2 way.
;; One is search-web-at-point.
;; This function is searching word on cursor.
;;
;; And one is search-web-region.
;; This func is searching region text.
;;
;;
;; * Usage
;; Just put the code like below into your .emacs:
;;
;; (require 'search-web)
;; 
;; Normal useing is M-x search-web-at-point or search-web-region.
;; But the way is not useability.
;;
;; A usefull way is setting search engine and using command.
;;
;; For example
;; CSS ref search
;; (define-key cssm-mode-map (kbd "C-c C-s r") (lambda () (interactive) (search-web-at-point "s")))
;; Press C-c s r post word on cursor sitepoint reference page at css-mode.
;;
;; EmacsWiki search
;; (define-key emacs-lisp-mode-map (kbd "C-c C-s e") (lambda () (interactive) (search-web-at-point "ew")))
;;
;; Google search at region
;; (define-key global-map (kbd "C-c C-s g") (lambda () (interactive) (search-web-region "g")))

;;; Code:

(defvar search-engines
  '(("sitepoint" . "http://reference.sitepoint.com/search?q=%s")
	("google" . "http://www.google.com/search?q=%s")
	("google ja" . "http://www.google.com/search?hl=ja&q=%s")
	("google en" . "http://www.google.com/search?hl=en&q=%s")
	("google maps" . "http://maps.google.co.jp/maps?hl=ja&q=%s")
	("youtube" . "http://www.youtube.com/results?search_type=&search_query=%s&aq=f")
	("twitter" . "http://search.twitter.com/search?q=%s")
	("goo" . "http://dictionary.goo.ne.jp/srch/all/%s/m0u/")
	("answers" . "http://www.answers.com/topic/%s")
	("emacswiki" . "http://www.google.com/cse?cx=004774160799092323420%%3A6-ff2s0o6yi&q=%s&sa=Search")
	("eijiro" . "http://eow.alc.co.jp/%s/UTF-8/")
	("amazon" . "http://www.amazon.com/s/url=search-alias%%3Daps&field-keywords=%s")
	("amazon jp" . "http://www.amazon.co.jp/gp/search?index=blended&field-keywords=%s")
	("yahoo" . "http://search.yahoo.com/search?p=%s")
	("yahoo jp" . "http://search.yahoo.co.jp/search?p=%s")
	("wikipedia en" . "http://www.wikipedia.org/search-redirect.php?search=%s&language=en")
	("wikipedia ja" . "http://www.wikipedia.org/search-redirect.php?search=%s&language=ja"))
  "A list is search engines list. keys engines nick, and value is search engine query.
Search word %s. In formatting url-hexify. Use %% to put a single % into output.")

(defun search-web (engine word)
  (browse-url
   (format (cdr (assoc engine search-engines)) (url-hexify-string word))))

;; (defun search-web-at-point (engine)
;;   "search web search engine for word on cursor.
;; arg is search-engines keys."
;;   (interactive "sSearch engine: ")
;;   (search-web engine (substring-no-properties (thing-at-point 'word))))

;; (defun search-web-region (engine)
;;   (interactive "sSearch engine: ")
;;   (let ((beg (mark))
;;         (end (point)))
;; 	(search-web engine (buffer-substring-no-properties beg end))))

;; idea for http://d.hatena.ne.jp/x244/20090704/1246649218
(defun make-search-engine-name-list ()
  (let ((result))
    (dolist (engine search-engines)
      (add-to-list 'result (car engine)))
    result))

(defun search-web-at-point ()
  (interactive)
  (let* ((completion-ignore-case t)
         (engine (completing-read "Search Engine: "
                                 (make-search-engine-name-list) nil t)))
  (search-web engine (substring-no-properties (thing-at-point 'word)))))

(defun search-web-region ()
  (interactive)
  (let* ((completion-ignore-case t)
         (beg (mark))
         (end (point))
         (engine (completing-read "Search Engine: "
                                  (make-search-engine-name-list) nil t)))
    (search-web engine (buffer-substring-no-properties beg end))))

(provide 'search-web)

;;; search-web.el ends here
