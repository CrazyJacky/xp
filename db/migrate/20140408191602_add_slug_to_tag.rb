class AddSlugToTag < ActiveRecord::Migration
  def change
    add_column :tags, :slug, :string
  end
end
