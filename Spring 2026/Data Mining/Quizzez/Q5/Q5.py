import networkx as nx

G = nx.read_edgelist("aves-thornbill-farine.edges", create_using=nx.Graph(), data=False)

largest_cc = max(nx.connected_components(G), key=len)
LCC = G.subgraph(largest_cc).copy()

print(nx.average_shortest_path_length(LCC))