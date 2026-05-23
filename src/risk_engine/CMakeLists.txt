add_library(risk_engine STATIC
	risk_engine.cpp
	risk_engine.hpp
)

target_include_directories(risk_engine
	PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_features(risk_engine
	PUBLIC
	cxx_std_23
)