# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ProductTranslationsExtension < Spree::Extension
  version "1.0"
  description "Makes product details, properties, prototypes and taxonomies translatable using the Globalize 2 plugin"
  
  def activate
    # add content translations using Globalize 2's helpers
    
    Product.class_eval do
      translates :name, :description, :meta_description, :meta_keywords
    end
    
    Property.class_eval do
      translates :presentation
    end

    Prototype.class_eval do
      translates :name
    end
    
    Taxonomy.class_eval do
      translates :name
    end
    
    Taxon.class_eval do
      translates :name, :permalink
    end

    Admin::BaseController.class_eval do 

      ## 
      # {fields: 
      #  {
      #   description: {
      #     "fr-FR": "daslkjsdklajlkdjljkasd",
      #     "en-US": "dlasjldfjsfjdklfjsd"      
      #     ...
      #   },
      #   productName: {
      #     "fr-FR": "dfslfsdjfklsjfjdklh",
      #   } 
      #  }
      # }
      def get_translatable_info
        klass = params[:model_type].constantize
        instance = klass.find_by_id(params[:model_id])
        
        if instance.respond_to?(:create_translation_table!, true)
           @translated_attr = []
         else
           @translated_attr = instance.globalize_options[:translated_attributes]
         end
      end
      
    end

  end

end
