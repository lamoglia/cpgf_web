base_url = "http://#{request.host_with_port}/"

xml.instruct! :xml, :version=>"1.0"
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9', 'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance" do
  xml.url do
    xml.loc base_url
    xml.changefreq 'weekly'
    xml.priority 0.8
  end
  xml.url do
    xml.loc base_url+'cpgf/portadores'
    xml.changefreq 'weekly'
    xml.priority 0.5
  end
  xml.url do
    xml.loc base_url+'cpgf/transacoes'
    xml.changefreq 'weekly'
    xml.priority 0.5
  end
  xml.url do
    xml.loc base_url+'cpgf/favorecidos'
    xml.changefreq 'weekly'
    xml.priority 0.5
  end
  xml.url do
    xml.loc base_url+'cpgf/unidades_gestoras'
    xml.changefreq 'weekly'
    xml.priority 0.5
  end
  xml.url do
    xml.loc base_url+'sobre'
    xml.changefreq 'monthly'
    xml.priority 0.3
  end
end