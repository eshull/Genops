require "yaml"

data = YAML.load_file("reporter.yml")

nodes = data["nodes"]

puts "File has #{nodes.count} nodes"

nodes.each { |k, v| puts "Node name: ${k}\n\t properties: #{v}" }
