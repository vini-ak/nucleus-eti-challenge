./commit.sh $1 $2

cd app/
flutter build apk --split-per-abi --obfuscate --split-debug-info=/app/build/app/outputs/apk/release/