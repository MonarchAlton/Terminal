add_executable(dashboard
    main.cpp
 "platform/window.cpp" "rendering/rendering.cpp")

target_link_libraries(dashboard
    PRIVATE
        project_options
)