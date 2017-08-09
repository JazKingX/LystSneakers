# Uncomment this line to define a global platform for your project
platform :ios, '8.2'
# Uncomment this line if you're using Swift
use_frameworks!

# Define main pods.
def main_pods
    #Your common pods here
    pod 'SwiftyJSON'
    pod 'Kingfisher', '~> 3.0'
    pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift3'
end

target 'LystNetwork' do
    
    main_pods
    pod 'Alamofire', '4.4.0'

end

target 'LystSneakers' do
    main_pods
    #add here other pods specific for this target
end


target 'LystSneakersTests' do
    main_pods
    #add here other pods specific for this target
end

target 'LystSneakersUITests' do
    main_pods
    #add here other pods specific for this target
end
