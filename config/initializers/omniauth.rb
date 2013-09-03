OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '	180726242006939', '409c0745a124ca7ef76c87432a8dbc39',
           :scope => 'email,user_birthday,read_stream'
end