;;; ob-treesitter.el --- Babel Functions for Tree-Sitter    -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Takeo Obara

;; Author: Takeo Obara <bararararatty@gmail.com>
;; Version: 0.0.1
;; Package-Requires: ((emacs "28") (org "9"))
;; Homepage: https://github.com/emacs-php/ob-treesitter
;; Keywords: tools, org, literate programming, reproducible research, treesitter
;; License: GPL-3.0-or-later

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Static analyze a block of PHP code with org-babel using Tree-Sitter.

;;; Code:
(require 'org)
(require 'ob)

(defgroup ob-treesitter nil
  "org-mode blocks for Tree-Sitter."
  :group 'org)

(defcustom org-babel-treesitter-command "tree-sitter"
  "The command to execute babel body code."
  :group 'ob-treesitter
  :type 'string)

;;;###autoload
(defun org-babel-execute:treesitter (body params)
  "Run tree-sitter parse with org-babel
This function is called by `org-babel-execute-src-block'."
  (let* ((lang (cdr (assoc :lang params)))
         (tmp-file (org-babel-temp-file "tree-sitter" (format ".%s" lang))))
    (with-temp-file tmp-file
      (insert (org-babel-expand-body:generic body params)))
    (message (format "%s parse %s"
                     org-babel-treesitter-command
                     (org-babel-process-file-name tmp-file)))
    (org-babel-eval (format "%s parse %s"
                            org-babel-treesitter-command
                            (org-babel-process-file-name tmp-file))
                    "")))

;;;###autoload
(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("treesitter" . treesitter)))

(provide 'ob-phpstan)
;;; ob-phpstan.el ends here
