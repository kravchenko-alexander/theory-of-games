ActiveAdmin.register Mark do
  permit_params :name, :criterion_id

  form do |f|
    f.inputs 'Mark Details' do
      f.input :name
      f.input :criterion_id,
              as: :select,
              collection: Criterion.all,
              label_method: :name,
              value_method: :id,
              include_blank: false,
              allow_blank: false
    end
    f.actions
  end
end
