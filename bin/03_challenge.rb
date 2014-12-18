require_relative '../data/crm'
require 'pp'

def no_employments(crm)
  result = []
  unless crm.empty?
    crm[:people].each do |person|
      if person[:employments].empty?
        unemployed_person = {
          id: person[:id],
          first_name: person[:first_name],
          last_name: person[:last_name],
        }
        result << unemployed_person
      end
    end
  end
  result
end
#pp no_employments(CRM)

##################################################

require 'rspec/autorun'

RSpec.describe 'no_employments' do
  it 'returns an array of unemployed people' do
    crm_data = {
      :people => [
        {
          :id => 20,
          :first_name => "Savannah",
          :last_name => "Clementina",
          :employments => []
        },
        {
          :id => 46,
          :first_name => "Elyse",
          :last_name => "Jensen",
          :employments => []
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

    expect(no_employments(crm_data)).to eq([
      {
        :id => 20,
        :first_name => "Savannah",
        :last_name => "Clementina"
      },
      {
        :id => 46,
        :first_name => "Elyse",
        :last_name => "Jensen",
      }
    ])
  end

  it 'returns an empty array when given an empty hash' do
    expect(no_employments({})).to eq([])
  end
end
