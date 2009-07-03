;;; search-web.el --- 
;; -*- coding: utf-8; mode:emacs-lisp -*-

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

;; * Description
;; search-web.el is posting search query browse-url.
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


(defvar search-engines
  '(("s" . "http://reference.sitepoint.com/search?q=%s")
	("g" . "http://www.google.com/search?q=%s")
	("gj" . "http://www.google.com/search?hl=ja&q=%s")
	("ge" . "http://www.google.com/search?hl=en&q=%s")
	("m" . "http://maps.google.co.jp/maps?hl=ja&q=%s")
	("y" . "http://search.yahoo.co.jp/search?p=%s")
	("yt" . "http://www.youtube.com/results?search_type=&search_query=%s&aq=f")
	("tw" . "http://search.twitter.com/search?q=%s")
	("goo" . "http://dictionary.goo.ne.jp/srch/all/%s/m0u/")
	("a" . "http://www.answers.com/topic/%s")
	("ew" . "http://www.google.com/cse?cx=004774160799092323420%%3A6-ff2s0o6yi&q=%s&sa=Search")
	("eow" . "http://eow.alc.co.jp/%s/UTF-8/")
	("z" . "http://www.amazon.com/s/url=search-alias%%3Daps&field-keywords=%s")
	("zj" . "http://www.amazon.co.jp/gp/search?index=blended&field-keywords=%s")
	("y" . "http://search.yahoo.com/search?p=%s")
	("yj" . "http://search.yahoo.co.jp/search?p=%s")
	("we" . "http://www.wikipedia.org/search-redirect.php?search=%s&language=en")
	("wj" . "http://www.wikipedia.org/search-redirect.php?search=%s&language=ja"))
  "A list is search engines list. keys engines nick, and value is search engine query.
Search word %s. In formatting url-hexify. Use %% to put a single % into output.")

(defun search-web (engine word)
  (browse-url
   (format (cdr (assoc engine search-engines)) (url-hexify-string word))))

(defun search-web-at-point (engine)
  "search web search engine for word on cursor.
arg is search-engines keys."
  (interactive "sSearch engine: ")
  (search-web engine (substring-no-properties (thing-at-point 'word))))

(defun search-web-region (engine)
  (interactive "sSearch engine: ")
  (let ((beg (mark))
        (end (point)))
	(search-web engine (buffer-substring-no-properties beg end))))

(provide 'search-web)

;;; search-web.el ends here
