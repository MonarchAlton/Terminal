add_executable(factory_tests
    factory_tests.cpp
)

target_link_libraries(factory_tests
    PRIVATE
        project_options
        factory
)

add_test(
    NAME unit.shared.factory
    COMMAND factory_tests
)