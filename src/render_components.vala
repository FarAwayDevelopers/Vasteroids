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
        Rect src = {0, 0, image.w, image.h};
        Rect dst = {entity->x, entity->y, image.w, image.h};

        int emx = entity->x + image.w/2;
        int emy = entity->y + image.h/2;

        int mox = (int) ((Spaceship*) entity)->mouseX;
        int moy = (int) ((Spaceship*) entity)->mouseY;

        double angle = Math.atan2(moy - emy, mox - emx);
        angle *= 180/Math.PI;
        angle += 90;

        renderer.copyex(
            Texture.from_surface(renderer, image),
            src, dst,
            angle, null,
            RendererFlip.NONE
        );
    }
}

class BackgroundRenderComponent : RenderComponent {
    public BackgroundRenderComponent.with_entity(Entity *e) {
        base.with_entity(e);
    }

    public void setTexture(string texPath) {
        image = load(texPath);
        if(image == null) {
            GLib.error("Image could not be loaded\n");
        }
    }

    public override void render(Renderer renderer) {
        Rect src = {0, 0, image.w, image.h};
        Rect dst;
        renderer.get_viewport(out dst);

        renderer.copy(
            Texture.from_surface(renderer, image),
            src, dst
        );
    }
}
