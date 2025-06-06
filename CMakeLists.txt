cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

project(RXMeshTemplate 
	LANGUAGES CXX CUDA)  

if (CMAKE_BUILD_TYPE STREQUAL "")
    set(CMAKE_BUILD_TYPE Release)
endif ()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)

set(RX_USE_POLYSCOPE "ON" CACHE BOOL "Enable Ployscope for visualization")
set(RX_BUILD_TESTS "OFF" CACHE BOOL "Build RXMesh unit test")
set(RX_BUILD_APPS "OFF" CACHE BOOL "Build RXMesh applications")

include(FetchContent)
# RXMesh
FetchContent_Declare(rxmesh
    GIT_REPOSITORY https://github.com/owensgroup/RXMesh
    GIT_TAG        main
)
FetchContent_MakeAvailable(rxmesh)


# Auto-detect GPU architecture
include("cmake/AutoDetectCudaArch.cmake")

# CUDA and C++ compiler flags
set(cxx_flags 
	$<$<CXX_COMPILER_ID:MSVC>:-D_SCL_SECURE_NO_WARNINGS /openmp /std:c++17> #<TODO> Add MSVC-specific compiler flags here
	$<$<CXX_COMPILER_ID:GNU>:-Wall -m64 -fopenmp -O3 -std=c++17>            #<TODO> Add GCC compiler flags here
	$<$<CXX_COMPILER_ID:Clang>:-Wall -m64 -fopenmp -O3 -std=c++17>          #<TODO> Add Clang compiler flags here
	)

set(MSVC_XCOMPILER_FLAGS "/openmp /std:c++17")
set(cuda_flags
    $<$<CXX_COMPILER_ID:GNU>:-Xcompiler -Wall -fopenmp -O3>
	$<$<CXX_COMPILER_ID:Clang>:-Xcompiler -Wall -fopenmp -O3>
	$<$<CXX_COMPILER_ID:MSVC>:-Xcompiler ${MSVC_XCOMPILER_FLAGS}>
    -Xcudafe=--display_error_number    
	-lineinfo	
	--expt-extended-lambda	
	-use_fast_math		
    $<$<CXX_COMPILER_ID:GNU>:-O3>	
	--expt-relaxed-constexpr	
    -Xptxas -warn-spills -res-usage   
	--ptxas-options=-v	
    #-G	
)
add_library(developer_flags INTERFACE)
target_compile_options(developer_flags INTERFACE
    $<$<COMPILE_LANGUAGE:CXX>:${cxx_flags}>
    $<$<COMPILE_LANGUAGE:CUDA>:${cuda_flags}>
)
target_include_directories(developer_flags INTERFACE ${CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES})

target_compile_features(developer_flags INTERFACE cxx_std_17)

#OpenMP
find_package(OpenMP)
if(OpenMP_CXX_FOUND)
    target_link_libraries(developer_flags INTERFACE OpenMP::OpenMP_CXX)
endif()

set(CMAKE_CUDA_SEPARABLE_COMPILATION ON)
set(CMAKE_CUDA_RESOLVE_DEVICE_SYMBOLS ON)

#executable
add_executable(${PROJECT_NAME} main.cu)

#link to RXMesh
target_link_libraries(${PROJECT_NAME} 
	RXMesh	
	developer_flags
)