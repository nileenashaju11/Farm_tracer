# frozen_string_literal: true

class HomeController < ApplicationController
  caches_action :show, :animal_diet
  caches_action :index, unless: -> { params[:id].present? }

  def index
    redirect_to home_url(params[:id]) if params[:id].present?
  end

  def show
    @animal = Animal.find_by!(eartag: params[:id])
    report_data = Rails.cache.fetch("animals/#{params[:id]}/diet") do
      bovisync = Bovisync.new
      animal = Animal.find_by!(eartag: params[:id])
      animal_id = animal.bovisync_id
      report = bovisync.report(
        animal: animal_id,
        item: ['AGDAY']
      )

      report_data = report[animal_id.to_sym]
     
      # Clean data if available
      if report_data.present?
        report_data[:id] = animal_id
        # Downcase keys for model
        report_data.transform_keys!(&:downcase)
      end
      report_data
    end
     @animal = BovisyncAnimal.new(report_data)
    
  end

  def animal_diet
    report_data = Rails.cache.fetch("animals/#{params[:id]}/diet") do
      bovisync = Bovisync.new
      animal = Animal.find_by!(eartag: params[:id])
      animal_id = animal.bovisync_id
      report = bovisync.report(
        animal: animal_id,
        item: ['AGDAY']
      )

      report_data = report[animal_id.to_sym]
     
      # Clean data if available
      if report_data.present?
        report_data[:id] = animal_id
        # Downcase keys for model
        report_data.transform_keys!(&:downcase)
      end
      report_data
    end
    # Raise 404 if animal is not found
    raise ActionController::RoutingError, 'Not Found' if report_data.blank?

    @animal = BovisyncAnimal.new(report_data)
    render layout: false
  end

  def animal_life
    report_data = Rails.cache.fetch("animals/#{params[:id]}/life") do
      bovisync = Bovisync.new
      animals = Animal.where(eartag: params[:id])
      animal_ids = animals.pluck(:bovisync_id)

      report = report_data = animal_id = nil
      animal_ids.each do |aid|
        report = bovisync.report(
          animal: aid,
          item: ['BDATE', # Birth date
                 'LOCAT', # Location
                 'Owner', # Farm owner
                 'SireShortNam', # Sire Name
                 'SoldDate', # Date animal was sold or died
                 'AllFarmsLife', # All farms the animal has lived at
                 'Other2ID'] # Beef Grade
        )
        report_data = report[aid.to_sym]

        break if report_data&.dig(:Other2ID).present?
      end

      # Clean data if available
      if report_data.present?
        report_data[:id] = animal_id
        # Downcase keys for model
        report_data.transform_keys!(&:downcase)
      end
      report_data
    end
    # Raise 404 if animal is not found
    raise ActionController::RoutingError, 'Not Found' if report_data.blank?

    @animal = BovisyncAnimal.new(report_data)
    render layout: false
  end
end
