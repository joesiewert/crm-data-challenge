require_relative '../data/crm'
require 'pp'

def all_employments(crm)
  result = []
  unless crm.empty?
    crm[:people].each do |person|
      person[:employments].each do |employment|
        crm[:companies].each do |company|
          if employment[:company_id] == company[:id]
            employment = {
              company_id: company[:id],
              company_name: company[:name],
              person_id: person[:id],
              person_first_name: person[:first_name],
              person_last_name: person[:last_name],
              title: employment[:title]
            }
            result << employment
          end
        end
      end
    end
  end
  result
end
#pp all_employments(CRM)

##################################################

require 'rspec/autorun'

RSpec.describe 'all_employments' do
  it 'returns an array of all employments' do
    crm_data = {
      :people => [
        {
          :id => 20,
          :first_name => "Savannah",
          :last_name => "Clementina",
          :employments =>
          [
            {
              :company_id => 4,
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
              :company_id => 6,
              :title => "Human Directives Engineer"
            }
          ]
        }
      ],
      :companies => [
        {
          :id => 4,
          :name => "Nicolas and Sons"
        },
        {
          :id => 6,
          :name => "Mueller LLC"
        }
      ]
    }

    expect(all_employments(crm_data)).to eq([
      {
        :company_id => 4,
        :company_name => "Nicolas and Sons",
        :person_id => 20,
        :person_first_name => "Savannah",
        :person_last_name => "Clementina",
        :title => "Chief Communications Consultant"
      },
      {
        :company_id => 6,
        :company_name => "Mueller LLC",
        :person_id => 46,
        :person_first_name => "Elyse",
        :person_last_name => "Jensen",
        :title => "Human Directives Engineer"
      },
    ])
  end

  it 'returns an empty array when given an empty hash' do
    expect(all_employments({})).to eq([])
  end
end
