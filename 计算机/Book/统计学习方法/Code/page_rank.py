"""
PageRank algorithm with explicit number of iterations.

Returns ranking of nodes (pages) in the adjacency matrix.
"""

import numpy as np

def pageRank(adjacencyMatrix, numberOfIterations=100, dampingFactor=0.85):
    N = adjacencyMatrix.shape[1]
    R = np.random.rand(N, 1)
    R = R / np.linalg.norm(R, 1)
    for _ in range(numberOfIterations):
        R = dampingFactor * (adjacencyMatrix @ R) + (1 - dampingFactor) / N
    return R 



if __name__ == "__main__":
    adjacencyMatrix = np.array([[0, 0, 0, 0, 1],
                                [0.5, 0, 0, 0, 0],
                                [0.5, 0, 0, 0, 0],
                                [0, 1, 0.5, 0, 0],
                                [0, 0, 0.5, 1, 0]])
    v = pageRank(adjacencyMatrix, 100, 0.85)
    print(v)
