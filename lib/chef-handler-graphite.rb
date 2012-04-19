#
# Author:: Ian Meyer <ianmmeyer@gmail.com>
# Copyright:: Copyright (c) 2012, Ian Meyer
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "rubygems"
Gem.clear_paths
require "simple-graphite"
require "chef"
require "chef/handler"

class GraphiteReporting < Chef::Handler
  attr_writer :metric_key, :graphite_host, :graphite_port

  def initialize(options = {})
    @metric_key = options[:metric_key]
    @graphite_host = options[:graphite_host]
    @graphite_port = options[:graphite_port]
  end

  def report
    gemspec = if Gem::Specification.respond_to? :find_by_name
      Gem::Specification.find_by_name('chef-handler-graphite')
    else
      Gem.source_index.find_name('chef-handler-graphite').last
    end

    Chef::Log.debug("#{gemspec.full_name} loaded as a handler.")

    g = Graphite.new
    g.host = @graphite_host
    g.port = @graphite_port

    metrics = Hash.new
    metrics[:updated_resources] = run_status.updated_resources.length
    metrics[:all_resources] = run_status.all_resources.length
    metrics[:elapsed_time] = run_status.elapsed_time

    if run_status.success?
      metrics[:success] = 1
      metrics[:fail] = 0
    else
      metrics[:success] = 0
      metrics[:fail] = 1
    end

    g.push_to_graphite do |graphite|
      metrics.each do |metric, value|
        Chef::Log.debug("#{@metric_key}.#{metric} #{value} #{g.time_now}")
        graphite.puts "#{@metric_key}.#{metric} #{value} #{g.time_now}"
      end
    end
  end
end
