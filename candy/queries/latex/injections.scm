;; extends

((generic_environment
  begin: (begin
    name: (curly_group_text
      (text) @_env))) @injection.content
  (#any-of? @_env "code" "spec")
  (#has-filetype? "lhaskell")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.language "haskell")
  (#set! injection.include-children)
  (#set! injection.combined))

