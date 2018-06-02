class DecisionsController < ApplicationController
  def pareto_method
    alternatives = Alternative.all
    ids = alternatives.ids
    alternatives.each do |alternative|
      Alternative.all.where.not(id: alternative.id).each do |another_alternative|
        ids.delete(alternative.id) if alternative < another_alternative
      end
    end

    @alternatives = Alternative.where(id: ids)
  end

  def normalized
    alternatives = Alternative.all
    ids = alternatives.ids
    alternatives.each do |alternative|
      Alternative.all.where.not(id: alternative.id).each do |another_alternative|
        ids.delete(alternative.id) if alternative < another_alternative
      end
    end

    @alternatives = Alternative.where(id: ids)
  end

  def electre
    @results = []
    Alternative.all.each do |alternative|
      result = [alternative, []]
      Alternative.all.each do |another_alternative|
        result[1] << alternative.compare_by_electre(another_alternative)
      end
      @results << result
    end

    @alternative = @results.max_by do |result|
      result[1].sum
    end[0]
  end

  def initial_data
    @alternatives = Alternative.all
  end
end
