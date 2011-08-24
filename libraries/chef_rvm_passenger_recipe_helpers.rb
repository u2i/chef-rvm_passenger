#
# Cookbook Name:: rvm_passenger
# Library:: Chef::RVMPassenger::RecipeHelpers
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright 2011, Fletcher Nichol
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

class Chef
  module RVMPassenger
    module RecipeHelpers
      def determine_gem_version_if_not_given
        if node[:rvm_passenger][:version].nil?
          require 'rubygems'
          require 'rubygems/dependency_installer'

          spec = Gem::DependencyInstaller.new.find_gems_with_sources(
            Gem::Dependency.new("passenger")).last[0]

          node.set[:rvm_passenger][:version] = spec.version.to_s
          Chef::Log.debug(%{Setting node['rvm_passenger']['version'] = } +
            %{"#{node['rvm_passenger']['version']}"})
        end
      end
    end
  end
end
