namespace :create_carborn_footprint do
  desc "create carborn foot print values"
  
  task :create_emitted_co2 => :environment do
    @emitted_co2=[89.43,35.98,2.713,2.687,2.479,2.457,2.438,2.39,2.509,2.501,2.112,2.168,2.316,2.301,2.261,
    2.231,2.061,53.85,2.487,2.427,2.416,2.412,2.405,2.383,2.349,2.587,2.668,2.09,2.16,2.157,2.149,2.142]
    @emitted_co2.each do |value|
      Carbonfootprint.create(:co2_emitted => value)
     end    
  end
  
  task :create_sequested_co2 => :environment do
    @sequested_co2=[96.77,38.50,2.935,2.907,2.683,2.659,2.639,2.587,2.715,2.707,2.286,2.346,2.506,2.49,2.446,2.414,
    2.182,58.27,2.691,2.627,2.615,2.611,2.603,2.579,2.542,2.799,2.887,2.262,2.338,2.334,2.326,2.318]
    @sequested_co2.each do |value|
      Carbonfootprint.update(:co2sequestered => value)
     end
  end
  
  task :total_co2 => :environment do
    @total_co2=[-7.345,-2.923,-0.223,-0.221,-0.204,-0.202,-0.2,-0.196,-0.206,-0.205,-0.174,-0.178,-0.19,-0.189,
      -0.186,-0.183,-0.166,-4.422,-0.204,-0.199,-0.198,-0.198,-0.198,-0.196,-0.193,-0.212,-0.219,-0.172,-0.177,-0.177,-0.177]
    @total_co2.each do |value|
      Carbonfootprint.update(:co2total => value)
    end   
  end
  
  task :additional_co2_values => :environment do
     @sequested_co2=[96.77,38.50,2.935,2.907,2.683,2.659,2.639,2.587,2.715,2.707,2.286,2.346,2.506,2.49,2.446,2.414,
    2.182,58.27,2.691,2.627,2.615,2.611,2.603,2.579,2.542,2.799,2.887,2.262,2.338,2.334,2.326,2.318]
    @total_co2=[-7.345,-2.923,-0.223,-0.221,-0.204,-0.202,-0.2,-0.196,-0.206,-0.205,-0.174,-0.178,-0.19,-0.189,
      -0.186,-0.183,-0.166,-4.422,-0.204,-0.199,-0.198,-0.198,-0.198,-0.196,-0.193,-0.212,-0.219,-0.172,-0.177,-0.177,-0.177]
    i = 0
      Carbonfootprint.all.each do |value|
        value.update_attributes(:co2sequestered => @sequested_co2[i],:co2total => @total_co2[i])
       i = i + 1
      end  
  end
  
end