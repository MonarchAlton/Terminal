add_executable(singleton_tests
    singleton_tests.cpp
)

target_link_libraries(singleton_tests
    PRIVATE
        project_options
        singleton
)

add_test(
    NAME unit.shared.singleton
    COMMAND singleton_tests
)