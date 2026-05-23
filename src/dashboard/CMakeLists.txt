add_executable(dashboard
    main.cpp
)

target_link_libraries(dashboard
    PRIVATE
        application
)

target_compile_features(dashboard
    PRIVATE
        cxx_std_23
)