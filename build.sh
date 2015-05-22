valac \
    --pkg gee-0.8 \
    --pkg sdl2 \
    --pkg sdl2-gfx \
    --pkg sdl2-ttf \
    --pkg sdl2-image \
    --pkg sdl2-mixer \
    -X -lSDL2_image \
    -X -lSDL2_ttf \
    -X -lSDL2_mixer \
    -X -lSDL2_gfx \
    -o "vasteroids" \
    $(find src/ -name "*.vala" | xargs)
