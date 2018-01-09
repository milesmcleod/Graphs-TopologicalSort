# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require 'topological_sort'
require 'byebug'

def install_order(arr)
  vertices = []
  max_id = 0
  arr.each do |t|
    if t[0] > max_id
      max_id = t[0]
    end
    if t[1] > max_id
      max_id = t[1]
    end
  end
  max_id.times do |i|
    vertices.push(Vertex.new(i + 1))
  end
  arr.each do |t|
    dependency = vertices.select { |vtx| vtx.value == t[1] }
    dependency = dependency[0]
    package = vertices.select { |vtx| vtx.value == t[0] }
    package = package[0]
    Edge.new(dependency, package)
  end
  # debugger
  topological_sort(vertices).map { |v| v.value }
end
