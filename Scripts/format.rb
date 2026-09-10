#!/usr/bin/env ruby

require 'pathname'

root = Pathname.new(__dir__).parent
Dir.chdir(root) do
  sources = Dir.glob('CineTrack/CineTrack/{App,Packages/**/Sources}/**/*.swift')
    .reject { |path| path.include?('/.build/') }
  manifests = Dir.glob('CineTrack/CineTrack/Packages/{*,Features/*}/Package.swift')
  files = (sources + manifests).sort

  abort 'Swift formatting failed.' unless system(
    'xcrun', 'swift-format', 'format', '--in-place', '--configuration', '.swift-format', *files
  )

  # Match the brace and comment spacing already enforced by the Home project.
  swiftlint = ENV.fetch('SWIFTLINT_PATH', '/opt/homebrew/bin/swiftlint')
  abort 'SwiftLint is required; set SWIFTLINT_PATH to its executable.' unless File.executable?(swiftlint)
  abort 'SwiftLint formatting failed.' unless system(
    swiftlint, 'lint', '--fix', '--quiet', '--no-cache',
    '--config', 'CineTrack/CineTrack/.swiftlint.yml',
    '--only-rule', 'opening_brace', '--only-rule', 'closure_parameter_position',
    '--only-rule', 'comment_spacing', '--only-rule', 'trailing_semicolon', *files
  )
  puts "Formatted #{files.count} Swift source and manifest files; tests were not modified."
end
