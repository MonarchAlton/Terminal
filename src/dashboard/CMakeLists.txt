add_executable(dashboard
    main.cpp
)

target_link_libraries(dashboard
    PRIVATE
        project_options
)