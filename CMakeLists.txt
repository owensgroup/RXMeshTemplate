cmake_minimum_required(VERSION 3.25 FATAL_ERROR)

if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
    set(CMAKE_CUDA_ARCHITECTURES native)
endif()

project(RXMeshTemplate 
    LANGUAGES CXX CUDA)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CUDA_EXTENSIONS OFF)

if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin")

set(RX_USE_POLYSCOPE ON CACHE BOOL "Enable Polyscope visualization")
set(RX_BUILD_TESTS OFF CACHE BOOL "Build RXMesh unit tests")
set(RX_BUILD_APPS OFF CACHE BOOL "Build RXMesh applications")

include(FetchContent)
FetchContent_Declare(rxmesh
    GIT_REPOSITORY https://github.com/owensgroup/RXMesh
    GIT_TAG        main
)
FetchContent_MakeAvailable(rxmesh)

if(NOT COMMAND rxmesh_add_app)
    include("${rxmesh_SOURCE_DIR}/cmake/RXMeshApp.cmake")
endif()

rxmesh_add_app(${PROJECT_NAME}
    SOURCES main.cu
)
