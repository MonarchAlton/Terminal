add_library(pricing-engine STATIC
	pricing-engine.cpp
	pricing-engine.hpp
)

target_include_directories(pricing-engine
	PUBLIC
	${CMAKE-CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_features(pricing-engine
	PUBLIC
	cxx_std_23
)