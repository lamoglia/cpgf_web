module MetaTagsHelper
    def prepare_meta_tags(options={})
    site_name   = "Cartão de Pagamento do Governo Federal"
    title       = "Cartão de Pagamento do Governo Federal"
    description = "Contribua com a auditoria dos gastos feitos com o cartão corporativo, o cartão de pagamento do governo federal (CPGF)."
    image       = options[:image] || "http://#{request.host}#{ActionController::Base.helpers.image_path('og_image.jpg')}"
    current_url = request.url
    
    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[CPGF 'Cartão de pagamento do governo federal', 'Cartão corporativo', 'dados abertos', 'auditoria governo'],
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website',
        locale: 'pt_BR'
      },
      fb: {
        app_id: '245020032526716',
        admins: '646338843'
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end
end
