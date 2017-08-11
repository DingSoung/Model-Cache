Pod::Spec.new do |s|
  s.name         = "ModelCache"
  s.version      = "0.1.2"
  s.source       = { :git => "https://github.com/DingSoung/Model-Cache.git", :tag => "#{s.version}" }
  s.source_files = "Model-Cache/*.swift"
  s.dependency  "Extension"
  s.summary      = "no summary"
  s.homepage     = "https://github.com/DingSoung"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Ding Songwen" => "DingSoung@gmail.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
end