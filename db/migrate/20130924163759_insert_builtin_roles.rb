class InsertBuiltinRoles < ActiveRecord::Migration
  def self.up
    Role.reset_column_information
    admin = Role.new(:name => 'Администратор')
    admin.builtin = 1
    admin.save

    bux = Role.new(:name => 'Бухгалтер')
    bux.builtin = 2
    bux.save

    manag = Role.new(:name => 'Менеджер')
    manag.builtin = 3
    manag.save

    worker = Role.new(:name => 'Работник')
    worker.builtin = 4
    worker.save

    kandidat = Role.new(:name => 'Кандидат в ДИТ')
    kandidat.builtin = 5
    kandidat.save
  end

  def self.down
    Role.destroy_all 'builtin <> 0'
  end
end
