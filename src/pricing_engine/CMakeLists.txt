add_library(pricing_engine STATIC
	pricing_engine.cpp
	pricing_engine.hpp
)

target_include_directories(pricing_engine
	PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_features(pricing_engine
	PUBLIC
	cxx_std_23
)