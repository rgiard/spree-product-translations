class Admin::TranslationsController < ApplicationController
 
  before_filter :set_translatable_info

  # Retrieves the translatable fields available for the specified model.
  def index
    render :json => {:fields => @fields}
  end

  # Get the field value for the specified locale
  def edit
    #TODO validate the field is translatable

    value = @instance.send params[:field].to_sym
    value = "" unless value.locale == value.requested_locale

    render :json => {:value => value}
  end

  # Save the specified field value
  def update
    @instance.send "#{params[:field]}=".to_sym, params[:field_value]
  end

  private

  def set_translatable_info
    #TODO validate the locale is in the available locales
    I18n.locale = params[:locale].to_sym unless params[:locale].nil?

    @instance = find_instance(params[:model_type], params[:model_id])

    @fields = nil if @instance.nil?
    @fields = @instance.globalize_options[:translated_attributes] unless @instance.nil?
  end

  def find_instance(model_type, model_id)
    klass = model_type.constantize
    klass.find_by_id(model_id)
  end

end
