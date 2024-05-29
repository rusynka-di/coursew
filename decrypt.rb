require 'cgi'
require 'json'
require 'active_support'
require 'active_support/core_ext'

def verify_and_decrypt_session_cookie(cookie, secret_key_base, session_key)
  cookie = CGI.unescape(cookie)
  salt = 'authenticated encrypted cookie'
  encrypted_cookie_cipher = 'aes-256-gcm'
  serializer = ActiveSupport::MessageEncryptor::NullSerializer
  key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
  secret = key_generator.generate_key(salt, ActiveSupport::MessageEncryptor.key_len(encrypted_cookie_cipher))
  encryptor = ActiveSupport::MessageEncryptor.new(secret, cipher: encrypted_cookie_cipher, serializer: serializer)

  # Відладжувальні повідомлення для перевірки ключів та куки
  puts "Secret Key: #{secret.unpack1('H*')}"
  puts "Cookie: #{cookie}"

  # Спроба розшифрувати куку
  encryptor.decrypt_and_verify(cookie, purpose: session_key)
end

puts "Отримання сесії в Rails 7.1.3 і пізніше"
puts
puts "Вставте куку, яку потрібно розшифрувати:"
cookie = gets.chomp
puts "Вставте секретний ключ:"
secret_key_base = gets.chomp
puts "Як називається ключ сесії?"
session_key = gets.chomp
begin
  result = verify_and_decrypt_session_cookie(cookie, secret_key_base, session_key)
  puts "Розшифрований результат: #{result.inspect}"
rescue => e
  puts "Помилка: #{e.message}"
  puts e.backtrace.join("\n")
end
