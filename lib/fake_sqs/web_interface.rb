require 'sinatra/base'

module FakeSQS
  class WebInterface < Sinatra::Base

    configure do
      use FakeSQS::CatchErrors, response: ErrorResponse
    end

    helpers do

      def action
        params.fetch("Action")
      end

    end

    get "/" do
      200
    end

    delete "/" do
      settings.sqs.reset
      200
    end

    put "/" do
      settings.sqs.expire
      200
    end

    post "/" do
      settings.sqs.call(action, params)
    end

    post "/:queue" do |queue|
      settings.sqs.call(action, queue, params)
    end

  end
end
