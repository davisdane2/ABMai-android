run in simulator

xcodebuild -scheme Dane -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 17' build &&
  xcrun simctl install booted "/Users/davisdane/Library/Developer/Xcode/DerivedData/Dane-eynxnhwwzbrhovarhqrlry
  yxxjte/Build/Products/Debug-iphonesimulator/ABM.ai.app" && xcrun simctl launch booted net.davisdane.abmai
  
  build for appstore connect
  
  xcodebuild archive \       
  -scheme Dane \                         
  -sdk iphoneos \      
  -configuration Release \               
  -archivePath ./build/ABM.ai.xcarchive  
  
  
  send to app store connect
  
  xcodebuild -exportArchive \
  -archivePath ./build/ABM.ai.xcarchive \
  -exportPath ./build \
  -exportOptionsPlist ExportOptions.plist
