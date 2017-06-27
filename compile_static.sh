cd $phoenix_dir
cd assets
npm run build-elm
mix "${phoenix_ex}.digest"
