; extends

(binding
  (attrpath
    (identifier) (#eq? "programs")
    (identifier) (#eq? "fish")
  )

  (attrset_expression
    (binding_set
      (binding
        (attrpath
          (identifier) (#any-of? "interactiveShellInit" "shellInit")
        )

        (indented_string_expression
          (string_fragment) @injection.content
          (#set! injection.combined)
          (#set! injection.language "fish")
        )
      )
    )
  ) 
)

(binding
  (attrpath
    (identifier) (#eq? "programs")
    (identifier) (#eq? "fish")
  )

  (attrset_expression
    (binding_set
      (binding
        (attrpath
          (identifier) (#eq? "functions")
        )

        (attrset_expression
          (binding_set
            (binding
              (attrset_expression
                (binding_set
                  (binding
                    (indented_string_expression
                      (string_fragment) @injection.content
                        (#set! injection.combined)
                        (#set! injection.language "fish")
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  ) 
)

(binding
  (attrpath
    (identifier) (#eq? "home")
    (identifier) (#eq? "shellAliases")
  )

  (attrset_expression
    (binding_set
      (binding
        (string_expression
          (string_fragment) @injection.content
            (#set! injection.combined)
            (#set! injection.language "fish")
        )
      )
    )
  ) 
)

