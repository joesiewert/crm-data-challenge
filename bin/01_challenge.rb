require_relative '../data/crm'
require 'pp'

def employees_of_companies(crm)
  result = []
  unless crm.empty?
    crm[:companies].each do |company|
      employees = []
      crm[:people].each do |person|
        person[:employments].each do |employment|
          if employment[:company_id] == company[:id]
            employee = {
              id: person[:id],
              first_name: person[:first_name],
              last_name: person[:last_name],
              title: employment[:title]
            }
            employees << employee
          end
        end
      end
      result << {name: company[:name], employees: employees}
    end
  end
  result
end
#pp employees_of_companies(CRM)

##################################################

require 'rspec/autorun'

RSpec.describe 'employees_of_companies' do
  it 'returns an array of employees of companies' do
    crm_data = {
      :people => [
        {
          :id => 20,
          :first_name => "Savannah",
          :last_name => "Clementina",
          :employments =>
          [
            {
              :company_id => 0,
              :title => "Chief Communications Consultant"
            }
          ]
        },
        {
          :id => 46,
          :first_name => "Elyse",
          :last_name => "Jensen",
          :employments =>
          [
            {
              :company_id => 0,
              :title => "Human Directives Engineer"
            }
          ]
        }
      ],
      :companies => [
        {
          :id => 0,
          :name => "Nicolas and Sons"
        }
      ]
    }

    expect(employees_of_companies(crm_data)).to eq([
      {
        name: "Nicolas and Sons",
        employees: [
          {
            :id => 20,
            :first_name => "Savannah",
            :last_name => "Clementina",
            :title => "Chief Communications Consultant"
          },
          {
            :id => 46,
            :first_name => "Elyse",
            :last_name => "Jensen",
            :title => "Human Directives Engineer"
          },
        ]
      }
    ])
  end

  it 'returns an empty array when given an empty hash' do
    expect(employees_of_companies({})).to eq([])
  end
end
