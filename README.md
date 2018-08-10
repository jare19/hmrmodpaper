# Docker Build for my resume container
Uses hackmyresume with PDF support and a modded version of the jsonresume theme paper
`docker run --rm -v ${PWD}:/resume jare19/hmrmodpaper:latest build goldenmodpaper.json TO static/resume.all -t /hmrmodpaper/node_modules/jsonresume-theme-modpaper`