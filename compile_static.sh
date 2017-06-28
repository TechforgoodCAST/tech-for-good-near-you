cd $phoenix_dir
cd assets
npm run build-elm && npm run deploy
cd ..
mix "${phoenix_ex}.digest"
