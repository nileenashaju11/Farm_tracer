class AddCarbonFootAcceptAllNumbers < ActiveRecord::Migration[6.0]
  def change
    change_column :carbonfootprints, :co2_emitted, :float
    change_column :carbonfootprints, :co2sequestered, :float
    change_column :carbonfootprints, :co2total, :float
  end
end
