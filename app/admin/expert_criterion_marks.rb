ActiveAdmin.register ExpertCriterionMark do
  permit_params :value, :criterion_id, :expert_id

  form do |f|
    f.inputs 'Expert Criterion Mark Details' do
      f.input :expert_id,
              as: :select,
              collection: Expert.all,
              label_method: :name,
              value_method: :id,
              include_blank: false,
              allow_blank: false
      f.input :criterion_id,
              as: :select,
              collection: Criterion.all,
              label_method: :name,
              value_method: :id,
              include_blank: false,
              allow_blank: false
      f.input :value,
              as: :select,
              collection: [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0],
              include_blank: false,
              allow_blank: false
    end
    f.actions
  end
end
