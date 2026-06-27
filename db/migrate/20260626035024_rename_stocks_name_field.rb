class RenameStocksNameField < ActiveRecord::Migration[8.1]
  def change
    rename_column :stocks, :name, :company_name
  end
end
