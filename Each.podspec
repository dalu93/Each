Pod::Spec.new do |s|
    s.name = 'Each'
    s.version = '1.0.1'
    s.license = 'MIT'
    s.summary = 'Elegant NSTimer interface in Swift'
    s.homepage = 'https://github.com/dalu93/Each'
    s.social_media_url = 'https://twitter.com/DAlbertiLuca'
    s.authors = { 'dalu93' => 'dalberti.luca93@gmail.com' }
    s.source = { :git => 'https://github.com/dalu93/Each.git', :tag => s.version }

    s.ios.deployment_target = '8.0'
    s.osx.deployment_target = '10.10'
    s.tvos.deployment_target = '9.0'
    s.watchos.deployment_target = '2.0'

    s.source_files = 'Sources/*.swift'
end
