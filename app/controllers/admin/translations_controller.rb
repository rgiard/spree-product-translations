class Admin::TranslationsController < ApplicationController
  
  def get_fields
    klass = params[:model_type].constantize
    instance = klass.find_by_id(params[:id])
    fields = instance.globalize_options[:translated_attributes]

    respond_to do |wants| 
      wants.js {     
        render :json => {:fields => fields}
      }
    end

  end

end
