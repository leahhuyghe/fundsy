class CreateRewardLevels < ActiveRecord::Migration
  def change
    create_table :reward_levels do |t|

      t.timestamps null: false
    end
  end
end
