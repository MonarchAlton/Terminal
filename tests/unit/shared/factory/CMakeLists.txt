add_executable(factory_tests
    factory_tests.cpp
)

target_link_libraries(factory_tests
    PRIVATE
        factory
        Catch2::Catch2WithMain
)

disable_clang_tidy_for_target(factory_tests)

add_test(
    NAME unit.shared.factory
    COMMAND factory_tests
)