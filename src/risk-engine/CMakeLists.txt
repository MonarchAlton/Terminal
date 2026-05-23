add_library(risk-engine STATIC
	risk-engine.cpp
	risk-engine.hpp
)

target_include_directories(risk-engine
	PUBLIC
	${CMAKE-CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_features(risk-engine
	PUBLIC
	cxx_std_23
)