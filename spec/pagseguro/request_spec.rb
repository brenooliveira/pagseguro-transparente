require "spec_helper"

describe PagSeguro::Request do

  context "sandbox" do
    before do
      PagSeguro.environment = :sandbox
    end

    it { expect(PagSeguro::Request.new.sandbox_uri!).to eq "https://ws.sandbox.pagseguro.uol.com.br/v2/" }
  end

  context "production" do
    before do
      PagSeguro.environment = :producion

      it { expect(PagSeguro::Request.new.sandbox_uri!).to eq "https://ws.pagseguro.uol.com.br/v2/" }
    end
  end

end
