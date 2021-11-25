class CreateCarbonfootprints < ActiveRecord::Migration[6.0]
  def change
    create_table :carbonfootprints do |t|
      t.integer :co2_emitted
      t.integer :co2sequestered
      t.string :co2total

      t.timestamps
    end
  end
end
