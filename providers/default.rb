#
# Cookbook Name:: sudo
# Provider:: default
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "chef/dsl/include_recipe"
include Chef::DSL::IncludeRecipe

action :create do
  template "/etc/sudoers.d/#{new_resource.name}" do
    owner "root"
    group "root"
    mode 0440

    cookbook "sudo"
    source "user.conf.erb"


    variables(
      "name" => new_resource.name,
      "passwordless" => new_resource.passwordless
    )
  end

  new_resource.updated_by_last_action(true)
end

action :delete do
  file "/etc/sudoers.d/#{new_resource.name}" do
    action :delete
  end

  new_resource.updated_by_last_action(true)
end
