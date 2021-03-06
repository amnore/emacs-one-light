;;; one-light-syntax.el --- One Light syntax theme -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'one-light-lib)
(eval-when-compile (require 'names))

(defface lsp-face-semhl-declaration nil
  "LSP face for declaration modifier.")

(defface lsp-face-semhl-readonly nil
  "LSP face for readonly modifier.")

(defface lsp-face-semhl-abstract nil
  "LSP face for abstract modifier.")

(defface lsp-face-semhl-async nil
  "LSP face for async modifier.")

(defface lsp-face-semhl-modification nil
  "LSP face for modification modifier.")

(defface lsp-face-semhl-documentation nil
  "LSP face for documentation modifier.")

(define-namespace one-light-- :global t

(let* (;;; colors.less
       ;; Config
       (syntax-hue (degree-to-ratio 230))
       (syntax-saturation 0.01)
       (syntax-brightness 0.98)
       ;; Monochrome
       (mono-1 `(,syntax-hue 0.08 0.24))
       (mono-2 `(,syntax-hue 0.06 0.44))
       (mono-3 `(,syntax-hue 0.04 0.64))
       ;; Colors
       (hue-1 `(,(degree-to-ratio 198) 0.99 0.37)) ; cyan
       (hue-2 `(,(degree-to-ratio 221) 0.87 0.6)) ; blue
       (hue-3 `(,(degree-to-ratio 301) 0.63 0.4)) ; purple
       (hue-4 `(,(degree-to-ratio 119) 0.34 0.47)) ; green
       (hue-5 `(,(degree-to-ratio 5) 0.74 0.59)) ; red 1
       (hue-5-2 `(,(degree-to-ratio 344) 0.84 0.43)) ; red 2
       (hue-6 `(,(degree-to-ratio 35) 0.99 0.36)) ; orange 1
       (hue-6-2 `(,(degree-to-ratio 35) 0.99 0.4)) ; orange 2
       ;; Base colors
       (syntax-fg mono-1)
       (syntax-bg `(,syntax-hue ,syntax-saturation ,syntax-brightness))
       (syntax-gutter (darken syntax-bg 0.36))
       (syntax-guide (mix syntax-fg syntax-bg 0.2))
       (syntax-accent `(,syntax-hue 1 0.66))

         ;;; syntax-variables.less
       ;; General colors
       (syntax-text-color syntax-fg)
       (syntax-cursor-color syntax-accent)
       (syntax-selection-color (darken syntax-bg 0.08))
       (syntax-selection-flash-color syntax-accent)
       (syntax-background-color syntax-bg)
       ;; Guide colors
       (syntax-wrap-guide-color syntax-guide)
       (syntax-indent-guide-color syntax-guide)
       (syntax-invisible-character-color syntax-guide)
       ;; For find and replace markers
       (syntax-result-marker-color (mix syntax-accent syntax-bg 0.2))
       (syntax-result-marker-color-selected syntax-accent)
       ;; Gutter colors
       (syntax-gutter-text-color syntax-gutter)
       (syntax-gutter-text-color-selected syntax-fg)
       (syntax-gutter-background-color syntax-bg)
       (syntax-gutter-background-color-selected (darken syntax-bg 0.08))
       ;; Git colors - For git diff info. i.e. in the gutter
       (syntax-color-renamed `(,(degree-to-ratio 208) 1 0.66))
       (syntax-color-added `(,(degree-to-ratio 132) 0.6 0.44))
       (syntax-color-modified `(,(degree-to-ratio 40) 0.9 0.5))
       (syntax-color-removed `(,(degree-to-ratio 0) 1 0.54))
       ;; For language entity colors
       (syntax-color-variable hue-5)
       (syntax-color-constant hue-6)
       (syntax-color-property syntax-fg)
       (syntax-color-value syntax-fg)
       (syntax-color-function hue-2)
       (syntax-color-method hue-2)
       (syntax-color-class hue-6-2)
       (syntax-color-keyword hue-3)
       (syntax-color-tag hue-5)
       (syntax-color-attribute hue-6)
       (syntax-color-import hue-3)
       (syntax-color-snippet hue-4)
       ;; Custom Syntax Variables
       (syntax-cursor-line (mix syntax-fg syntax-bg 0.05))
       (syntax-deprecated-fg (darken syntax-color-modified 0.5))
       (syntax-deprecated-bg syntax-color-modified)
       (syntax-illegal-fg (name-to-hsl "white"))
       (syntax-illegal-bg syntax-color-removed)

       (tc '((class color) (min-colors 16777216))))
  (custom-theme-set-faces
   'one-light

   ;; faces.el
   `(default ((,tc (:foreground ,(hsl-to-hex syntax-text-color)
                    :background ,(hsl-to-hex syntax-background-color)))))
                                        ; editor.less: atom-text-editor
   ;; `(shadow ((,tc (:foreground ,(hsl-to-hex text-color-subtle)))))
   `(link ((,tc (:inherit underline
                 :foreground ,(hsl-to-hex hue-1)))))
                                        ; base.less: .syntax--link,
                                        ; .syntax--markup.syntax--underline
   `(link-visited ((,tc (:inherit link))))
   `(highlight ((,tc (:background ,(hsl-to-hex syntax-selection-color)))))
   `(region ((,tc (:background ,(hsl-to-hex syntax-selection-color)))))
                                        ; editor.less: .region
   `(secondary-selection ((,tc (:inherit region))))
                                        ; editor.less: .region
   ;; `(trailing-whitespace ((,tc (:underline ,(hsl-to-hex accent-color)))))
   `(line-number
     ((,tc (:foreground ,(hsl-to-hex syntax-gutter-text-color)))))
                                        ; editor.less: .gutter.line-number
   `(line-number-current-line
     ((,tc (:foreground ,(hsl-to-hex syntax-gutter-text-color-selected)))))
                                        ; editor.less: .gutter.cursor-line,
                                        ; .gutter.cursor-line-no-selection
   `(fill-column-indicator
     ((,tc (:foreground ,(hsl-to-hex syntax-wrap-guide-color)))))
                                        ; editor.less: .wrap-guide
   `(escape-glyph ((,tc (:foreground ,(hsl-to-hex hue-4)))))
                                        ; base.less: .syntax-escape

   `(minibuffer-prompt ((,tc nil)))

   `(cursor ((,tc (:background ,(hsl-to-hex syntax-cursor-color)))))
                                        ; editor.less: .cursor
   `(glyphless-char
     ((,tc (:foreground ,(hsl-to-hex syntax-invisible-character-color)))))
                                        ; editor.less: .invisible-character
   `(show-paren-match ((,tc (:underline ,(hsl-to-hex syntax-cursor-color)))))
                                        ; editor.less: .bracket-matcher.region
   `(show-paren-match-expression ((,tc (:inherit show-paren-match))))
   `(show-paren-mismatch ((,tc nil)))

   ;; whitespace.el
   `(whitespace-space ((,tc (:inherit glyphless-char))))
   `(whitespace-hspace ((,tc (:inherit glyphless-char))))
   `(whitespace-tab ((,tc (:inherit glyphless-char))))
   `(whitespace-newline ((,tc (:inherit glyphless-char))))
   `(whitespace-trailing ((,tc (:inherit glyphless-char))))
   `(whitespace-line ((,tc nil)))
   `(whitespace-space-before-tab ((,tc (:inherit glyphless-char))))
   `(whitespace-indentation ((,tc (:inherit glyphless-char))))
   `(whitespace-big-indent ((,tc (:inherit glyphless-char))))
   `(whitespace-missing-newline-at-eof ((,tc (:inherit glyphless-char))))
   `(whitespace-empty ((,tc (:inherit glyphless-char))))
   `(whitespace-space-after-tab ((,tc (:inherit glyphless-char))))

   ;; hl-line.el
   `(hl-line ((,tc (:background ,(hsl-to-hex syntax-cursor-line)))))

   ;; isearch.el
   `(isearch
     ((,tc (:inherit lazy-highlight
            :box (:line-width 2
                  :color ,(hsl-to-hex syntax-result-marker-color-selected))))))
                                        ; editor.less: .current-result
   `(lazy-highlight
     ((,tc (:background ,(hsl-to-hex syntax-result-marker-color)))))
                                        ; editor.less: .find-result

   ;; font-lock.el
   `(font-lock-warning-face ((,tc (:inherit warning))))
   `(font-lock-function-name-face ((,tc (:foreground ,(hsl-to-hex hue-2)))))
                                        ; base.less: .syntax--function
   `(font-lock-variable-name-face ((,tc (:foreground ,(hsl-to-hex mono-1)))))
                                        ; base.less: .syntax--entity
   `(font-lock-keyword-face ((,tc (:foreground ,(hsl-to-hex hue-3)))))
                                        ; base.less: .syntax--keyword
   `(font-lock-comment-face ((,tc (:foreground ,(hsl-to-hex mono-3)
                                   :slant italic))))
                                        ; base.less: .syntax--comment
   `(font-lock-comment-delimiter-face ((,tc (:inherit font-lock-comment-face))))
   `(font-lock-type-face ((,tc (:foreground ,(hsl-to-hex hue-1)))))
                                        ; base.less: .syntax--type
   `(font-lock-constant-face ((,tc (:foreground ,(hsl-to-hex hue-6)))))
                                        ; base.less: .syntax--constant
   `(font-lock-builtin-face ((,tc (:foreground ,(hsl-to-hex hue-5)))))
                                        ; base.less: .syntax--function
   `(font-lock-preprocessor-face
     ((,tc (:inherit font-lock-keyword-face))))
   `(font-lock-string-face ((,tc (:foreground ,(hsl-to-hex hue-4)))))
                                        ; base.less: .syntax--string
   `(font-lock-doc-face ((,tc (:inherit font-lock-comment-face))))
   `(font-lock-doc-markup-face
     ((,tc (:foreground ,(hsl-to-hex (lighten mono-3 0.06))
            :weight bold))))
                                        ; base.less: .syntax--comment.syntax--caption
                                        ; base.less: .
   `(font-lock-negation-char-face ((,tc (:foreground ,(hsl-to-hex hue-3)))))
                                        ; base.less: .syntax--operator
   `(font-lock-regexp-grouping-backslash
     ((,tc (:foreground ,(hsl-to-hex hue-3)))))
                                        ; base.less: syntax--regex.syntax--punctuation
   `(font-lock-regexp-grouping-construct
     ((,tc (:foreground ,(hsl-to-hex hue-3)))))
                                        ; base.less: syntax--regex.syntax--punctuation

   ;; lsp-semantic-tokens.el
   `(lsp-face-semhl-namespace ((,tc (:inherit lsp-face-semhl-constant))))
   `(lsp-face-semhl-regexp ((,tc (:inherit lsp-face-semhl-string))))
   `(lsp-face-semhl-operator ((,tc (:inherit lsp-face-semhl-keyword))))
   `(lsp-face-semhl-enum ((,tc (:inherit lsp-face-semhl-type))))
   `(lsp-face-semhl-member ((,tc (:foreground ,(hsl-to-hex hue-5)))))
                                        ; base.less: .syntax--variable
   `(lsp-face-semhl-property
     ((,tc (:inherit lsp-face-semhl-member))))
   `(lsp-face-semhl-macro ((,tc (:inherit lsp-face-semhl-constant))))
   `(lsp-face-semhl-label ((,tc (:underline t))))

   ;; TODO: Add face to modifiers
   `(lsp-face-semhl-declaration ((,tc nil)))
   `(lsp-face-semhl-definition ((,tc nil)))
   `(lsp-face-semhl-readonly ((,tc nil)))
   `(lsp-face-semhl-static ((,tc nil)))
   `(lsp-face-semhl-deprecated ((,tc nil)))
   `(lsp-face-semhl-abstract ((,tc nil)))
   `(lsp-face-semhl-async ((,tc nil)))
   `(lsp-face-semhl-modification ((,tc nil)))
   `(lsp-face-semhl-documentation ((,tc nil)))
   `(lsp-face-semhl-default-library ((,tc nil)))

   ;; button.el
   `(button ((,tc (:inherit underline))))

   ;; mmm-vars.el
   `(mmm-default-submode-face ((,tc ())))

   ;; hl-todo.el
   `(hl-todo ((,tc (:foreground ,(hsl-to-hex (lighten mono-3 0.06))
                    :weight bold))))
                                        ; base.less: .syntax--comment.syntax--caption

   ;; css-mode.el
   `(css-selector ((,tc (:foreground ,(hsl-to-hex hue-6)))))
   `(css-property ((,tc (:foreground ,(hsl-to-hex mono-1)))))

   ;; web-mode.el
   `(web-mode-error-face ((,tc (:inherit error))))
   `(web-mode-symbol-face ((,tc (:inherit font-lock-variable-name-face))))
   `(web-mode-doctype-face ((,tc (:foreground ,(hsl-to-hex mono-1)))))
                                        ; syntax-legacy/_base.less: .syntax--meta.syntax--tag
   `(web-mode-html-tag-face ((,tc (:foreground ,(hsl-to-hex hue-5)))))
                                        ; base.less: .syntax--entity.syntax--span
   `(web-mode-html-tag-bracket-face ((,tc (:foreground ,(hsl-to-hex mono-1)))))
                                        ; base.less: .syntax--punctuation
   `(web-mode-html-attr-name-face ((,tc (:foreground ,(hsl-to-hex hue-6)))))
                                        ; base.less: .syntax--entity.syntax--attribute
   `(web-mode-html-attr-engine-face
     ((,tc (:inherit web-mode-html-attr-name-face))))
   `(web-mode-css-selector-face ((,tc (:inherit css-selector))))
                                        ; css.less: .syntax--css.syntax--selector
   `(web-mode-css-pseudo-class-face
     ((,tc (:inherit web-mode-css-selector-face))))
   `(web-mode-css-property-name-face ((,tc (:inherit css-property))))
   `(web-mode-css-color-face ((,tc (:foreground ,(hsl-to-hex hue-6)))))
                                        ; css.less: .syntax--css.syntax--constant.syntax--color
   `(web-mode-css-priority-face ((,tc (:inherit font-lock-keyword-face))))
   `(web-mode-css-function-face ((,tc (:inherit font-lock-function-name-face))))
   `(web-mode-css-variable-face ((,tc (:foreground ,(hsl-to-hex hue-5)))))))

(with-eval-after-load 'lsp-semantic-tokens
  (setq lsp-semantic-token-modifier-faces
        '(("declaration" . lsp-face-semhl-declaration)
          ("definition" . lsp-face-semhl-definition)
          ("readonly" . lsp-face-semhl-readonly)
          ("static" . lsp-face-semhl-static)
          ("deprecated" . lsp-face-semhl-deprecated)
          ("abstract" . lsp-face-semhl-abstract)
          ("async" . lsp-face-semhl-async)
          ("modification" . lsp-face-semhl-modification)
          ("documentation" . lsp-face-semhl-documentation)
          ("defaultLibrary" . lsp-face-semhl-default-library))))

)



(provide 'one-light-syntax)
;;; one-light-syntax.el ends here
