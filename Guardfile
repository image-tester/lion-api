# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: 'spring rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb') { 'spec' }

  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/api/(.+)_(controller)\.rb$})  { |m| ["spec/requests/#{m[1]}_spec.rb"] }
end
