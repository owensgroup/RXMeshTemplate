# RXMeshTemplate [![Windows](https://github.com/owensgroup/RXMeshTemplate/actions/workflows/Windows.yml/badge.svg?branch=main)](https://github.com/owensgroup/RXMeshTemplate/actions/workflows/Windows.yml) [![Ubuntu](https://github.com/owensgroup/RXMeshTemplate/actions/workflows/Ubuntu.yml/badge.svg?branch=main)](https://github.com/owensgroup/RXMeshTemplate/actions/workflows/Ubuntu.yml)

A minimal CMake template project for developing GPU/CUDA projects that use [RXMesh](https://github.com/owensgroup/RXMesh/) on both Windows (Visual Studio) and Linux (GCC/Clang), with GitHub Actions CI included.

Documentation: [RXMesh Docs](https://ahdhn.github.io/RXMeshDocs/)

## Requirements

- CMake 3.25 or newer
- A C++17 compiler
- A CUDA toolkit and a supported NVIDIA GPU

## Build

Configure and build a release:

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release --parallel
```

The default CUDA architecture is `native`. On a headless builder without a GPU, or when cross-compiling, provide one numeric architecture explicitly:

```bash
cmake -S . -B build -DCMAKE_CUDA_ARCHITECTURES=89
```

### Visualization

[Polyscope](https://polyscope.run/) visualization is enabled by default. For a headless build, disable it during configuration:

```bash
cmake -S . -B build -DRX_USE_POLYSCOPE=OFF
```

### Run

On Linux with a single-config generator:

```bash
./build/bin/RXMeshTemplate sphere3.obj
```

On Windows with Visual Studio:

```bash
.\build\bin\Release\RXMeshTemplate.exe sphere3.obj
```

## Notes

- Rename the project and executable by changing `RXMeshTemplate` in `CMakeLists.txt`.

- CI builds a headless configuration on Windows and Ubuntu. Hosted runners do not provide a GPU, so CI compiles the application but does not execute it.
