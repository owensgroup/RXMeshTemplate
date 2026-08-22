#include "rxmesh/rxmesh_static.h"

#include <cstdlib>

using namespace rxmesh;

int main(int argc, char** argv)
{
    rx_init(0);

    if (argc != 2) {
        RXMESH_ERROR("Usage: RXMeshTemplate <input-mesh>");
        return EXIT_FAILURE;
    }

    RXMeshStatic rx(argv[1]);

#ifdef USE_POLYSCOPE
    polyscope::show();
#endif

    return EXIT_SUCCESS;
}
