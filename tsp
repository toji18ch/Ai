def tsp(graph):
    n = len(graph)

    dp = [[-1] * (1 << n) for _ in range(n)]
    parent = [[-1] * (1 << n) for _ in range(n)]

    def solve(pos, visited):
        if visited == (1 << n) - 1:
            return graph[pos][0]

        if dp[pos][visited] != -1:
            return dp[pos][visited]

        min_cost = float('inf')

        for city in range(n):
            if (visited & (1 << city)) == 0:
                cost = graph[pos][city] + solve(city, visited | (1 << city))
                if cost < min_cost:
                    min_cost = cost
                    parent[pos][visited] = city

        dp[pos][visited] = min_cost
        return min_cost

    min_cost = solve(0, 1)

    # Path reconstruction
    path = [0]
    visited = 1
    pos = 0

    while True:
        nxt = parent[pos][visited]
        if nxt == -1:
            break
        path.append(nxt)
        visited |= (1 << nxt)
        pos = nxt

    path.append(0)
    return min_cost, path


# -------- Dynamic Input --------
n = int(input("Enter number of cities: "))

print("Enter adjacency matrix:")
graph = []
for i in range(n):
    row = list(map(int, input().split()))
    graph.append(row)

cost, path = tsp(graph)

print("\nMinimum Cost:", cost)
print("Optimal Path:", path)
