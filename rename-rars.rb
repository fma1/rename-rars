#!/c/tools/ruby30/bin/ruby

# frozen_string_literal: true

$stdout.sync = true

RAR_EXTENSION = '.rar'

VIDEO_EXTENSION = ['mp4', 'wmv', 'mov', 'avi']

Dir.foreach('.') do |filename|
  next if !filename.start_with?('T.V.') || !filename.end_with?(RAR_EXTENSION)

  # cut removes first 54 characters
  new_filename = `7z l -ba #{filename} | cut -c54-`

  if VIDEO_EXTENSION.any? { |ext| new_filename.include?(ext) }
    new_filename = new_filename.slice(0..-6) << RAR_EXTENSION
    puts "Renaming " + filename + " to " + new_filename
  else
    puts "Not renaming " + filename + " to " + new_filename
  end

  File.rename(filename, new_filename)
end
