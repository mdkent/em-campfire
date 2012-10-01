require 'spec_helper'

def valid_user_cache_data
  {123 => {"name" => "foo"}, 456 => {"name" => "bar"}, 'me' => {"name" => "bot", "id" => 123}}
end

def stub_user_data_request(user_id, response_code = 200)
  body = response_code == 200 ? Yajl::Encoder.encode(:user => valid_user_cache_data[user_id]) : ""
  stub_request(:get, "https://#{valid_params[:subdomain]}.campfirenow.com/users/#{user_id}.json").
    with(:headers => {'Authorization'=>['6124d98749365e3db2c9e5b27ca04db6', 'X'], 'Content-Type'=>'application/json'}).
    to_return(:status => response_code, :body => body, :headers => {:ETag => etag_for_data(valid_user_cache_data[user_id])})
end

def stub_timeout_user_data_request(user_id)
  stub_request(:get, "https://#{valid_params[:subdomain]}.campfirenow.com/users/#{user_id}.json").
    with(:headers => {'Authorization'=>['6124d98749365e3db2c9e5b27ca04db6', 'X'], 'Content-Type'=>'application/json'}).
    to_timeout
end