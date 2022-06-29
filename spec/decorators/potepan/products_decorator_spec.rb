# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Potepan::ProductsDecorator do
  let(:products) { Potepan::Products.new.extend Potepan::ProductsDecorator }
  subject { products }
  it { should be_a Potepan::Products }
end
