ActiveAdmin.register User do

  permit_params :email, :name, :is_active, :role, :ttf_id, :sttf_id, :personal_email, :present_address, :mobile_number,
                :alternate_contact, :permanent_address, :date_of_birth, :last_degree, :last_university, :passing_year,
                :emergency_contact_person_name, :emergency_contact_person_relation, :emergency_contact_person_number,
                :blood_group, :joining_date, :resignation_date, :is_published

  index do
    selectable_column
    id_column
    column :name
    column :role do |id|
      if id.role == User::EMPLOYEE
        'Employee'
      elsif id.role == User::TTF
        'TTF'
      elsif id.role == User::SUPER_TTF
        'Super TTF'
      else
        'Not assigned'
      end
    end
    column 'TTF' do |obj|
      (User.find obj.ttf_id).name if obj.ttf_id.present?
    end

    column 'Super TTF' do |obj|
      (User.find obj.sttf_id).name if obj.sttf_id.present?
    end

    column :is_active if
    actions
  end

  show do
    attributes_table :email, :name, :is_active, :role, :ttf_id, :sttf_id, :date_of_birth, :joining_date,
                     :resignation_date, :personal_email, :present_address, :mobile_number, :alternate_contact,
                     :permanent_address, :last_degree, :last_university, :passing_year, :emergency_contact_person_name,
                     :emergency_contact_person_relation, :emergency_contact_person_relation,  :emergency_contact_person_number
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :name
      f.input :is_active
      f.input :role, as: :select, collection: User::ROLES
      f.input :ttf_id, as: :select, collection: User.ttf
      f.input :sttf_id, as: :select, collection: User.super_ttf
      f.input :date_of_birth, start_year: 1970
      f.input :joining_date
      f.input :resignation_date
      f.input :personal_email
      f.input :present_address
      f.input :mobile_number
      f.input :alternate_contact
      f.input :permanent_address
      f.input :last_degree
      f.input :last_university
      f.input :passing_year
      f.input :emergency_contact_person_name
      f.input :emergency_contact_person_relation
      f.input :emergency_contact_person_relation
      f.input :emergency_contact_person_number
      f.input :is_published, input_html: { value: true }, as: :hidden
    end
    f.actions
  end

end
