# knife report resource plugin

This [knife plugin](http://docs.getchef.com/chef/knife.html) will query a Chef Server running Chef Reporting for a specific SOLR query, and a specific resource type and resource name. It will return a list of run IDs for all the nodes that had that resource update from the specified time (ISO8601).

# Installation

Install it using [ChefDK](https://downloads.getchef.com/chef-dk):

```sh
% chef gem install knife-report-resource
```

Or, nstall this as a RubyGem in a ruby environment (system, rvm, rbenv, chruby, etc):

```sh
% gem install knife-report-resource
```

Or, put it in your project's Gemfile:

```ruby
gem 'knife-report-resource'
```

I recommend using ChefDK.

# Usage

Use is pretty straightforward:

```text
% knife report resource 'QUERY' RESOURCE_TYPE RESOURCE_NAME (options)
```

As an example:

```text
% knife report resource 'os:linux' runit_service minecraft -s 2014-10-05T13:33:36
runit_service[minecraft] changed in the following runs:
cask.int.housepub.org e2b850b2-2462-4f49-ae63-96f3a6157ba0 @ 2014-10-05T20:48:16Z
cask.int.housepub.org 5fc37d57-5369-4a86-9c32-feabd9170102 @ 2014-10-05T20:13:42Z
cask.int.housepub.org fb7029d5-333b-416b-909c-838bd163851c @ 2014-10-05T19:39:43Z
cask.int.housepub.org 13aa96fe-f2d5-4b1c-a89a-21f7e88d5a15 @ 2014-10-05T19:05:21Z
cask.int.housepub.org 81a6bee5-e03f-48d1-886a-5222a8fc2c62 @ 2014-10-05T18:33:00Z
cask.int.housepub.org da81b66d-69ad-4cf9-a317-0a1c74a7f0ff @ 2014-10-05T17:57:57Z
cask.int.housepub.org a2927b74-d7c3-47e3-882d-44692c3353a8 @ 2014-10-05T17:24:23Z
cask.int.housepub.org e85c4188-e447-4a5b-bdb3-ea6414df63c4 @ 2014-10-05T16:53:27Z
cask.int.housepub.org 29e5b9d9-cb73-474d-bb68-aed1299aa6f1 @ 2014-10-05T16:22:01Z
cask.int.housepub.org ed429bac-bdb2-47bf-96d9-9399f5a3b673 @ 2014-10-05T15:47:58Z
cask.int.housepub.org 6e4ce2c3-232b-4312-8b31-1dcb2236bf2a @ 2014-10-05T15:14:01Z
cask.int.housepub.org 38fd078a-57a8-4598-8c25-2a8aff78325d @ 2014-10-05T14:41:04Z
cask.int.housepub.org f382d5fe-9e2c-43f5-b2b3-a5bd2f8c4603 @ 2014-10-05T14:06:59Z
Use `knife runs show` with the run UUID to get more info
```

# Contributing

1. Fork the project
2. Make your changes in a branch
3. Submit a pull request

I maintain this project in my free time, but I try to follow up with issues in a timely manner.

# License and Author

- Author: Joshua Timberman <joshua@getchef.com>
- Copyright: 2014, Chef Software, Inc. <legal@getchef.com>

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
