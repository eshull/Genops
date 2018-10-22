require 'rails_helper'

describe SystemNode do
  it { have_and_belong_to_many :system_nodes }
end
