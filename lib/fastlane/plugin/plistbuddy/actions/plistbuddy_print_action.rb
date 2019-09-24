require 'fastlane/action'
require_relative '../helper/plistbuddy_helper'

module Fastlane
  module Actions
    class PlistbuddyPrintAction < Action
      def self.run(params)
        plist = params[:plist]
        plistbuddy = params[:plistbuddy]

        Helper::PlistbuddyHelper.get(plistbuddy, plist)
      end

      def self.description
        "wrapper for a tool provided by Apple to perform operations on a plist file using bash commands\n
        https://marcosantadev.com/manage-plist-files-plistbuddy"
      end

      def self.authors
        ["xiongzenghui"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        "wrapper for a tool provided by Apple to perform operations on a plist file using bash commands"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :plist,
            description: "xx.plist filepath. eg: /path/to/info.plist or /path/to/info.entitlements all plist format file",
            type: String,
            verify_block: proc do |value|
              UI.user_error!("❌ plist not pass") unless (value and not value.empty?)
              UI.user_error!("❌ plist not exist") unless File.exist?(value)
            end
          ),
          FastlaneCore::ConfigItem.new(
            key: :plistbuddy,
            description: "plistbuddy executable filepath",
            type: String,
            optional: true,
            default_value: '/usr/libexec/PlistBuddy'
          )
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
