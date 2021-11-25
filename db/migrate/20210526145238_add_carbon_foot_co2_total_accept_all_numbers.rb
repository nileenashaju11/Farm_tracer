class AddCarbonFootCo2TotalAcceptAllNumbers < ActiveRecord::Migration[6.0]
  def change
    change_column :carbonfootprints, :co2total, :float
  end
end
