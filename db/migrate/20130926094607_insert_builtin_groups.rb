# -*- encoding : utf-8 -*-
class InsertBuiltinGroups < ActiveRecord::Migration
  def self.up
    Group.reset_column_information

    bux = Group.new(:name => 'Бухгалтерия')
    bux.builtin = 1
    bux.save

    dit = Group.new(:name => 'ДИТ')
    dit.builtin = 2
    dit.save
  end

  def self.down
    Group.destroy_all 'builtin <> 0'
  end
end
