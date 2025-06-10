# RXMeshTemplate [![Windows](https://github.com/owensgroup/RXMeshTemplate/actions/workflows/Windows.yml/badge.svg?branch=main)](https://github.com/owensgroup/RXMeshTemplate/actions/workflows/Windows.yml) [![Ubuntu](https://github.com/owensgroup/RXMeshTemplate/actions/workflows/Ubuntu.yml/badge.svg?branch=main)](https://github.com/owensgroup/RXMeshTemplate/actions/workflows/Ubuntu.yml)

A minimal CMake template project for developing GPU/CUDA projects that use [RXMesh](https://github.com/owensgroup/RXMesh/) on both Windows (Visual Studio) and Linux (GCC/Clang), with GitHub Actions CI included.

📘 Documentation: [RXMesh Docs](https://ahdhn.github.io/RXMeshDocs//)

---

## Build

To configure and build:

```bash
mkdir build
cd build
cmake ..
```
This generates a `.sln` file on Windows or a Makefile on Linux. You can control rendering support using the `RX_USE_POLYSCOPE` option:

```bash
cmake -DRX_USE_POLYSCOPE=ON ..
```

Set it to `OFF` to disable [Polyscope](https://polyscope.run/).


---

## Notes

- You may want to rename the project in `CMakeLists.txt` and refactor the folder name accordingly.

- CI runs on Windows and Ubuntu using GitHub Actions.