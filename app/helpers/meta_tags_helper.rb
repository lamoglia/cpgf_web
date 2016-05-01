module MetaTagsHelper
    def prepare_meta_tags(options={})
    site_name   = "CPGF"
    title       = "CPGF"
    description = "CPGF apresenta os dados fornecidos pelo governo sobre o Cartão de pagamento do governo federal (CPGF) em um formato legível que facilita consultas e análises dos gastos declarados."
    image       = options[:image] || "your-default-image-url"
    current_url = request.url
    
    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[CPGF 'Cartão de pagamento do governo federal', 'Cartão corporativo', 'dados abertos'],
      twitter: {
        site_name: site_name,
        site: '@aaaaaa',
        card: 'summary',
        description: description,
        image: image
      },
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website',
        locale: 'pt_BR'
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end
end