# frozen_string_literal: true

require_relative '../app/helpers/movies_helper'

describe 'MoviesHelper test' do
  include MoviesHelper
  describe 'oddness' do
    it 'should be defined' do
      expect{oddness(8)}.not_to raise_error
    end
    it 'should return odd on 3' do
      expect(oddness(3)).to eq("odd")
    end
    it 'should return even on 8' do
      expect(oddness(8)).to eq("even")
    end
  end
end
