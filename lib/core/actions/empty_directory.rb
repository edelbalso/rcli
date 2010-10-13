class Rcli
  module Actions

    # Creates an empty directory.
    #
    # ==== Parameters
    # destination<String>:: the relative path to the destination root.
    # config<Hash>:: give :verbose => false to not log the status.
    #
    # ==== Examples
    #
    #   empty_directory "doc"
    #
    def empty_directory(destination, config={})
      go EmptyDirectory.new(destination)
    end

    # Class which holds create directory logic. This is the base class for
    # other actions like create_file and directory.
    #
    # This implementation is based in Templater actions, created by Jonas Nicklas
    # and Michael S. Klishin under MIT LICENSE.
    #
    class EmptyDirectory #:nodoc:
      attr_reader :destination, :given_destination, :relative_destination

      # Initializes given the source and destination.
      #
      # ==== Parameters
      # base<Thor::Base>:: A Thor::Base instance
      # source<String>:: Relative path to the source of this file
      # destination<String>:: Relative path to the destination of this file
      # config<Hash>:: give :verbose => false to not log the status.
      #
      def initialize(destination)
        @destination = destination
      end

      # Checks if the destination folder already exists.
      #
      # ==== Returns
      # Boolean:: true if the folder exists, false otherwise.
      #
      def exists?
        ::File.exists?(destination)
      end

      def create
        if exists?
          return false;
        else
          ::FileUtils.mkdir_p(@destination)
        end

      end
      
      def revoke!
        say_status :remove, :red
        ::FileUtils.rm_rf(destination) if !pretend? && exists?
        given_destination
      end

      protected

        # Shortcut for pretend.
        #
        def pretend?
          base.options[:pretend]
        end

        # Filenames in the encoded form are converted. If you have a file:
        #
        #   %class_name%.rb
        #
        # It gets the class name from the base and replace it:
        #
        #   user.rb
        #
        def convert_encoded_instructions(filename)
          filename.gsub(/%(.*?)%/) do |string|
            instruction = $1.strip
            base.respond_to?(instruction) ? base.send(instruction) : string
          end
        end

    end
  end
end
