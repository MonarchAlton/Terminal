add_library(singleton INTERFACE)

target_include_directories(singleton
    INTERFACE
        ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(singleton
    INTERFACE
        project_options
)