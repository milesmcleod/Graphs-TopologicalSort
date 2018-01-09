require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted_list = []
  queue = []
  vertices.each { |vtx| queue.push(vtx) if vtx.in_edges.empty? }
  until queue.empty?
    current = queue.shift
    sorted_list.push(current)
    current.out_edges.each do |edge|
      if edge.to_vertex.in_edges.length == 1
        queue.push(edge.to_vertex)
      end
    end
    current.out_edges.each { |edge| edge.destroy! }
  end
  return [] if sorted_list.length < vertices.length
  sorted_list
end
