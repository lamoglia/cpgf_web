class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})
    site_name   = "CPGF"
    title       = "CPGF"
    description = "CPGF apresenta os dados fornecidos pelo governo sobre o Cartão de pagamento do governo federal (CPGF) em um formato amigável que facilita consultas e análises dos gastos declarados."
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

  def index
    @yearly_total_chart = build_yearly_total_chart();

    @summary_by_favored = Favored.order(total_transactions: :desc).limit(10)
    @summary_by_person = Person.order(total_transactions: :desc).limit(10)
    @total_by_superior_organ_chart = build_total_by_superior_organ_chart();
  end

  def about
  end

  private

    def build_yearly_total_chart()
      yearly_total = Transaction.group_by_year(:date, dates: true, format:"%Y").sum(:value)
      yearly_total.delete_if { |key, value| key.to_i < 2009 }

      LazyHighCharts::HighChart.new('graph') do |f|
        f.xAxis(categories: yearly_total.keys)
        f.yAxis(min: 0, title: nil)
        f.series(name: "Gasto total", data: yearly_total.values.collect{ |a| a.to_f})

        f.legend(verticalAlign: 'bottom', horizontalAlign: 'right', layout: 'horizontal')
        f.chart({type: "column", height: 300})
      end
    end

    def build_total_by_superior_organ_chart()
      superior_organs_total = Array.new
      sum = 0

      total = Transaction.sum('value');
      Transaction.select("superior_organ_id, sum(value) as total").group("superior_organ_id").order("total DESC").limit(10).each do | rec |
        superior_organ = SuperiorOrgan.find(rec.superior_organ_id)
        superior_organs_total << {name: superior_organ.name,data: [rec.total.to_f]}
        sum += rec.total.to_f

        if (sum > total/1.1) then
          superior_organs_total << {name: 'OUTROS',data: [(total - sum).to_f ]}
          break
        end
      end

      LazyHighCharts::HighChart.new('bar') do |f|
        f.title(text: "Gasto por Órgão Superior")
        f.options[:plotOptions][:series] = { :stacking => 'normal' }
        f.xAxis(categories: ["Gasto"])

        superior_organs_total.each do |so|
          f.series(so)
        end

        f.legend(reversed: true, verticalAlign: 'bottom', horizontalAlign: 'center', layout: 'horizontal')
        f.chart({type: "bar"})
        f.yAxis(title: {text: "Gasto Total"})
      end
    end
end