Pod::Spec.new do |s|

  s.name          = "Combinations"
  s.version       = "1.0.1"
  s.summary       = "Blazingly fast test generator suited for boundary and brute force testing."

  s.description   = <<-DESC
                      Combinations is an iOS testing utility framework suited for fast boundary testing. 
                      It gets a set of input test data values and transforms it in run-time tests for each generated combination of values.
                    DESC


  s.homepage              = "https://github.com/alexmx/Combinations"
  s.license               = "MIT"
  s.authors               = "Alex Maimescu"

  s.platform              = :ios
  s.ios.deployment_target = '8.0'

  s.source                = { :git => "https://github.com/alexmx/Combinations.git", :tag => "v#{s.version}" }
  s.source_files          = "Combinations/**/*.{h,m,swift}"

  s.libraries             = 'xml2', 'z'

  s.framework = "XCTest"
  s.requires_arc = true
  s.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }

end
