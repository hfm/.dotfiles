require "spec_helper"

describe "font" do
  describe package('ricty') do
    it { should be_installed }
  end

  describe package('font-lato') do
    it { should be_installed.by("homebrew_cask") }
  end
end
