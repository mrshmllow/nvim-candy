;; extends

(macro_invocation
  macro: (scoped_identifier
    name: (identifier) @_ident (#any-of? @_ident "query")
  )

  (token_tree .
    (string_literal) @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.combined)
    (#set! injection.language "sql")
  )
)

(macro_invocation
  macro: (scoped_identifier
    name: (identifier) @_ident (#eq? @_ident "query_as")
  )

  (token_tree
    (_) .
    (string_literal) @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.combined)
    (#set! injection.language "sql")
  )
)
