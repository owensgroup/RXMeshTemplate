cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
    set(CMAKE_CUDA_ARCHITECTURES native)
endif()

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

include("${rxmesh_SOURCE_DIR}/cmake/RXMeshApp.cmake")

rxmesh_add_app(${PROJECT_NAME}
  SOURCES main.cu
  LIBS RXMesh CLI11::CLI11
)