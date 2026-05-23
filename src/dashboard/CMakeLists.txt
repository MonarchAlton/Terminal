add_executable(dashboard
    main.cpp
)

target_compile_features(dashboard
    PRIVATE
        cxx_std_23
)