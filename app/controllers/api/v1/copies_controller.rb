module Api
  module V1
    class CopiesController < ApplicationController

      def index
        if params["key"] == "refresh"
          @client = Airtable::Client.new("keyhXrpBAbFcsnvCg")
          @table = @client.table("appLcC0RMOQHOHeMA", "t1")
          @records = @table.records
          array = []
          @table.records.each do |item|
            array << item.fields.except(:id)
          end
          file = File.open("public/temp.json","w")
          file.write(JSON.pretty_generate(array))
          file.close
          render json: {value: "Suceess"}
        else
          file = File.read('public/temp.json')
          data_hash = JSON.parse(file)
          data_hash.each do |item|
            if item["key"].include?(params["key"])
              if item["key"] == "greeting"
                render json: {value: item["copy"].gsub('name', params["name"]).gsub('app', params["app"])}
              end
              if item["key"] == "intro_created_at"
                render json: {value: item["copy"].gsub('created_at', "#{Time.at(params["created_at"].to_i).strftime("%a %b %d %r")}")}
              end
              if item["key"] == "intro_updated_at"
                render json: {value: item["copy"].gsub('updated_at', "#{Time.at(params["updated_at"].to_i).strftime("%a %b %d %r")}")}
              end
              if item["key"] == "time"
                render json: {value: item["copy"].gsub('time', "#{Time.at(params["time"].to_i).strftime("%a %b %d %r")}")}
              end
              if item["key"] == "bye"
                render json: {value: item["copy"]}
              end
            end
          end
        end
      end

      def show
        if params["since"].present?
          @client = Airtable::Client.new("keyhXrpBAbFcsnvCg")
          @table = @client.table("appLcC0RMOQHOHeMA", "t1")
          @records = @table.records
          records = []
          @table.records.each do |item|
            if item.fields['last_modified_time'].to_datetime.strftime("%s").to_i > params["since"].to_i
              records << item.fields["key"]
            end
          end
          render json: {value: records}
        end
      end
    end
  end
end