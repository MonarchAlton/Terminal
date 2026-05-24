add_executable(singleton_tests
    singleton_tests.cpp
)

target_link_libraries(singleton_tests
    PRIVATE
        Catch2::Catch2WithMain
        singleton
)

disable_clang_tidy_for_target(singleton_tests)

add_test(
    NAME unit.shared.singleton
    COMMAND singleton_tests
)