#
# Author: Joshua Timberman <joshua@getchef.com>
# Copyright (c) 2014, Chef Software, Inc. <legal@getchef.com>
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

class Chef
  class Knife
    class ReportResource < Chef::Knife
      banner 'knife report resource QUERY TYPE NAME'

      deps do
        require 'chef/search/query'
      end

      PROTOCOL_VERSION = '0.1.0'
      HEADERS = {'X-Ops-Reporting-Protocol-Version' => PROTOCOL_VERSION}

      option :start_time,
        :long => '--starttime YYYY-MM-DDTHH:MM:SS',
        :short => '-s YYYY-MM-DDTHH:MM:SS',
        :required => false,
        :description => 'Check for runs starting at the specified time (ISO8601)'

      option :reporting_rows,
        :long => '--rows NUM',
        :short => '-r NUM',
        :default => 500,
        :description => 'Number of rows to retrieve from the reporting API (pagination)'

      # valid timestamps:
      # 2014-08-19 13:33:36 (will be split and joined w/ 'T' to remove the space)
      # 2014-08-19T13:33:36
      def start_time(timestamp = nil)
        timestamp.nil? ? (end_time - 3600).to_i : Time.at(DateTime.iso8601(timestamp.split.join("T")).to_time).to_i
      end

      # Now is the end!
      def end_time
        Time.now.to_i
      end

      def rest
        @rest ||= Chef::REST.new(Chef::Config[:chef_server_url])
      end

      def rest_get(query)
        rest.get(query, false, HEADERS)
      end

      def run
        rows = config[:reporting_rows]
        search_query = name_args[0]
        resource_type = name_args[1]
        resource_name = name_args[2]
        resource_updates = []
        node_list = []

        q = Chef::Search::Query.new
        q.search('node', search_query) do |nod|
          node_list << nod
        end

        runs = rest_get("reports/org/runs?from=#{start_time(config[:start_time]).to_i}&until=#{end_time}&rows=#{rows}")
        node_list.each do |n|
          nodes_run_data = runs['run_history'].map do |r|
            [r['run_id'], r['updated_res_count']] if r['node_name'] == n.name
          end.compact

          nodes_run_data.each do |nrd|
            query_string = "reports/org/runs/#{nrd.first}?start=0&rows=#{nrd.last}"

            run_data = rest_get(query_string)
            run_data['run_resources'].each do |rr|
              if rr['type'] == resource_type && rr['name'] == resource_name
                data =  {
                  'host' => n['fqdn'],
                  'run_id' => nrd.first,
                  'end_time' => run_data['run_detail']['end_time']
                }
                resource_updates << data
              end
            end
          end
        end

        if resource_updates.length > 0
          ui.output("#{resource_type}[#{resource_name}] changed in the following runs:")
          resource_updates.each do |ru|
            ui.output "#{ru['host']} #{ru['run_id']} @ #{ru['end_time']}"
          end
          ui.output('Use `knife runs show` with the run UUID to get more info')
        end
      end
    end
  end
end
