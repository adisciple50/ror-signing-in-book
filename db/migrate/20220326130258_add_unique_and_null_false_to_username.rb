class AddUniqueAndNullFalseToUsername < ActiveRecord::Migration[7.0]
  def change
    change_column :entries,:username,:text,null: false
    change_column :entries,:username,:text,uniq:true
  end
end
