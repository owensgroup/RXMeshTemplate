#include "rxmesh/rxmesh_static.h"

using namespace rxmesh;

int main(int argc, char** argv)
{
    rx_init(0);

    if (argc != 2) {
        RXMESH_ERROR("Invalid argument. Usage: RXMeshTemplate.exe input mesh");
        exit(EXIT_SUCCESS);
    }

    RXMeshStatic rx(std::string(argv[1]));

    polyscope::show();
}