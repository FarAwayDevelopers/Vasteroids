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
        int ex = ((Spaceship *) entity)->renderX;
        int ey = ((Spaceship *) entity)->renderY;

        Rect src = {0, 0, image.w, image.h};
        Rect dst = {ex, ey, image.w, image.h};

        int emx = ex + image.w/2;
        int emy = ey + image.h/2;

        int mox = (int) ((Spaceship*) entity)->mouseX;
        int moy = (int) ((Spaceship*) entity)->mouseY;

        ((Spaceship*) entity)->angle = Math.atan2(moy - emy, mox - emx) * 180/Math.PI + 90;

        renderer.copyex(
            Texture.create_from_surface(renderer, image),
            src, dst,
            ((Spaceship*) entity)->angle, null,
            RendererFlip.NONE
        );
    }
}

class BackgroundRenderComponent : RenderComponent {
    private int sectorWidth { get; set; default = 100; }
    private int sectorHeight { get; set; default = 100; }


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
        int vox = ((Background*) entity)->viewportOffsetX / ((Background*) entity)->z;
        int voy = ((Background*) entity)->viewportOffsetY / ((Background*) entity)->z;

        Rect src = {vox, voy, sectorWidth, sectorHeight};
        Rect dst;
        renderer.get_viewport(out dst);

        renderer.copy(
            Texture.create_from_surface(renderer, image),
            src, dst
        );
    }
}
