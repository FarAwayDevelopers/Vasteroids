using GLib;
using SDL;
using SDLImage;


class RenderComponent : Object {
    protected Entity *entity;
    protected Surface image;

    public RenderComponent.with_entity(Entity *e) {
        entity = e;
    }

    public virtual void render(Renderer renderer) {

    }
}

class SpaceshipRenderComponent : RenderComponent {
    public SpaceshipRenderComponent.with_entity(Entity *e) {
        base.with_entity(e);

        image = load("assets/spaceship.png");
        if(image == null) {
            GLib.error("Image could not be loaded\n");
        }
    }

    public override void render(Renderer renderer) {
        //Rect src = {0, 0, 100, 100};
        Rect dst = {entity->x, entity->y, 100, 100};

        renderer.copy(Texture.from_surface(renderer, image), null, dst);
    }
}
