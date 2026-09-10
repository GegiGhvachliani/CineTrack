#!/usr/bin/env ruby

require 'pathname'

root = Pathname.new(__dir__).parent
sources = Dir.glob(root.join('CineTrack/CineTrack/{App,Packages/**/Sources}/**/*.swift').to_s)
sources.reject! { |path| path.include?('/.build/') || path.include?('/Preview/') || path.include?('PreviewData') }
failures = []
source_text = sources.to_h { |path| [path, File.read(path)] }

source_text.each do |path, source|
  relative = Pathname.new(path).relative_path_from(root).to_s

  if path.match?(%r{/\w+Domain/})
    source.scan(/^import (\w+)/).flatten.each do |dependency|
      if dependency.match?(/Data$|Presentation|Networking|Storage|Auth$|UIKit|SwiftUI|Observation/)
        failures << "#{relative}: Domain imports #{dependency}"
      end
    end
  end

  if path.match?(%r{/\w+Presentation/})
    source.scan(/^import (\w+)/).flatten.each do |dependency|
      if dependency.match?(/Data$|Networking|Storage|SharedAuth|Firebase/)
        failures << "#{relative}: Presentation imports #{dependency}"
      end
    end
  end

  if path.match?(%r{/\w*ViewModels/})
    failures << "#{relative}: ViewModel depends on a repository" if source.match?(/\b\w*Repository(?:Protocol)?\b/)
    failures << "#{relative}: ViewModel constructs a use case" if source.match?(/\b[A-Z]\w*UseCase\(/)
    failures << "#{relative}: ViewModel contains provider access" if source.match?(/URLSession|Firebase|Auth\.auth|sendRequest/)
  end

  source.scan(/(?:class|struct) (\w+(?:ViewModel|Coordinator|Factory|DIContainer))\s*:\s*([^\{]+)/).each do |name, conformances|
    next if name.start_with?('Mock', 'Preview')
    failures << "#{relative}: #{name} has no own protocol" unless conformances.include?("#{name}Protocol")
  end

  if path.match?(%r{/Repositories/}) && source.match?(/Auth\.auth\(|Firestore\.firestore\(|URLSession\.shared/)
    failures << "#{relative}: Repository accesses a concrete provider"
  end

  source.scan(/(?:class|struct) (\w+(?:UseCase|Repository))\s*(?::\s*([^\{]+))?\{/).each do |name, conformances|
    unless conformances.to_s.match?(/(?:UseCase|Repository)Protocol/)
      failures << "#{relative}: #{name} has no domain protocol"
    end
  end

  if path.match?(%r{/\w*Views/}) && source.match?(/(?:var|let) viewModel: \w+ViewModel\b/)
    failures << "#{relative}: View depends on a concrete ViewModel"
  end
end

Dir.glob(root.join('CineTrack/CineTrack/Packages/Features/*').to_s).each do |feature|
  name = File.basename(feature)
  presentation = File.join(feature, 'Sources', "#{name}Presentation")
  next if Dir.glob(File.join(presentation, '**', '*.swift')).empty?
  strings = Dir.glob(File.join(presentation, '**', "#{name}Strings.swift"))
  failures << "#{name}: missing screen strings" if strings.empty?
end

Dir.glob(root.join('CineTrack/CineTrack/Packages/{*,Features/*}/Package.swift').to_s).each do |manifest|
  File.read(manifest).scan(/\.package\(path: "([^"]+)"/).flatten.each do |dependency|
    target = File.expand_path(File.join(dependency, 'Package.swift'), File.dirname(manifest))
    failures << "#{manifest}: missing package at #{dependency}" unless File.file?(target)
  end
end

if failures.empty?
  puts "Architecture checks passed (#{sources.count} source files)."
else
  warn failures.join("\n")
  exit 1
end
