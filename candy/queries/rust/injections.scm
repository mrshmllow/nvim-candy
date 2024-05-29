;; extends

(macro_invocation
	macro: (scoped_identifier
		 path: (identifier) @path (#eq? @path "sqlx")
		 name: (identifier) @name (#any-of? @name "query_as" "query")
	)

	(token_tree
		(string_literal
		  (string_content) @injection.content
		)
	)

	(#set! injection.combined)
	(#set! injection.language "sql")
  )
