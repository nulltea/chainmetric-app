bind-android:
	gomobile bind --target=android \
		-o=../talos/android/src/main/libs/lorkhan.aar \
		./bind/fabric \
		./bind/plugins \
		./bind/events
	cp ../talos/android/src/main/libs/* ../heimdall/android/app/src/main/libs/

bind-ios:
	gomobile bind --target=ios \
		-o=../talos/ios/libs/lorkhan.framework \
		./bind/fabric \
		./bind/plugins \
		./bind/events
