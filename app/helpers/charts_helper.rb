module ChartsHelper

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
      sum = 0
      superior_organs_total = Array.new

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

        superior_organs_total.each do |sup_organ|
          f.series(sup_organ)
        end

        f.legend(reversed: true, verticalAlign: 'bottom', horizontalAlign: 'center', layout: 'horizontal')
        f.chart({type: "bar"})
        f.yAxis(title: {text: "Gasto Total"})
      end
    end
end
