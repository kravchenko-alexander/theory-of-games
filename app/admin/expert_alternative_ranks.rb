ActiveAdmin.register ExpertAlternativeRank do
  permit_params :rank, :alternative_id, :expert_id

  form do |f|
    f.inputs 'Expert Criterion Mark Details' do
      f.input :expert_id,
              as: :select,
              collection: Expert.all,
              label_method: :name,
              value_method: :id,
              include_blank: false,
              allow_blank: false
      f.input :alternative_id,
              as: :select,
              collection: Alternative.all,
              label_method: :name,
              value_method: :id,
              include_blank: false,
              allow_blank: false
      f.input :rank,
              as: :select,
              collection: (1..(Alternative.all.count)).to_a,
              include_blank: false,
              allow_blank: false
    end
    f.actions
  end
end
