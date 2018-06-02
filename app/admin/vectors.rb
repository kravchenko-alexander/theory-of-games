ActiveAdmin.register Vector do
  permit_params :alternative_id, :mark_id

  index do
    selectable_column
    id_column
    column :alternative do |vector|
      vector.alternative.name
    end
    column :mark do |vector|
      "#{vector.mark.criterion.name} - #{vector.mark.name}"
    end
    actions
  end

  form do |f|
    f.inputs 'Vector Details' do
      f.input :alternative_id,
              as: :select,
              collection: Alternative.all,
              label_method: :name,
              value_method: :id,
              include_blank: false,
              allow_blank: false
      f.input :mark_id,
              as: :select,
              collection: Mark.all.map { |mark| ["#{mark.criterion.name} - #{mark.name}", mark.id] },
              include_blank: false,
              allow_blank: false
    end
    f.actions
  end
end
