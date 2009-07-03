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
;;
;; * Usage

(defvar search-engines
  "A list is search engines list. keys engines nick, and value is search engine query.
Search word %s. In formatting url-hexify. Use %% to put a single % into output."
	  '(("c" . "http://reference.sitepoint.com/search?q=%s")
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
		))

(defun search-web (engine word)
  (browse-url
   (format (cdr (assoc engine search-engines)) (url-hexify-string word))))

(defun search-web-at-point (engine)
  "search web search engine for word on cursor.
arg is search-engines keys."
  (interactive "sSearch engine: ")
  (web-search engine (substring-no-properties (thing-at-point 'word))))

(defun search-web-region (engine)
  (interactive "sSearch engine: ")
  (web-search engine (substring-no-properties (thing-at-point 'word))))


(provide 'search-web)

;;; search-web.el ends here
