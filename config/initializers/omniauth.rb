OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '	440326792748967', 'ea41ea5f08a5936ffd00102e41e25da5',
           :scope => 'email,user_birthday,read_stream'
end