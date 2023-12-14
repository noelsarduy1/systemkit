from __future__  import print_function

from gremlin_python import statics
from gremlin_python.structure.graph import Graph
from gremlin_python.process.graph_traversal import __
from gremlin_python.process.strategies import *
from gremlin_python.driver.driver_remote_connection import DriverRemoteConnection

#initializing the graph object
graph = Graph()

#creating connection with the remote

try:
  remoteConn = DriverRemoteConnection('wss://tf-20210825120309398200000003.cxe5irpimtve.us-east-1.neptune.amazonaws.com:8182/gremlin','g')
  g = graph.traversal().withRemote(remoteConn)
except Exception as e:
  print(e)

#print(g.V().limit(2).toList())


#clearing out all the vertices to start fresh
g.V().drop().iterate()
g.E().drop().iterate()



#Adding some vertices (nodes)
user_1 = g.addV('people').property('name','person1').next()
user_2 = g.addV('people').property('name','person2').next()
user_3 = g.addV('people').property('name','person3').next()
user_4 = g.addV('people').property('name','person4').next()
user_5 = g.addV('people').property('name','person5').next()


#Adding relationships (edges)
g.V(user_1).addE('knows').property('since','1997').to(user_2).next()
g.V(user_1).addE('knows').property('since','2016').to(user_3).next()
g.V(user_2).addE('knows').property('since','2018').to(user_4).next()
g.V(user_2).addE('knows').property('since','2017').to(user_5).next()
g.V(user_3).addE('knows').property('since','2015').to(user_5).next()


#Print out all the nodes
people = g.V().valueMap().toList()
print(people)


#Print out all the connections (edges)
connections = g.E().valueMap().toList()
print(connections)


#update property
g.V(user_1).property(single,'name','marcus')


#delete a vertex (node)
g.V().has('name', 'marcus').drop()
#g.V(user_1).drop().iterate()


#delete properties
g.V().hasLabel('people').properties('name').drop().iterate()


#delete edges
g.V().outE().hasLabel('knows').drop()


#delete neptune graph
g.V().drop().iterate()


#Closing the connection
remoteConn.close()

print('done')



