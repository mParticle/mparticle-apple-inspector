Pod::Spec.new do |spec|

  spec.name         = "mParticle-Apple-Inspector"
  spec.version      = "0.0.1"
  spec.summary      = "mParticle Apple inspector add-on for the mParticle Apple SDK."

  spec.description  = <<-DESC
  This SDK extends upon the mParticle SDK to allow users to inspect and debug mParticle activity live and on device.
  DESC

  spec.homepage     = "https://www.mparticle.com"

  spec.license      = { :type => 'Apache 2.0', :file => 'LICENSE'}
  spec.author       = { "mParticle" => "support@mparticle.com" }

  spec.source       = { :git => "https://git.corp.mparticle.com/mParticle/mparticle-apple-inspector.git", :tag => spec.version.to_s }
  spec.documentation_url = "https://docs.mparticle.com/developers/sdk/ios/"
  spec.social_media_url  = "https://twitter.com/mparticle"
  spec.requires_arc      = true
  spec.module_name       = "mParticle_Apple_Inspector"
  spec.ios.deployment_target  = "10.0"
  spec.swift_version     = '5.0'
  spec.preserve_paths    = 'MPInspector', 'MPInspector/**', 'MPInspector/**/*'

  spec.dependency 'mParticle-Apple-SDK/mParticle'
  spec.source_files      = 'MPInspector/**/*.{swift,xcassets}'
  spec.resources         = 'MPInspector/*.xcassets'

end
