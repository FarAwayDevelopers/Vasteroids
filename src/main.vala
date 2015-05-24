using GLib;
using SDL;
using SDLGraphics;


class Vasteroids : Object {
    protected static SDL.Window window; // "double free or corruption" if this is not static -> wut?
    protected SDL.Renderer renderer;

    protected bool running = true;

    protected SceneView _map_view;

    public Vasteroids() {
        SDL.init(SDL.InitFlag.EVERYTHING|SDLImage.InitFlags.ALL);

        window = new Window(
            "Vasteroids",
            Window.POS_CENTERED, Window.POS_CENTERED,
            800, 600,
            WindowFlags.RESIZABLE
        );
        renderer = new SDL.Renderer(
            window, -1,
            SDL.RendererFlags.ACCELERATED|SDL.RendererFlags.PRESENTVSYNC
        );

        window.show();
    }

    public void run() {
        initScene();

        while(running) {
            handleEvents();
            update();
            render();

            SDL.Timer.delay(10);
        }

        window.destroy();
        SDL.quit();
    }

    private void initScene() {
        int window_width, window_height;
        window.get_size(out window_width, out window_height);

        _map_view = new SceneView();
        _map_view.setRenderer(renderer);


        Spaceship spaceship = new Spaceship.with_coordinates(window_width/2, window_height/2);

        Background bg = new Background.with_texture("assets/background.png");
        bg.z = 10;
        spaceship.notify["x"].connect((source, param) => {
            bg.viewportOffsetX = ((Entity) source).x;
            bg.viewportOffsetY = ((Entity) source).y;
        });

        Background mg = new Background.with_texture("assets/midground.png");
        mg.z = 5;
        spaceship.notify["x"].connect((source, param) => {
            mg.viewportOffsetX = ((Entity) source).x;
            mg.viewportOffsetY = ((Entity) source).y;
        });


        _map_view.addEntity(bg);
        _map_view.addEntity(mg);
        _map_view.addEntity(spaceship);
    }

    private void handleEvents() {
        Event e;
        while(Event.poll(out e) == 1) {
            switch(e.type) {
                case EventType.QUIT:
                    running = false;
                    break;
                default:
                    if(_map_view.handle(e)) break;
                    break;
            }
        }
    }

    private void render() {
        renderer.clear();

        _map_view.render();

        renderer.present();
        window.update_surface();
    }

    private void update() {
        _map_view.update();
    }
}

int main(string[] args) {
    Vasteroids game = new Vasteroids();
    game.run();

    return 0;
}
