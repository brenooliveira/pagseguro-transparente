require 'nokogiri'
require 'open-uri'

module PagSeguro
  class Sender
    include ActiveModel::Validations
    extend Forwardable

    def_delegators :document, :value
    def_delegators :phone, :area_code, :number

    validates_presence_of :email, :name, :hash_id, :document, :phone

    # Set the sender e-mail.
    attr_accessor :email

    # Set the sender name.
    attr_accessor :name

    # Set the hash identifier.
    attr_accessor :hash_id

    # Set the CPF document.
    attr_accessor :document

    # Get the sender phone.
    attr_accessor :phone

    def initialize(options = {})
      @email = options[:email]
      @name = options[:name]
      @hash_id = options[:hash_id] || discover_hash
    end

    private
      def discover_hash
        page = Nokogiri::HTML(open("https://sandbox.pagseguro.uol.com.br/checkout/direct-payment/i-ck.html"))
        page.css("input#senderTrackingHash")
      end
  end
end
