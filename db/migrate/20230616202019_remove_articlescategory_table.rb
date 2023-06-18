class RemoveArticlescategoryTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :article_categories
  end
end
