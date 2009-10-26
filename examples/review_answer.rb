$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require '../lib/rturk'

aws = YAML.load(File.open(File.join(File.dirname(__FILE__), 'mturk.yml')))
RTurk::setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)

hits = RTurk::Hit.all_reviewable

puts "#{hits.size} reviewable hits. \n"

unless hits.empty?
  puts "Reviewing all assignments"
  
  hits.each do |hit|
    hit.assignments.each do |assignment|
      puts assignment.answers['tweet']
      assignment.approve! if assignment.status == 'Submitted'
    end
  end
end