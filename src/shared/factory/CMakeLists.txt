add_library(factory INTERFACE)

target_include_directories(factory
    INTERFACE
        ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(factory
    INTERFACE
        project_options
        singleton
)