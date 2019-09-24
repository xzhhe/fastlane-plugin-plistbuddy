require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class PlistbuddyHelper
      # class methods that you define here become available in your action
      # as `Helper::PlistbuddyHelper.your_method`
      #

      def self.get(plistbuddy, plist, options = {})
        key = options[:key]
        exec = options[:exec]
        UI.message("🚙  plist get #{key}...")

        cmd = if key
          "#{plistbuddy} -c \"print #{key}\" #{plist}"
        else
          "#{plistbuddy} -c \"print\" #{plist}"
        end

        `#{cmd}`
      end

      def self.delete(plistbuddy, plist, options = {})
        key = options[:key]

        # delete 删除 plsit[Version]
        # /usr/libexec/PlistBuddy -c 'Delete :Version' test.plist
        
        # delete 删除 plsit[persons][0]
        # /usr/libexec/PlistBuddy -c 'Delete :persons:0' test.plist

        UI.message("🚗  plist delete #{key}...")
        Actions.sh("#{plistbuddy} -x -c \"delete #{key}\" #{plist}")
      end

      def self.set(plistbuddy, plist, options = {})
        key = options[:key]
        value = options[:value]
        UI.message("🚕  plist set #{value} for #{key}...")

        type = if value.is_a?(String)
          'string'
          ##=> PlistBuddy -c 'Set :persons:1 string "hahahaha"' info.plist
          ##=> 
        # elsif value.is_a?(Array)
        #   'array' 
          ##=> PlistBuddy -x -c "Add :persons:1 string 'xxxxx'" spec/test.plist
          ##=> PlistBuddy -c "clear dict" -c "add :CFBundleURLTypes array" -c "add :CFBundleURLTypes:0 dict" -c "add :CFBundleURLTypes:0:CFBundleURLName string 'urlname-1'" -c "add :CFBundleURLTypes:0:CFBundleURLSchemes array" -c "add :CFBundleURLTypes:0:CFBundleURLSchemes:0 string urlscheme-1"  Info.plist
        # elsif value.is_a?(Hash)
        #   'dict' #=> 
        # elsif !!value == value
        #   'bool'
        # elsif value.is_a?(Integer)
        #   'integer'
        else
          UI.user_error!("❌  value not support")
        end
        
        # set/add key : string value
        # PlistBuddy -c 'Set :name "xiongzenghui"' info.plist

        # add key : array value
        # 1. 添加一个 key, value 类型为 array
        # /usr/libexec/PlistBuddy -c 'Add :AppArr array' test.plist
        # 2. 添加 value 值 app1 、app2
        # /usr/libexec/PlistBuddy -c 'Add :AppArr: string app1' test.plist
        # /usr/libexec/PlistBuddy -c 'Add :AppArr: string app2' test.plist

        # add key : dict value
        # 1. 添加 key , value 类型为 dict
        # /usr/libexec/PlistBuddy -c 'Add :AppDic dict' test.plist
        # 2. 添加 value 值 name 、age
        # /usr/libexec/PlistBuddy -c 'Add :AppDic:name string Tom' test.plist
        # /usr/libexec/PlistBuddy -c 'Add :AppDic:age string 100' test.plist

        # set 修改 array 类型. 修改 AppArr 字段中数组的第0个值.
        # /usr/libexec/PlistBuddy -c 'Set :AppArr:0 "this is app1"' test.plist

        # set 修改 dict 类型. 修改 AppDic 字段中 name 的值
        # /usr/libexec/PlistBuddy -c 'Set :AppDic:name "Jim"' test.plist

        Actions.sh("#{plistbuddy} -x -c \"Set #{key} #{value}\" #{plist}")
      end
    end
  end
end
