# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "yaml"

data = YAML.load_file("reporter.yml")

nodes = data["nodes"]

SystemNode.destroy_all
Setting.destroy_all
SystemLink.destroy_all

SystemNode.create!(name: 'Reporter', address: 'reporter address example', description: 'reporter description example')

SystemNode.create!(name: 'Reviewer', address: 'reviewer address example', description: 'reviewer description example')

SystemNode.create!(name: 'Cerner', address: 'cerner address example', description: 'cerner description example')

SystemNode.create!(name: 'The Blade', address: 'The Blade address example', description: 'the blade description example')

SystemNode.create!(name: 'Thing 1', address: 'Thing 1 address example', description: 'Thing 1 description example')

nodes.each do |node|
  SystemNode.where(name: node[0]).first_or_create!
end
