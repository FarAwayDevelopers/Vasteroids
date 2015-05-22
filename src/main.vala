using GLib;
using SDL;


class Vasteroids : Object {
    protected static SDL.Window window; // "double free or corruption" if this is not static -> wut?
    protected SDL.Renderer renderer;

    protected bool running = true;

    protected View _map_view;

    public Vasteroids() {
        SDL.init(SDL.InitFlag.EVERYTHING| SDLImage.InitFlags.ALL);

        window = new Window(
            "Vasteroids",
            Window.POS_CENTERED, Window.POS_CENTERED,
            800, 600,
            WindowFlags.RESIZABLE
        );
        renderer = new SDL.Renderer(
            window, -1,
            SDL.RendererFlags.ACCELERATED | SDL.RendererFlags.PRESENTVSYNC
        );

        window.show();
    }

    public void run() {
        initScene();

        while(running) {
            handleEvents();
            render();

            SDL.Timer.delay(10);
        }

        window.destroy();
        SDL.quit();
    }

    private void initScene() {
        _map_view = new SceneView();
        _map_view.setRenderer(renderer);
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
}

int main(string[] args) {
    Vasteroids game = new Vasteroids();
    game.run();

    return 0;
}
