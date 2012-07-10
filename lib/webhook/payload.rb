require 'virtus'
require 'pathname'
require 'uri'
require 'multi_json'

module Virtus
  class Coercion
    class String < Virtus::Coercion::Object
      def self.to_pathname(value)
        Pathname.new(value)
      end

      def self.to_uri(value)
        URI.parse(value)
      end
    end
  end
end

module Webhook
  class Payload
    include Virtus

    def self.from_json(json)
      new(MultiJson.load(json))
    end

    module User
      include Virtus

      attribute :email, String
      attribute :name, String
    end

    class URI < Virtus::Attribute::Object
      primitive String
      coercion_method :to_uri
    end

    class Commit
      include Virtus

      class Author
        include User
      end

      class Pathname < Virtus::Attribute::Object
        primitive String
        coercion_method :to_pathname
      end

      attribute :id, String
      attribute :url, URI
      attribute :message, String
      attribute :timestamp, Time
      attribute :added, Array[Pathname], :default => []
      attribute :modified, Array[Pathname], :default => []
      attribute :removed, Array[Pathname], :default => []
      attribute :author, Author
    end

    class Repository
      include Virtus

      class Owner
        include User
      end

      attribute :url, URI
      attribute :name, String
      attribute :homepage, String
      attribute :pledgie, String
      attribute :description, String
      attribute :watchers, Integer
      attribute :forks, Integer
      attribute :private, Boolean
      attribute :owner, Owner
    end

    attribute :before, String
    attribute :after, String
    attribute :ref, String
    attribute :repository, Repository
    attribute :commits, Array[Commit]
  end
end