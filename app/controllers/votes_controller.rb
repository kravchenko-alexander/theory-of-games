class VotesController < ApplicationController
  def index
  end

  def absolute_majority
    @first_tour = Alternative.all.map do |alternative|
      [alternative, alternative.expert_alternative_ranks.where(rank: 1).count.to_f / Expert.count]
    end

    @first_tour_winner = @first_tour.find { |res| res.last > 0.5 }&.first

    unless @first_tour_winner.present?
      votes_count = @first_tour.map{ |res| res.last }.uniq.sort.last(2)
      second_tour_alternatives = @first_tour.select { |res| res.last.in?(votes_count) }.map(&:first)

      ea_ranks =
        ExpertAlternativeRank.
          all.
          where(alternative_id: second_tour_alternatives.map(&:id)).
          group_by(&:expert_id).
          map { |expert_id, ranks| ranks.sort_by{|rank| rank.rank}.first }.
          group_by(&:alternative_id).
          map{ |a_id, ranks| [a_id, ranks.count] }

      @second_tour = second_tour_alternatives.map do |alternative|
        [alternative, ea_ranks.find { |res| res.first == alternative.id }.second.to_f / Expert.count]
      end

      @second_tour_winner = @second_tour.find { |res| res.last > 0.5 }&.first


      unless @second_tour_winner.present?
        votes_count = @second_tour.map{ |res| res.last }.uniq.sort.last(2)
        second_tour_alternatives = @second_tour.select { |res| res.last.in?(votes_count) }.map(&:first)

        ea_ranks =
          ExpertAlternativeRank.
            all.
            where(alternative_id: second_tour_alternatives.map(&:id)).
            group_by(&:expert_id).
            map { |expert_id, ranks| ranks.sort_by{|rank| rank.rank}.first }.
            group_by(&:alternative_id).
            map{ |a_id, ranks| [a_id, ranks.count] }

        @third_tour = second_tour_alternatives.map do |alternative|
          [alternative, ea_ranks.find { |res| res.first == alternative.id }.second.to_f / Expert.count]
        end

        @third_tour_winner = @third_tour.find { |res| res.last > 0.5 }&.first
      end
    end
  end

  def simpson
    @relations = []
    Alternative.all.each do |alternative|
      Alternative.where.not(id: alternative.id).each do |other|
        a_res = alternative.expert_alternative_ranks.order(expert_id: :desc).pluck(:rank)
        o_res = other.expert_alternative_ranks.order(expert_id: :desc).pluck(:rank)
        wins = 0
        a_res.each_with_index { |rank, i| wins += 1 if rank < o_res[i] }
        @relations << [alternative, other, wins]
      end
    end

    @minimums = @relations.group_by(&:first).map{ |a, arr| [a, arr.map { |r| r.last }.min] }

    @winner = @minimums.max_by(&:last).first
  end
end
