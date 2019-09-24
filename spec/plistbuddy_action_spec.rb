# require 'fastlane'

describe Fastlane::Actions::PlistbuddyGetAction do
  describe '#run' do
    it 'run' do
      # expect(Fastlane::UI).to receive(:message).with("The plistbuddy plugin is working!")

      expect(Fastlane::Actions::PlistbuddyGetAction.run(
        plist: 'spec/test.plist',
        key: ':aps-environment'
      )).to(eq("development\n"))
      
      expect(Fastlane::Actions::PlistbuddyGetAction.run(
        plist: 'spec/test.plist',
        key: ':persons:0'
      )).to(eq("person001\n"))

      expect(Fastlane::Actions::PlistbuddyGetAction.run(
        plist: 'spec/test.plist',
        key: ':persons:2'
      )).to(eq("person003\n"))

      # pp "\n sdf \n asdfse \n"
      # pp "\n sdf \n asdfse \n".strip
      # pp "\n sdf \n asdfse \n".chomp
    end
  end
end

describe Fastlane::Actions::PlistbuddyDeleteAction do
  describe '#run' do
    it 'run' do
      Fastlane::Actions::PlistbuddyDeleteAction.run(
        plist: 'spec/test.plist',
        key: ':aps-environment'
      )

      # expect(Fastlane::Actions::PlistbuddyGetAction.run(
      #   plist: 'spec/test.plist',
      #   key: ':aps-environment'
      # )).to(eq("development\n"))
    end
  end
end