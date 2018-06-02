ActiveAdmin.register Criterion do
  permit_params :name, :c_type, :optim_type, :measure, :scale_type

  form do |f|
    f.inputs 'Criterions Details' do
      f.input :name
      f.input :c_type,
              as: :select,
              collection: Criterion::C_TYPES,
              include_blank: false,
              allow_blank: false
      f.input :optim_type,
              as: :select,
              collection: Criterion::OPTIM_TYPES,
              include_blank: false,
              allow_blank: false
      f.input :measure
      f.input :scale_type,
              as: :select,
              collection: Criterion::SCALE_TYPES,
              include_blank: false,
              allow_blank: false
    end
    f.actions
  end
end
