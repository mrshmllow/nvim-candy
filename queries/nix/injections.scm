(binding
  (attrpath
    (identifier) @_programs (#eq? @_programs "programs")
    (identifier) @_fish (#eq? @_fish "fish")
  )

  (attrset_expression
    (binding_set
      (binding
        (attrpath
          (identifier) @_area (#any-of? @_area "interactiveShellInit" "shellInit")
        )

        (indented_string_expression
          (string_fragment) @fish
        )
      )
    )
  ) 
)

(binding
  (attrpath
    (identifier) @_programs (#eq? @_programs "programs")
    (identifier) @_fish (#eq? @_fish "fish")
  )

  (attrset_expression
    (binding_set
      (binding
        (attrpath
          (identifier) @_function (#eq? @_function "functions")
        )

        (attrset_expression
          (binding_set
            (binding
              (attrset_expression
                (binding_set
                  (binding
                    (indented_string_expression
                      (string_fragment) @fish
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
    (identifier) @_home (#eq? @_home "home")
    (identifier) @_shell (#eq? @_shell "shellAliases")
  )

  (attrset_expression
    (binding_set
      (binding
        (string_expression
          (string_fragment) @fish
        )
      )
    )
  ) 
)

