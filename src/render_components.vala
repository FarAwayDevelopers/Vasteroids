using GLib;
using SDL;


class RenderComponent : Object {
    protected Entity *entity;

    public RenderComponent.with_entity(Entity *e) {
        entity = e;
    }

    public virtual void render(SDL.Renderer renderer) {

    }
}

class SpaceshipRenderComponent : RenderComponent {
    public SpaceshipRenderComponent.with_entity(Entity *e) {
        base.with_entity(e);
    }

    public override void render(SDL.Renderer renderer) {
        renderer.set_draw_color(250, 200, 0, 250);
        renderer.fill_rect({entity->x, entity->y, 100, 100}) ;

        renderer.set_draw_color(100, 200, 100, 250);
    }
}
