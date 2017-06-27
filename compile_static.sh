cd $phoenix_dir
cd assets
npm run build-elm
cd ..
mix "${phoenix_ex}.digest"
