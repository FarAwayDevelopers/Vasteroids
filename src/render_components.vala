using GLib;
using SDL;


class RenderComponent : Object {
    public virtual void render(SDL.Renderer renderer) {

    }
}

class SceneRenderComponent : RenderComponent {
    public override void render(SDL.Renderer renderer) {
        renderer.set_draw_color(250, 200, 0, 250);
        renderer.fill_rect({100, 100, 300, 300}) ;

        renderer.set_draw_color(100, 200, 100, 250);
    }
}
