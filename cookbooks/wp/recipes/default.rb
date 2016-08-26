#
# Cookbook Name:: wp
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


include_recipe 'selinux::permissive'
#include_recipe 'wp::mysql'
include_recipe 'wp::php7'
#include_recipe 'wp::wordpress'
include_recipe 'wp::apache'
