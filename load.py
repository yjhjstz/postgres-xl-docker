# -*- coding: utf-8 -*-
import random
import sys
import snap
import time
import postgresql
import json
from string import Template


def loadCollabNet(path):
    """
    :param - path: path to edge list file
    return type: snap.PUNGraph
    return: Graph loaded from edge list at `path and self edges removed
    Do not forget to remove the self edges!
    """
    ############################################################################
    # TODO: Your code here!
    Graph = snap.LoadEdgeList(snap.PNGraph, path, 0, 1)
    snap.DelSelfEdges(Graph)
    ############################################################################
    return Graph

G1 = loadCollabNet("CA-GrQc.txt")
#snap.DrawGViz(G1, snap.gvlDot, "CA-GrQc.png", "ca-GrQc")
# traverse the nodes
# for NI in G1.Nodes():
#     print("node id %d with out-degree %d and in-degree %d" % (
#         NI.GetId(), NI.GetOutDeg(), NI.GetInDeg()))
# traverse the edges
# for EI in G1.Edges():
#     print("edge (%d, %d)" % (EI.GetSrcNId(), EI.GetDstNId()))

# traverse the edges by nodes
# for NI in G1.Nodes():
#     for Id in NI.GetOutEdges():
#         print("edge (%d %d)" % (NI.GetId(), Id))

# Network = snap.GenRndGnm(snap.TNEANet, 100, 1000)
# NodeNum, NodeVec = Network.GetNodesAtHop(1, 2, True)
# for item in NodeVec:
#     print(item)
tv = Template('{"name": "p${id}"}')
tk = Template('{"name": "k${id}"}')

def insert_vertices(G1):
    db = postgresql.open('pq://localhost:5432/postgres')
    
    db.execute("select set_graph_path('g')")
    rows = db.execute("SELECT * FROM g.person limit 1")

    make_emp = db.prepare("INSERT INTO person (id, properties) VALUES ($1, $2)")
    with db.xact():
        # Execute a command: this creates a new table
        for NI in G1.Nodes():
            # print("node id %d with out-degree %d and in-degree %d" % (
            # NI.GetId(), NI.GetOutDeg(), NI.GetInDeg()))
            make_emp(NI.GetId(), tv.substitute(id=NI.GetId()))


    # Query the database and obtain data as Python objects.
    #db.execute("SELECT * FROM g.person limit 1")
   

def insert_edges(G1):
    db = postgresql.open('pq://localhost:5432/postgres')
    i = 1
    make_emp = db.prepare("INSERT INTO g.knows (id, start, stop ,properties) VALUES ($1, $2, $3, $4)")    

    # Execute a command: this creates a new table
    db.execute("select set_graph_path('g')")
    with db.xact():
        for EI in G1.Edges():
            i = i+1
            # print("node id %d with out-degree %d and in-degree %d" % (
            # NI.GetId(), NI.GetOutDeg(), NI.GetInDeg()))
            make_emp(i, EI.GetSrcNId(), EI.GetDstNId(), tk.substitute(id=i))

    # Query the database and obtain data as Python objects.
    db.execute("SELECT * FROM g.knows limit 1")

print("insert vertices")
insert_vertices(G1)
print("insert edges")
insert_edges(G1)
